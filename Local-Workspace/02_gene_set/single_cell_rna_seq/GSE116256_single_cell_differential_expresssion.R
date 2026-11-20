# -------------------------------------------------------------------------
# PACKAGES 
# -------------------------------------------------------------------------

library(Seurat)
library(SeuratDisk)
library(ggplot2)
library(tidyverse)
library(gridExtra)
library(data.table)
library(DESeq2)
library(fastDummies)
library(EnhancedVolcano)
library(biomaRt)
library(MAST)
library(GEOquery)

# -------------------------------------------------------------------------
# LOAD SINGLE CELL DATA (SINGLE SAMPLE)
# -------------------------------------------------------------------------
# Set directory 
setwd("/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Gene-Sets/GDC/")
# Directory of unprocessed data 
master_dir <- "Processed-Data/"
# Directory of processed data 
save_dir <- "Single-Cell-Differential-Expression-Analysis/"

# Download the GEO dataset metadata
gse <- getGEO("GSE116256", GSEMatrix = TRUE)
metadata <- pData(gse[[1]])
# Generate list of samples 
metadata <- 
  metadata |>
  mutate(patient_id = gsub("-anno", "", title)) |> 
  janitor::clean_names() |> 
  distinct(age_ch1, gender_ch1, patient_id) |> 
  mutate(age_ch1 = as.numeric(age_ch1), 
         gender_ch1 = as.factor(gender_ch1)) |> 
  rename("age" = "age_ch1", 
         "gender" = "gender_ch1") |> 
  mutate(age = as.numeric(age),
         patient_id = as.factor(patient_id),
         age = scale(age), 
         orig.ident = patient_id) 

# Create seurat object 
seurat_obj <- readRDS(paste0(master_dir,"Harmonized-AML-Diagnosis-Bone-Marrow.rds"))
# Assign covariates 
seurat_obj$age <- metadata$age[match(seurat_obj@meta.data$orig.ident, metadata$orig.ident)]
seurat_obj$gender <- metadata$gender[match(seurat_obj@meta.data$orig.ident, metadata$orig.ident)]
seurat_obj$patient <- as.factor(seurat_obj$Patient)
# Assign malignant class 
seurat_obj$SampleType <- ifelse(grepl("AML",seurat_obj$Patient),"malignant-sample", "benign-sample")
seurat_obj$CellAndSampleType <- paste0(seurat_obj$PredictionRefined, "-cell-", seurat_obj$SampleType)
# Malignant cell classification, cell type, and sample type 
seurat_obj$MalignantCellType <- paste0(seurat_obj$PredictionRefined, "-", seurat_obj$CellType)
seurat_obj$MalignantCellAndSampleType <- paste0(seurat_obj$MalignantCellType, "-", seurat_obj$SampleType)
# -------------------------------------------------------------------------
# SINGLE CELL DIFFERENTIAL GENE EXPRESSION 
# -------------------------------------------------------------------------

# Define cell type 
cell <- "malignant"
# Set seurat object 
Idents(seurat_obj) <- "PredictionRefined"
# Perform differential analysis 
malignant.de.markers <- FindMarkers(seurat_obj, 
                              ident.1 = "malignant", 
                              ident.2 = "normal",
                              latent.vars = c("age", "gender"), 
                              test.use = "MAST")

# Generate of list of ensembl gene name and gene biotype 
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
# Get gene biotype
gene_info <- getBM(
  attributes = c("hgnc_symbol", "ensembl_gene_id", "gene_biotype"),
  filters = "hgnc_symbol",
  values = unique(rownames(malignant.de.markers)),
  mart = ensembl
)

# Gene single cell results 
write_tsv(malignant.de.markers, paste0(save_dir,cell,"-single-cell-results.tsv"))

# Combine results with ensembl gene name and gene biotype  
malignant.de.markers <- 
  malignant.de.markers |> 
  as.data.frame() |> 
  rownames_to_column(var = "hgnc_symbol") |> 
  inner_join(gene_info, by = "hgnc_symbol") |> 
  filter(gene_biotype == "protein_coding")
# Gene single cell significant results 
write_tsv(filter(malignant.de.markers, (abs(avg_log2FC) >= 0.58) & (p_val_adj < 0.01)), 
          paste0(save_dir,cell,"-single-cell-significant-results.tsv"))
# Gene single cell upregulated significant results 
write_tsv(filter(malignant.de.markers, (avg_log2FC >= 0.58) & (p_val_adj < 0.01)), 
          paste0(save_dir,cell,"-single-cell-upregulation-significant-results.tsv"))
# Gene single cell downregulated significant results 
write_tsv(filter(malignant.de.markers, (avg_log2FC <= -0.58) & (p_val_adj < 0.01)), 
          paste0(save_dir,cell,"-single-cell-downregulation-significant-results.tsv"))
