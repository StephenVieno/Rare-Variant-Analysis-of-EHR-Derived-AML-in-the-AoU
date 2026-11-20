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

# -------------------------------------------------------------------------
# EXPRESSION DATA 
# -------------------------------------------------------------------------
# Combine expression data 
expression_data <- as.data.frame(inner_join(tumour_expression_data, normal_expression_data, by = c("gene_id", "gene_name", "gene_type")))
# extract gene and sample metadata from summarizedExperiment object
matrix <- as.matrix(column_to_rownames(dplyr::select(expression_data, -c("gene_name", "gene_type")), var ="gene_id"))
gene_type <- dplyr::select(expression_data, c("gene_name", "gene_type", "gene_id"))
coldata <- filter(metadata_flat, file_id %in% as.matrix(colnames(matrix)))
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

# Gender
plot2 <- 
  plotPCA(vsd, intgroup=c("gender"), ntop = nrow(vsd)) +
  labs(color ="Gender") + 
  theme_bw() + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Project ID 
plot3 <- 
  plotPCA(vsd, intgroup=c("project.project_id"), ntop = nrow(vsd)) + 
  labs(color ="Project Identifier") + 
  theme_bw() + 
  theme(legend.position = "left") + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Treatment Protocol ID 
plot4 <- 
  plotPCA(vsd, intgroup=c("status"), ntop = nrow(vsd)) + 
  labs(color ="Status") + 
  theme_bw() + 
  paletteer::scale_colour_paletteer_d("LaCroixColoR::Lemon")

# Combine pca plots 
pca_plot1 <- 
  (plot1 | plot2) / (plot3 | plot4) + 
  plot_layout(
    guides = "keep"   # keep individual legends
  ) +
  plot_annotation(tag_levels = 'A') & 
  theme(
    plot.margin = ggplot2::margin(5, 5, 5, 5)  # no unit needed
  )


# Save the plot 
ggsave(
  filename = "GDC/RNA-Seq-Differential-Expression/AML-RNA-Seq-Normal-vs-Tumour-PCA1.png",  
  plot = pca_plot1,
  width = 14, height = 6, dpi = 300
)

# -------------------------------------------------------------------------
# FINISH SCRIPT 
# -------------------------------------------------------------------------


