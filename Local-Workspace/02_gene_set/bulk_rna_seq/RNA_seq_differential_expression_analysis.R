# -------------------------------------------------------------------------
# PACKAGES 
# -------------------------------------------------------------------------
library(SummarizedExperiment)
library(tidyverse)
library(DESeq2)
library(data.table)
library(jsonlite)
library(patchwork)
library(Matrix)
library(biomaRt)
library(EnhancedVolcano)
# -------------------------------------------------------------------------
# CLINICAL DATA 
# -------------------------------------------------------------------------
# Directory for clinical data 
setwd("/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Gene-Sets/")
# Load meta information 
normal_metadata <- fromJSON("GDC/Unprocessed-Data/AML-RNA-Seq-Normal-Tissue/metadata.repository.2025-09-19.json")
tumour_metadata <- fromJSON("GDC/Unprocessed-Data/AML-RNA-Seq-Primary-Tumour-Bone-Marrow/metadata.repository.2025-09-19.json")
# Load clinical data 
data <- fread("TCGA/Clinical/clinical.tsv")
# Load expression data 
normal_expression_data <- fread("GDC/Processed-Data/AML-RNA-Seq-Normal-Tissue.tsv")
tumour_expression_data <- fread("GDC/Processed-Data/AML-RNA-Seq-Primary-Tumour-Bone-Marrow.tsv")

# -------------------------------------------------------------------------
# CLINICAL DATA 
# -------------------------------------------------------------------------

# Format clinical data for survival analysis 
clinical <- data %>%
  # Remove treatment data and duplicates
  dplyr::select(-starts_with("treatment"), -ends_with("submitter_id")) %>%
  distinct() %>% 
  dplyr::rename(case_id = cases.case_id) %>%
  filter(demographic.gender == "female" | demographic.gender == "male") %>% 
  mutate(gender = str_to_title(demographic.gender)) %>% 
  # Keep only individuals with age at diagnosis
  filter(diagnoses.age_at_diagnosis != "'--") %>%
  mutate(
    diagnoses.age_at_diagnosis = as.numeric(diagnoses.age_at_diagnosis), 
    age = scale(diagnoses.age_at_diagnosis), 
  ) 

# -------------------------------------------------------------------------
# META DATA 
# -------------------------------------------------------------------------

# Load json file 
normal_metadata_flat <- jsonlite::flatten(normal_metadata)
tumour_metadata_flat <- jsonlite::flatten(tumour_metadata)
# Row bind information containing case id 
normal_metadata_flat <- bind_cols(normal_metadata_flat, do.call(rbind, normal_metadata_flat$associated_entities))
tumour_metadata_flat <- bind_cols(tumour_metadata_flat, do.call(rbind, tumour_metadata_flat$associated_entities))
# Join meta data with clinical data 
normal_metadata_flat <- inner_join(normal_metadata_flat, clinical, by = "case_id")
# Define control status
normal_metadata_flat$status <- rep("Normal Tissue", nrow(normal_metadata_flat))
# Join meta data with clinical data 
tumour_metadata_flat <- inner_join(tumour_metadata_flat, clinical, by = "case_id")
# Define case status 
tumour_metadata_flat$status <- rep("Primary Tumour Tissue", nrow(tumour_metadata_flat))
# Combine metadata 
metadata_flat <- bind_rows(tumour_metadata_flat, normal_metadata_flat)
metadata_flat$status <- factor(metadata_flat$status, levels = c("Normal Tissue", "Primary Tumour Tissue"))
metadata_flat$score <- ifelse(metadata_flat$status == "Primary Tumour Tissue", 1, 0 )