# Generate volcano plot 
volcano_plot <- 
  EnhancedVolcano(malignant.de.markers, 
                  lab = malignant.de.markers$hgnc_symbol, 
                  pCutoff = (0.01/nrow(malignant.de.markers)), 
                  FCcutoff = 0.58,
                  x = "avg_log2FC", 
                  y ="p_val",
                  xlab = "Log2 Fold Change",
                  ylab = "-Log10 P-value")
# Save volcano plot 
ggsave(paste0(save_dir,cell,"-single-cell-volcano-plot.png"), 
       plot = volcano_plot, 
       width = 10, 
       height = 8)


# -------------------------------------------------------------------------
# SINGLE CELL DIFFERENTIAL GENE EXPRESSION 
# -------------------------------------------------------------------------
# Define cell type 
cell <- "malignant-aml-samples"
# Set seurat object 
Idents(seurat_obj) <- "CellAndSampleType"
# Perform differential analysis 
malignant.de.markers <- FindMarkers(seurat_obj, 
                                    ident.1 = "malignant-cell-malignant-sample", 
                                    ident.2 = "normal-cell-malignant-sample",
                                    latent.vars = c("age", "gender", "patient"), 
                                    test.use = "MAST")

# Generate of list of ensembl gene name and gene biotype 
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
# Get gene biotype
gene_info <- getBM(
  attributes = c("hgnc_symbol", "ensembl_gene_id", "gene_biotype"),
  filters = "hgnc_symbol",
  values = unique(rownames(malignant.de.markers)),
  mart = ensembl
)

# Gene single cell results 
write_tsv(malignant.de.markers, paste0(save_dir,cell,"-single-cell-malignant-samples-results.tsv"))

# Combine results with ensembl gene name and gene biotype  
malignant.de.markers <- 
  malignant.de.markers |> 
  as.data.frame() |> 
  rownames_to_column(var = "hgnc_symbol") |> 
  inner_join(gene_info, by = "hgnc_symbol") |> 
  filter(gene_biotype == "protein_coding")
# Gene single cell significant results 
write_tsv(filter(malignant.de.markers, (abs(avg_log2FC) >= 0.58) & (p_val_adj < 0.01)), 
          paste0(save_dir,cell,"-single-cell-malignant-samples-significant-results.tsv"))
# Gene single cell upregulated significant results 
write_tsv(filter(malignant.de.markers, (avg_log2FC >= 0.58) & (p_val_adj < 0.01)), 
          paste0(save_dir,cell,"-single-cell-malignant-samples-upregulation-significant-results.tsv"))
# Gene single cell downregulated significant results 
write_tsv(filter(malignant.de.markers, (avg_log2FC <= -0.58) & (p_val_adj < 0.01)), 
          paste0(save_dir,cell,"-single-cell-malignant-samples-downregulation-significant-results.tsv"))
# Generate volcano plot 
volcano_plot <- 
  EnhancedVolcano(malignant.de.markers, 
                  lab = malignant.de.markers$hgnc_symbol, 
                  pCutoff = (0.01/nrow(malignant.de.markers)), 
                  FCcutoff = 0.58,
                  x = "avg_log2FC", 
                  y ="p_val", 
                  xlab = "Log2 Fold Change",
                  ylab = "-Log10 P-value")
# Save volcano plot 
ggsave(paste0(save_dir,cell,"-single-cell-malignant-samples-volcano-plot.png"), 
       plot = volcano_plot, 
       width = 10, 
       height = 8)

# -------------------------------------------------------------------------
# SINGLE CELL DIFFERENTIAL GENE EXPRESSION 
# -------------------------------------------------------------------------

