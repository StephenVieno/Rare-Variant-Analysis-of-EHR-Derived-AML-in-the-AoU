# -------------------------------------------------------------------------
# PACAKGES
# -------------------------------------------------------------------------

# Load packages
library(tidyverse)
library(data.table)
library(purrr)
library(ggplot2)
library(biomaRt)
library(stringr)
library(CAESAR.Suite)

# -------------------------------------------------------------------------
# PLOT SET UP 
# -------------------------------------------------------------------------

# Set colors for plot
my_cols <- colorRampPalette(c(
  "#F7AA14FF",
  "#F5D000FF",
  "#F7E690FF",
  "#1BB6AFFF",
  "#088BBEFF",
  "#172869FF"
))(10)

# Plot the top 10 significant genes across different MAGMA window thresholds
folder_path <-
  "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/MAGMA"
plot_path <-
  "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/Plots"

# -------------------------------------------------------------------------
# MAGMA GENE WINDOWS
# -------------------------------------------------------------------------

# Loop through MAGMA files to create a dataframe of p-values at different MAGMA window thresholds
files <- list()
for (window in 0:10) {
  upstream <- window * 10
  downstream <- window * 5
  file <-
    fread(
      paste0(
        folder_path,
        '/aml_upstream',
        upstream,
        '_downstream',
        downstream,
        '_deprivation_index.genes.out'
      )
    )
  file <-
    file %>%
    as.data.frame() %>%
    dplyr::select(GENE, P) %>%
    rename(!!paste0('Upstream ', upstream, 'kb, Downstream ', downstream, 'kb') := P)
  files[[window + 1]] <- file
}
genes <- reduce(files, full_join, by = c("GENE"))

# Assign HGNC gene symbols to genes
mart <-
  useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
gene_map <- getBM(
  attributes = c("entrezgene_id", "hgnc_symbol"),
  filters = "entrezgene_id",
  values = unique(genes$GENE),
  mart = mart
)
colnames(gene_map) <- c("GENE", "SYMBOL")
gene_map$GENE <- as.character(gene_map$GENE)

# Calculate Cauchy p-values for each gene
genes_cauchy <-
  genes %>%
  mutate(GENE = as.character(GENE)) %>%
  pivot_longer(!c("GENE")) %>%
  mutate(value = as.numeric(value)) %>%
  filter(value > 0 | value < 1) %>%
  group_by(GENE) %>%
  summarize(Cauchy_P = as.numeric(Cauchy.Combination(value))) %>%
  arrange(Cauchy_P)

genes_cauchy$bonferroni_p <-
  p.adjust(genes_cauchy$Cauchy_P, method = 'bonferroni')

genes_cauchy <-
  genes_cauchy %>%
  full_join(gene_map, by = "GENE") %>%
  dplyr::select(-GENE) %>%
  rename("GENE" = "SYMBOL")

genes_cauchy <- as.data.frame(genes_cauchy)
colnames(genes_cauchy)[1] <-"cauchy_p"
colnames(genes_cauchy)[3] <-"gene"

write_tsv(
  genes_cauchy,
  paste0(
    folder_path,
    "/aml_genes_window_deprivation_index_cauchy_pvalues.tsv"
  )
)

# Plot the top 10 significant genes across different MAGMA window thresholds
genes <-
  genes %>%
  mutate(GENE = as.character(GENE)) %>%
  full_join(gene_map, by = "GENE") %>%
  dplyr::select(-GENE) %>%
  rename("GENE" = "SYMBOL") %>%
  pivot_longer(!c("GENE"))

ordered_names <- unique(genes$name)[order(as.numeric(sub(
  "Upstream (\\d+)kb.*", "\\1", unique(genes$name)
)))]

sign_pvalue <- -log10(0.05 / nrow(genes))

top_sign_gene_sets <-
  genes %>%
  mutate(Neg_Log_Pvalue = -log10(value)) %>%
  arrange(desc(Neg_Log_Pvalue)) %>%
  distinct(GENE) %>%
  slice_head(n = 10)

