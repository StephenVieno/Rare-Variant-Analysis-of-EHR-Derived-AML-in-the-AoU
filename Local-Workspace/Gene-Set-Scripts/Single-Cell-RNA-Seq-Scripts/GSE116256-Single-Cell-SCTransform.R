
# -------------------------------------------------------------------------
# PACKAGES 
# -------------------------------------------------------------------------

library(Seurat)
library(SeuratDisk)
library(ggplot2)
library(tidyverse)
library(gridExtra)
library(data.table)
library(sctransform)
library(GEOquery)

# -------------------------------------------------------------------------
# LOAD SINGLE CELL DATA (SINGLE SAMPLE)
# -------------------------------------------------------------------------
# Set directory 
setwd("/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Gene-Sets/GDC/")
# Directory of unprocessed data 
master_dir <- "Unprocessed-Data/GSE116256/"
# Directory of processed data 
save_dir <- "Processed-Data/"

# Download the GEO dataset metadata
gse <- getGEO("GSE116256", GSEMatrix = TRUE)
metadata <- pData(gse[[1]])
# Generate list of samples 
metadata <- 
  metadata |>
  # dplyr::filter(grepl("AML", title)) |>
  mutate(sample_id = gsub("-anno", "", title))
# List of unique samples 
sample_list <- unique(metadata$sample_id)
sample_list <- sample_list[!grepl("OCI-AML3|MUTZ3", sample_list)]

# -------------------------------------------------------------------------
# SINGLE CELL QC LOOP 
# -------------------------------------------------------------------------

# Loop for generating single sample QC plots 
for (sample_id in sample_list){ 
  # Load single cell data 
  print(sample_id)
  # Acquire single-cell data files 
  files <- list.files(path = master_dir, 
                      pattern = paste0(sample_id,"."))
  # Acquire files 
  dem_file <- files[grepl("dem", files) & grepl(paste0(sample_id,"."), files, fixed = TRUE)]
  anno_file <- files[grepl("anno", files) & grepl(paste0(sample_id,"."), files, fixed = TRUE)]
  # Read expression matrix
  expr <- read.delim(paste0(master_dir, dem_file), row.names = 1, check.names = FALSE)
  # The DEM file: rows are genes, columns are cell barcodes
  
  # Read annotation file
  anno <- read.delim(paste0(master_dir, anno_file), row.names = 1, check.names = FALSE)
  # The ANNO file: rows correspond to the same cell barcodes
  
  # Check matching order
  all(colnames(expr) %in% rownames(anno))
  # TRUE → proceed
  
  # Create Seurat object
  seurat_obj <- CreateSeuratObject(counts = expr, meta.data = anno)
  
  # Store mitochondrial percentage in object meta data
  seurat_obj <- PercentageFeatureSet(seurat_obj, 
                                     pattern = "^MT-", 
                                     col.name = "percent.mt")
  
  # Check quality control for all samples 
  if (any(seurat_obj$nFeature_RNA < 500)) {
    break  
  }
  if (any(seurat_obj$nCount_RNA < 1000)) {
    break  
  }
  if (any(seurat_obj$percent.mt > 20)) {
    break  
  }
  
  # Run SCTransform
  seurat_obj <- SCTransform(seurat_obj, verbose = FALSE)
  
  # Seurat workflow for clustering
  seurat_obj <- RunPCA(seurat_obj, verbose = FALSE)
  seurat_obj <- RunUMAP(seurat_obj, dims = 1:30, verbose = FALSE)
  seurat_obj <- FindNeighbors(seurat_obj, dims = 1:30, verbose = FALSE)
  seurat_obj <- FindClusters(seurat_obj, verbose = FALSE)
  
  # Save seurat object 
  saveRDS(seurat_obj, 
          paste0(save_dir, 
                 "Processed-SCT-", 
                 sample_id,
                 ".rds"))
} 

print("End of Script")
# -------------------------------------------------------------------------
# END OF THE SCRIPT 
# -------------------------------------------------------------------------