# -------------------------------------------------------------------------
# EXPRESSION DATA 
# -------------------------------------------------------------------------
# Combine expression data 
expression_data <- as.data.frame(inner_join(tumour_expression_data, normal_expression_data, by = c("gene_id", "gene_name", "gene_type")))
# extract gene and sample metadata from summarizedExperiment object
matrix <- as.matrix(column_to_rownames(dplyr::select(expression_data, -c("gene_name", "gene_type")), var ="gene_id"))
gene_type <- dplyr::select(expression_data, c("gene_name", "gene_type", "gene_id"))
coldata <- filter(metadata_flat, file_id %in% as.matrix(colnames(matrix)))
coldata <- coldata |> dplyr::select(gender, age, status, file_id, case_id)
# Remove duplicate samples 
coldata <- 
  coldata |> 
  group_by(case_id) |> 
  slice_min(order_by = status, n = 1) |> 
  distinct(gender, age, case_id, .keep_all = TRUE)
matrix <- matrix[, colnames(matrix) %in% coldata$file_id]
# Check that all samples match 
all(ncol(matrix) == nrow(colData))

# -------------------------------------------------------------------------
# DIFFERENTIAL GENE EXPRSSION 
# -------------------------------------------------------------------------

design_formula <- as.formula(paste("~ gender + age + status"))
dds <- DESeqDataSetFromMatrix(countData = Matrix(as.matrix(matrix), sparse = TRUE),
                              colData = coldata,
                              design = design_formula)

# Filter gene with low counts 
keep <- rowSums(counts(dds)) >=10
dds <- dds[keep,]
# Run DESeq2 command 
dds <- DESeq(dds)
# Generate results object
res <- results(dds)
# Generate of list of ensembl gene name and gene biotype 
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
# Get gene biotype
gene_info <- getBM(
  attributes = c("hgnc_symbol", "ensembl_gene_id", "gene_biotype"),
  filters = "ensembl_gene_id",
  values = gsub("\\..*$", "", unique(rownames(res))),
  mart = ensembl
)

# Combine results with ensembl gene name and gene biotype  
res <- res |> 
  as.data.frame() |> 
  rownames_to_column(var = "ensembl_gene_id") |> 
  mutate(ensembl_gene_id = gsub("\\..*$", "", ensembl_gene_id)) |> 
  inner_join(gene_info, by = "ensembl_gene_id") |> 
  filter(gene_biotype  == "protein_coding")
# Calculate bonferroni p-value 
res$pvalue_bonferroni <- p.adjust(res$pvalue, method = "bonferroni")
# Gene single cell results 
write_tsv(res, paste0("GDC/RNA-Seq-Differential-Expression/aml-rna-seq-normal-vs-tumour-results.tsv"))
# Gene single cell significant results 
write_tsv(filter(res, (abs(log2FoldChange) >= 0.58) & (pvalue_bonferroni < 0.05)), 
          paste0("GDC/RNA-Seq-Differential-Expression/aml-rna-seq-normal-vs-tumour-significant-results.tsv"))
# Gene single cell upregulated significant results 
write_tsv(filter(res, (log2FoldChange >= 0.58) & (pvalue_bonferroni < 0.05)), 
          paste0("GDC/RNA-Seq-Differential-Expression/aml-rna-seq-normal-vs-tumour-upregulation-significant-results.tsv"))
# Gene single cell downregulated significant results 
write_tsv(filter(res, (log2FoldChange <= -0.58) & (pvalue_bonferroni < 0.05)), 
          paste0("GDC/RNA-Seq-Differential-Expression/aml-rna-seq-normal-vs-tumour-downregulation-significant-results.tsv"))
# Generate volcano plot 
volcano_plot <- 
  EnhancedVolcano(res,
                  pCutoff = 0.05, 
                  FCcutoff = 0.58, 
                  lab = res$hgnc_symbol,
                  x = 'log2FoldChange',
                  y = 'pvalue',
                  xlab = "Log2 Fold Change",
                  ylab = "-Log10 P-value")

?EnhancedVolcano
# Save volcano plot 
ggsave(paste0("GDC/RNA-Seq-Differential-Expression/AML-RNA-Seq-Normal-vs-Tumour-Volcano-Plot.png"), 
       plot = volcano_plot, 
       width = 10, 
       height = 8)


# -------------------------------------------------------------------------
# FINISH SCRIPT 
# -------------------------------------------------------------------------


