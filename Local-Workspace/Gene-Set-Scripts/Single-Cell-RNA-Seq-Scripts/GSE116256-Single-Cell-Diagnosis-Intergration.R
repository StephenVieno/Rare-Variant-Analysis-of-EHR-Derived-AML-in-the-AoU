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
  # filter(grepl("AML", title)) |>
  mutate(sample_id = gsub("-anno", "", title))
# List of unique samples 
sample_list <- unique(metadata$sample_id)
sample_list <- sample_list[!grepl("OCI-AML3|MUTZ3", sample_list)]

# Loop for generating single sample QC plots 
for (sample_id in sample_list){ 
  # Load single cell data 
  print(sample_id)
  # Acquire single-cell data files 
  files <- list.files(path = master_dir, 
                      pattern = sample_id)
  # Acquire files 
  dem_file <- files[grepl("dem", files) & grepl(paste0(sample_id,"."), files, fixed = TRUE)]
  anno_file <- files[grepl("anno", files) & grepl(paste0(sample_id,"."), files, fixed = TRUE)]
  # Read expression matrix
  expr <- read.delim(paste0(master_dir, dem_file), row.names = 1, check.names = FALSE)
  # The DEM file: rows are genes, columns are cell barcodes
  
  # Read annotation file
  anno <- read.delim(paste0(master_dir, anno_file), row.names = 1, check.names = FALSE)
  # The ANNO file: rows correspond to the same cell barcodes
  
  # Read second annotation file
  doublet <- read.delim(paste0(save_dir, "Doublet-Finder-", sample_id,".tsv"), row.names = 1, check.names = FALSE)
  # Create id column for join 
  doublet <- 
    doublet |> 
    rownames_to_column(var="id") |> 
    dplyr::select(id, colnames(doublet)[grepl("DF.classifications", colnames(doublet))])

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
  
  # Create id column for join 
  seurat_obj$id <- rownames(seurat_obj@meta.data)
  # Join doublet column 
  col <- colnames(doublet)[grepl("DF.classifications", colnames(doublet))]
  seurat_obj$doublet <- doublet[[col]][match(seurat_obj@meta.data$id, doublet$id)]
  
  # Print quality control metrics 
  print(min(seurat_obj@meta.data$nCount_RNA))
  print(min(seurat_obj@meta.data$nFeature_RNA))
  print(table(seurat_obj@meta.data$doublet))
  # Create Seurat objects
  sample_id <- gsub("-", "_", sample_id)
  assign(sample_id, seurat_obj)
} 

# -------------------------------------------------------------------------
# MERGE SAMPLES 
# -------------------------------------------------------------------------

# Format sample list 
sample_list <- gsub("-", "_", sample_list)
# Create list of samples at diagnosis 
diagnosis_list <- NULL
diagnosis_list <- sample_list[grepl("D0|BM", sample_list)]
diagnosis_list <- diagnosis_list[!grepl("BM5_34p38n", diagnosis_list)]
diagnosis_list <- diagnosis_list[!is.na(diagnosis_list)]
# Merge samples together into single object 
seurat_obj <- merge(AML1012_D0, y = c(AML210A_D0, AML314_D0, AML328_D0, AML329_D0,
                                      AML371_D0, AML419A_D0, AML420B_D0, AML475_D0, 
                                      AML556_D0, AML707B_D0, AML722B_D0, AML870_D0, 
                                      AML916_D0, AML921A_D0, AML997_D0, BM1, BM2, BM3, BM4, BM5_34p),
                    add.cell.ids = diagnosis_list,
                    project = 'Diagnosis')

# Create a sample column
seurat_obj$sample <- rownames(seurat_obj@meta.data)
# Split sample column
seurat_obj@meta.data <- separate(seurat_obj@meta.data, 
                                 col = 'sample', 
                                 into = c('Patient', 'Barcode'), 
                                 sep = '_')
