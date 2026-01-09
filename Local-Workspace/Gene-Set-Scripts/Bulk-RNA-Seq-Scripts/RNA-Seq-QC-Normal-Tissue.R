# -------------------------------------------------------------------------
# PACKAGES 
# -------------------------------------------------------------------------
library(SummarizedExperiment)
library(tidyverse)
library(DESeq2)
library(data.table)
library(jsonlite)
library(patchwork)
# -------------------------------------------------------------------------
# CLINICAL DATA 
# -------------------------------------------------------------------------
# Directory for clinical data 
setwd("/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Gene-Sets/")
# Load meta information 
metadata <- fromJSON("GDC/Unprocessed-Data/AML-RNA-Seq-Normal-Tissue/metadata.repository.2025-09-19.json")
# Load clinical data 
data <- fread("TCGA/Clinical/clinical.tsv")
# Load expression data 
expression_data <- fread("GDC/Processed-Data/AML-RNA-Seq-Normal-Tissue.tsv")

# -------------------------------------------------------------------------
# TREATMENT (CLINICAL SUBSET) DATA 
# -------------------------------------------------------------------------

# Extract treatment data from clinical data 
treatment <- data %>%
  # Select relevant columns and clean '--' as NA
  dplyr::select(cases.case_id, starts_with("treatment"), -ends_with("submitter_id")) %>%
  rename(case_id = cases.case_id) %>%
  mutate(across(everything(), ~ na_if(., "'--"))) %>%
  # Collapse multiple rows per case_id
  group_by(case_id) %>%
  summarise(across(everything(),
                   ~ paste(na.omit(.), collapse = ", "),
                   .names = "collapsed_{.col}")) %>%
  ungroup() %>%
  # Treatment documentation
  mutate(
    treatment_or_therapy = case_when(
      grepl("yes", collapsed_treatments.treatment_or_therapy, ignore.case = TRUE) ~ "Yes",
      grepl("End of Treatment Course|First Complete Response|Prior to Procurement",
            collapsed_treatments.timepoint_category) ~ "Yes",
      grepl("Stem Cell Transplantation|Pharmaceutical Therapy",
            collapsed_treatments.treatment_type) ~ "Yes",
      grepl("Steroid", collapsed_treatments.protocol_identifier) ~ "Yes",
      TRUE ~ "No"
    ),
    # Protocol documentation
    protocol_identifier = case_when(
      !grepl("AAML|CCG", collapsed_treatments.protocol_identifier) & treatment_or_therapy == "Yes" ~ "Missing Protocol",
      !grepl("AAML|CCG|Missing Protocol", collapsed_treatments.protocol_identifier) & treatment_or_therapy == "No" ~ "No Protocol",
      TRUE ~ collapsed_treatments.protocol_identifier
    ),
    # Treatment type flags
    stem_cell = ifelse(grepl("Stem Cell Transplantation", collapsed_treatments.treatment_type), "Yes", "No"),
    pharmaceutical = ifelse(grepl("Pharmaceutical Therapy", collapsed_treatments.treatment_type), "Yes", "No")
  )


# Check the output of treatment column 
# table(treatment$protocol_identifier, treatment$treatment_or_therapy)
# table(treatment$protocol_identifier, treatment$stem_cell)
# table(treatment$protocol_identifier, treatment$pharmaceutical)
# table(treatment$treatment_or_therapy, treatment$stem_cell)
# table(treatment$treatment_or_therapy, treatment$pharmaceutical)

# -------------------------------------------------------------------------
# CLINICAL DATA 
# -------------------------------------------------------------------------

# Format clinical data for survival analysis 
clinical <- data %>%
  # Remove treatment data and duplicates
  dplyr::select(-starts_with("treatment"), -ends_with("submitter_id")) %>%
  distinct() %>%
  rename(case_id = cases.case_id) %>%
  filter(demographic.gender == "female" | demographic.gender == "male") %>% 
  mutate(gender = str_to_title(demographic.gender)) %>% 
  # Keep only individuals with age at diagnosis
  filter(diagnoses.age_at_diagnosis != "'--") %>%
  # Keep only samples with vital status Dead or Alive
  filter(demographic.vital_status %in% c("Dead", "Alive")) %>%
  mutate(across(everything(), ~na_if(.x, "'--"))) %>% 
  filter(!is.na(demographic.days_to_death) | !is.na(diagnoses.days_to_last_follow_up)) %>% 
  # Define time_to_event and vital_status
  mutate(
    time_to_event = as.numeric(diagnoses.days_to_last_follow_up), 
    vital_status = ifelse(demographic.vital_status == "Dead", 2, 1),
    diagnoses.age_at_diagnosis = as.numeric(diagnoses.age_at_diagnosis),
    demographic.age_at_index = as.numeric(demographic.age_at_index)
  ) 

# -------------------------------------------------------------------------
# META DATA 
# -------------------------------------------------------------------------

# Load json file 
metadata_flat <- jsonlite::flatten(metadata)
# Row bind information containing case id 
metadata_flat <- bind_cols(metadata_flat, do.call(rbind, metadata_flat$associated_entities))
# Join meta data with clinical data 
metadata_flat <- inner_join(inner_join(metadata_flat, clinical, by = "case_id"), treatment, by = "case_id")

# -------------------------------------------------------------------------
# EXPRESSION DATA 
# -------------------------------------------------------------------------

# extract gene and sample metadata from summarizedExperiment object
matrix <- as.matrix(column_to_rownames(dplyr::select(expression_data, -c("gene_name", "gene_type")), var ="gene_id"))
gene_type <- dplyr::select(expression_data, c("gene_name", "gene_type", "gene_id"))
coldata <- filter(metadata_flat, file_id %in% as.matrix(colnames(matrix)))
# Remove duplicate samples 
coldata <- distinct(coldata, case_id, .keep_all = TRUE)
matrix <- matrix[, colnames(matrix) %in% coldata$file_id]
# Check that all samples match 
all(ncol(matrix) == nrow(colData))