plot <-
  genes %>%
  mutate(Neg_Log_Pvalue = -log10(value)) %>%
  mutate(name = factor(name, levels = ordered_names)) %>%
  filter(GENE %in% top_sign_gene_sets$GENE) %>%
  mutate(GENE = gsub('_', ' ', GENE)) %>%
  ggplot(aes(x = name,
             y = Neg_Log_Pvalue,
             group = GENE)) +
  geom_line(aes(color = GENE), size = 2) +
  geom_point() +
  geom_hline(yintercept = sign_pvalue,
             size = 1,
             linetype = "dashed") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title.x = element_blank()) +
  labs(color = "Genes", y = "Negative Log P-values (-log10(p-value))") +
  scale_color_manual(values = rev(my_cols))

ggsave(paste0(plot_path,
              "/aml_genes_window_deprivation_index_plot.png"),
       plot = plot,
       width = 20,
       height = 6)

# -------------------------------------------------------------------------
# MAGMA GENE SETS
# -------------------------------------------------------------------------

# Loop through MAGMA files to create a dataframe of p-values at different MAGMA window thresholds
files <- list()
for (window in 0:10) {
  upstream <- window * 10
  downstream <- window * 5
  file <-
    fread(
      paste0(
        folder_path,
        '/aml_msigdb_upstream',
        upstream,
        '_downstream',
        downstream,
        '_deprivation_index.gsa.out'
      )
    )
  file <-
    file %>%
    as.data.frame() %>%
    dplyr::select(FULL_NAME, P) %>%
    rename(!!paste0('Upstream ', upstream, 'kb, Downstream ', downstream, 'kb') := P)
  files[[window + 1]] <- file
}
gene_sets <- reduce(files, full_join, by = c("FULL_NAME"))

# Calculate Cauchy p-values for each gene-sets 
gene_sets_cauchy <-
  gene_sets %>%
  mutate(FULL_NAME = as.character(FULL_NAME)) %>%
  pivot_longer(!c("FULL_NAME")) %>%
  mutate(value = as.numeric(value)) %>%
  filter(value > 0 | value < 1) %>%
  group_by(FULL_NAME) %>%
  summarize(Cauchy_P = as.vector(Cauchy.Combination(value))) %>%
  arrange(Cauchy_P) 

gene_sets_cauchy$bonferroni_p <-
  p.adjust(gene_sets_cauchy$Cauchy_P, method = 'bonferroni')

gene_sets_cauchy <- as.data.frame(gene_sets_cauchy)
colnames(gene_sets_cauchy)[1] <-"gene_set"
colnames(gene_sets_cauchy)[2] <-"cauchy_p"

gene_sets_cauchy
write_tsv(
  gene_sets_cauchy,
  paste0(
    folder_path,
    "/aml_gene_sets_window_deprivation_index_cauchy_pvalues.tsv"
  )
)

# Plot the top 10 significant gene sets across different MAGMA window thresholds
gene_sets <-
  gene_sets %>%
  pivot_longer(!c("FULL_NAME")) %>%
  mutate(Neg_Log_Pvalue = -log10(value))

ordered_names <- unique(gene_sets$name)[order(as.numeric(sub(
  "Upstream (\\d+)kb.*", "\\1", unique(gene_sets$name)
)))]

sign_pvalue <- -log10(0.05 / nrow(gene_sets))

top_sign_gene_sets <-
  gene_sets %>%
  arrange(desc(Neg_Log_Pvalue)) %>%
  distinct(FULL_NAME) %>%
  slice_head(n = 10)

plot <- 
  gene_sets %>%
  mutate(name = factor(name, levels = ordered_names)) %>%
  filter(FULL_NAME %in% top_sign_gene_sets$FULL_NAME) %>%
  mutate(FULL_NAME = gsub('_', ' ', FULL_NAME)) %>%
  ggplot(aes(x = name,
             y = Neg_Log_Pvalue,
             group = FULL_NAME)) +
  geom_line(aes(color = FULL_NAME), size = 2) +
  geom_point() +
  geom_hline(yintercept = sign_pvalue,
             size = 1,
             linetype = "dashed") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title.x = element_blank()) +
  labs(color = "Gene-Sets", y = "Negative Log P-values (-log10(p-value))") +
  scale_color_manual(values = rev(my_cols))

ggsave(paste0(plot_path,
              "/aml_gene_sets_window_deprivation_index_plot.png"),
       plot = plot,
       width = 24,
       height = 6)

# -------------------------------------------------------------------------
# END OF SCRIPT
# ------------------------------------------------------------------------- 