# Remove doublets from dataset 
seurat_obj <- subset(seurat_obj, subset = doublet == "Singlet")
# Check singlets
print(table(seurat_obj$doublet))

# Standard workflow steps
seurat_obj <- NormalizeData(seurat_obj)
seurat_obj <- FindVariableFeatures(seurat_obj)
seurat_obj <- ScaleData(seurat_obj)
seurat_obj <- RunPCA(seurat_obj)
ElbowPlot(seurat_obj)
seurat_obj <- FindNeighbors(seurat_obj, 
                            dims = 1:30, 
                            reduction = "pca")
seurat_obj <- FindClusters(seurat_obj, 
                           resolution = 2, 
                           cluster.name = "unintegrated_clusters")
seurat_obj <- RunUMAP(seurat_obj, 
                      dims = 1:30, 
                      reduction = "pca", 
                      reduction.name = "umap.unintegrated")

# visualize by batch and cell type annotation
DimPlot(seurat_obj, reduction = "umap.unintegrated", group.by = c("Method", "CellType"))
DimPlot(seurat_obj, reduction = "umap.unintegrated", group.by = c("Method", "Patient"))

# Integrate Layers with Harmony 
seurat_obj <- IntegrateLayers(
  object = seurat_obj, method = HarmonyIntegration,
  orig.reduction = "pca", new.reduction = "harmony",
  verbose = FALSE
)

# Standard workflow steps
seurat_obj <- FindNeighbors(seurat_obj, 
                            reduction = "harmony", 
                            dims = 1:30)
seurat_obj <- FindClusters(seurat_obj, 
                           resolution = 2, 
                           cluster.name = "harmony.clusters")
seurat_obj <- RunUMAP(seurat_obj, 
                      reduction = "harmony",
                      dims = 1:30, 
                      reduction.name = "umap.harmony")

# Join layers 
seurat_obj <- JoinLayers(seurat_obj)

# Patient cluster plot 
plots <- DimPlot(
    seurat_obj,
    pt.size = 1, 
    group.by = "Patient",
    reduction = "umap.harmony",
    label.size = 2
  )
plots <- lapply(plots, function(p) p + 
                  theme_bw() + 
                  labs(x = "UMAP 1", 
                       y = "UMAP 2", 
                       title = ""))
ggsave( paste0(save_dir, "Harmonized-AML-Diagnosis-Patient-Cluster.png"), 
       plot = patchwork::wrap_plots(plots), 
       height = 10, 
       width = 12)

# Cell type cluster plot 
plots <- DimPlot(
  seurat_obj,
  pt.size = 1, 
  group.by = "CellType",
  reduction = "umap.harmony",
  label.size = 2
)
plots <- lapply(plots, function(p) p + 
                  theme_bw() + 
                  labs(x = "UMAP 1", 
                       y = "UMAP 2", 
                       title = ""))
ggsave( paste0(save_dir, "Harmonized-AML-Diagnosis-CellType-Cluster.png"), 
       plot = patchwork::wrap_plots(plots), 
       height = 10, 
       width = 12)

# Malignant cell type cluster plot 
plots <- DimPlot(
  seurat_obj,
  pt.size = 1, 
  group.by = "PredictionRF2",
  reduction = "umap.harmony",
  label.size = 2
)
plots <- lapply(plots, function(p) p + 
                  theme_bw() + 
                  labs(x = "UMAP 1", 
                       y = "UMAP 2", 
                       title = ""))
ggsave( paste0(save_dir, "Harmonized-AML-Diagnosis-PredictionRF2-Cluster.png"), 
       plot = patchwork::wrap_plots(plots), 
       height = 10, 
       width = 12)

# Save lean object (drop large raw matrices)
saveRDS(seurat_obj, 
        paste0(save_dir, "Harmonized-AML-Diagnosis-Bone-Marrow.rds"))

# -------------------------------------------------------------------------
# END OF SCRIPT 
# -------------------------------------------------------------------------