# vst transform counts to be used in survival analysis ---------------
# Setting up countData object   
dds <- DESeqDataSetFromMatrix(countData = matrix,
                              colData = coldata,
                              design = ~ 1)

# Removing genes with sum total of 10 reads across all samples
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
vsd <- vst(dds, blind=FALSE)
matrix_vst <- assay(vsd)

# -------------------------------------------------------------------------
# PCA PLOT 1 
# -------------------------------------------------------------------------

# Set colors for the plots 
start <- "#F7AA14FF"
end   <- "#088BBEFF"

# Age at diagnosis 
plot1 <- 
plotPCA(vsd, intgroup=c("diagnoses.age_at_diagnosis"), ntop = nrow(vsd)) +
  labs(color ="Age at Diagnosis") + 
  theme_bw() + 
  theme(legend.position = "left") + 
  scale_color_gradient(low = start, high = end)

# Age at index
plot2 <- 
plotPCA(vsd, intgroup=c("demographic.age_at_index"), ntop = nrow(vsd)) + 
  labs(color ="Age at Index") + 
  theme_bw() + 
  scale_color_gradient(low = start, high = end)

# Gender
plot3 <- 
plotPCA(vsd, intgroup=c("gender"), ntop = nrow(vsd)) +
  labs(color ="Gender") + 
  theme_bw() + 
  theme(legend.position = "left") + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Project ID 
plot4 <- 
plotPCA(vsd, intgroup=c("project.project_id"), ntop = nrow(vsd)) + 
  labs(color ="Project Identifier") + 
  theme_bw() + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Project ID pca plot
plot5 <- 
plotPCA(vsd, intgroup=c("treatment_or_therapy"), ntop = nrow(vsd)) + 
  labs(color ="Treatment or Therapy") + 
  theme_bw() + 
  theme(legend.position = "left") + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Treatment Protocol ID 
plot6 <- 
plotPCA(vsd, intgroup=c("protocol_identifier"), ntop = nrow(vsd)) + 
  labs(color ="Protocol Identifier") + 
  theme_bw() + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Stem Cell Transplantion 
plot7 <- 
plotPCA(vsd, intgroup=c("stem_cell"), ntop = nrow(vsd)) + 
  labs(color ="Stem Cell Transplantion") + 
  theme_bw() + 
  theme(legend.position = "left") + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Pharmaceutical Treatment 
plot8 <- 
plotPCA(vsd, intgroup=c("pharmaceutical"), ntop = nrow(vsd)) + 
  labs(color ="Pharmaceutical Treatment") + 
  theme_bw() + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Combine pca plots 
pca_plot1 <- 
  (plot1 | plot2) /
  (plot3 | plot4) /
  (plot5 | plot6) /
  (plot7 | plot8) +  # make sure no duplicates
  plot_layout(
    heights = rep(1, 4), 
    widths = rep(1, 2), 
    guides = "keep"  # <-- keep individual legends
  ) +
  plot_annotation(tag_levels = 'A') &
  theme(
    plot.margin = margin(5, 5, 5, 5)
  )

# Save the plot 
ggsave(
  filename = "GDC/RNA-Seq-Cox-Regression/AML-RNA-Seq-Normal-Tissue-PCA1.png",  
  plot = pca_plot1,
  width = 14, height = 12, dpi = 300
)

# -------------------------------------------------------------------------
# PCA PLOT 2 
# -------------------------------------------------------------------------

# Calculate principal components 
pca <- prcomp(as.data.frame(t(matrix_vst)), center = TRUE, scale. = TRUE)
# Generate list of eigenvaleus 
eigenvalues <- pca$sdev
# Create dataframe to plot eigenvalues 
pca_data <- data.frame(
  "PC-Label" = as.factor(paste0(rep("PC", length(eigenvalues)),1:length(eigenvalues))), 
  "PC" = 1:length(eigenvalues), 
  "Eigenvalues" = eigenvalues)

# Create eigenvalue plot 
pca_plot2 <- 
  pca_data |> 
  ggplot() +
  geom_point(aes(x = PC, y = Eigenvalues), size = 2) + 
  geom_line(aes(x = PC, y = Eigenvalues)) + 
  theme_bw() + xlim(0,50) + 
  xlab("Principal Component")

# Save the plot 
ggsave(
  filename = "GDC/RNA-Seq-Cox-Regression/AML-RNA-Seq-Normal-Tissue-PCA2.png",  
  plot = pca_plot2,
  width = 12, height = 6, dpi = 300)

# -------------------------------------------------------------------------
# FORMAT OUTPUT FILE 
# -------------------------------------------------------------------------

# Filter for protein coding genes 
vst_filtered <- matrix_vst |> 
  as.data.frame() |> 
  rownames_to_column(var = "gene_id") |> 
  inner_join(gene_type, by = "gene_id") |> 
  filter(gene_type == "protein_coding") |> 
  column_to_rownames(var = "gene_id") |> 
  t() |> 
  as.data.frame() |> 
  rownames_to_column(var = "file_id") |> 
  inner_join(metadata_flat, by = "file_id") |> 
  inner_join(rownames_to_column(dplyr::select(as.data.frame(pca$x), 1:50), (var = "file_id")), by = "file_id")

# Save formatted file 
write_tsv(vst_filtered,"GDC/RNA-Seq-Cox-Regression/Formatted-AML-RNA-Seq-Normal-Tissue.tsv")

# -------------------------------------------------------------------------
# FINISH SCRIPT 
# -------------------------------------------------------------------------