# Cell types 
cells <- unique(seurat_obj$CellType)
# Set seurat object 
Idents(seurat_obj) <- "CellType"
# Loop for differential gene expression analysis 
for (cell in cells) {
  
  # Perform differential analysis 
  malignant.de.markers <- FindMarkers(seurat_obj, 
                                      ident.1 = cell, 
                                      ident.2 = NULL,
                                      latent.vars = c("age", "gender"), 
                                      test.use = "MAST")
  
  # Generate of list of ensembl gene name and gene biotype 
  ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
  # Get gene biotype
  gene_info <- getBM(
    attributes = c("hgnc_symbol", "ensembl_gene_id", "gene_biotype"),
    filters = "hgnc_symbol",
    values = unique(rownames(malignant.de.markers)),
    mart = ensembl
  )
  
  # Gene single cell results 
  write_tsv(malignant.de.markers, paste0(save_dir,cell,"-vs-other-cells-single-cell-results.tsv"))
  
  # Combine results with ensembl gene name and gene biotype  
  malignant.de.markers <- 
    malignant.de.markers |> 
    as.data.frame() |> 
    rownames_to_column(var = "hgnc_symbol") |> 
    inner_join(gene_info, by = "hgnc_symbol") |> 
    filter(gene_biotype == "protein_coding")
  # Gene single cell significant results 
  write_tsv(filter(malignant.de.markers, (abs(avg_log2FC) >= 0.58) & (p_val_adj < 0.01)), 
            paste0(save_dir,cell,"-vs-other-cells-single-cell-significant-results.tsv"))
  # Gene single cell upregulated significant results 
  write_tsv(filter(malignant.de.markers, (avg_log2FC >= 0.58) & (p_val_adj < 0.01)), 
            paste0(save_dir,cell,"-vs-other-cells-single-cell-upregulation-significant-results.tsv"))
  # Gene single cell downregulated significant results 
  write_tsv(filter(malignant.de.markers, (avg_log2FC <= -0.58) & (p_val_adj < 0.01)), 
            paste0(save_dir,cell,"-vs-other-cells-single-cell-downregulation-significant-results.tsv"))
  # Generate volcano plot 
  volcano_plot <- 
    EnhancedVolcano(malignant.de.markers, 
                    lab = malignant.de.markers$hgnc_symbol, 
                    pCutoff = (0.01/nrow(malignant.de.markers)), 
                    FCcutoff = 0.58,
                    x = "avg_log2FC", 
                    y ="p_val",
                    xlab = "Log2 Fold Change",
                    ylab = "-Log10 P-value")
  # Save volcano plot 
  ggsave(paste0(save_dir,cell,"-vs-other-cells-single-cell-volcano-plot.png"), 
         plot = volcano_plot, 
         width = 10, 
         height = 8)
  
  
}

# -------------------------------------------------------------------------
# SINGLE CELL DIFFERENTIAL GENE EXPRESSION 
# -------------------------------------------------------------------------

# Cell types 
cells <- unique(seurat_obj$CellType)
# Set seurat object 

# Loop for differential gene expression analysis 
for (cell in cells) {
  # Create column for single cell type contrast 
  seurat_obj$MalignantCells <- 
  ifelse(grepl("benign", seurat_obj$MalignantCellAndSampleType), "benign", 
         ifelse(grepl(cell, seurat_obj$MalignantCellAndSampleType), cell, "other-malignant")) 
  Idents(seurat_obj) <- "MalignantCells"
  # Perform differential analysis 
  malignant.de.markers <- FindMarkers(seurat_obj, 
                                      ident.1 = cell, 
                                      ident.2 = "other-malignant",
                                      latent.vars = c("age", "gender", "patient"), 
                                      test.use = "MAST")
  
  # Generate of list of ensembl gene name and gene biotype 
  ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
  # Get gene biotype
  gene_info <- getBM(
    attributes = c("hgnc_symbol", "ensembl_gene_id", "gene_biotype"),
    filters = "hgnc_symbol",
    values = unique(rownames(malignant.de.markers)),
    mart = ensembl
  )
  
  # Gene single cell results 
  write_tsv(malignant.de.markers, paste0(save_dir,cell,"-vs-other-cells-single-cell-malignant-samples-results.tsv"))
  
  # Combine results with ensembl gene name and gene biotype  
  malignant.de.markers <- 
    malignant.de.markers |> 
    as.data.frame() |> 
    rownames_to_column(var = "hgnc_symbol") |> 
    inner_join(gene_info, by = "hgnc_symbol") |> 
    filter(gene_biotype == "protein_coding")
  # Gene single cell significant results 
  write_tsv(filter(malignant.de.markers, (abs(avg_log2FC) >= 0.58) & (p_val_adj < 0.01)), 
            paste0(save_dir,cell,"-vs-other-cells-single-cell-malignant-samples-significant-results.tsv"))
  # Gene single cell upregulated significant results 
  write_tsv(filter(malignant.de.markers, (avg_log2FC >= 0.58) & (p_val_adj < 0.01)), 
            paste0(save_dir,cell,"-vs-other-cells-single-cell-malignant-samples-upregulation-significant-results.tsv"))
  # Gene single cell downregulated significant results 
  write_tsv(filter(malignant.de.markers, (avg_log2FC <= -0.58) & (p_val_adj < 0.01)), 
            paste0(save_dir,cell,"-vs-other-cells-single-cell-malignant-samples-downregulation-significant-results.tsv"))
  # Generate volcano plot 
  volcano_plot <- 
    EnhancedVolcano(malignant.de.markers, 
                    lab = malignant.de.markers$hgnc_symbol, 
                    pCutoff = (0.01/nrow(malignant.de.markers)), 
                    FCcutoff = 0.58,
                    x = "avg_log2FC", 
                    y ="p_val",
                    xlab = "Log2 Fold Change",
                    ylab = "-Log10 P-value")
  # Save volcano plot 
  ggsave(paste0(save_dir,cell,"-vs-other-cells-single-cell-malignant-samples-volcano-plot.png"), 
         plot = volcano_plot, 
         width = 10, 
         height = 8)
  
}

# -------------------------------------------------------------------------
# END OF THE SCRIPT 
# -------------------------------------------------------------------------
