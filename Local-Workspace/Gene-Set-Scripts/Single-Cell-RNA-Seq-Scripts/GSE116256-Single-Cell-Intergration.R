
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
  filter(grepl("AML", title)) |>
  mutate(sample_id = gsub("-anno", "", title))
# List of unique samples 
sample_list <- unique(metadata$sample_id)
sample_list <- sample_list[!grepl("OCI-AML3", sample_list)]


# Loop for generating single sample QC plots 
for (sample_id in sample_list){ 
  # Load single cell data 
  print(sample_id)
  # Acquire single-cell data files 
  files <- list.files(path = master_dir, 
                      pattern = sample_id)
  
  # Read expression matrix
  expr <- read.delim(paste0(master_dir, files[1]), row.names = 1, check.names = FALSE)
  # The DEM file: rows are genes, columns are cell barcodes
  
  # Read annotation file
  anno <- read.delim(paste0(master_dir, files[2]), row.names = 1, check.names = FALSE)
  # The ANNO file: rows correspond to the same cell barcodes
  
  # Read second annotation file
  doublet <- read.delim(paste0(save_dir, "Doublet-Finder-", sample_id,".tsv"), row.names = 1, check.names = FALSE)
  # Create id column for join 
  doublet <- 
    doublet |> 
    rownames_to_column(var="id") |> 
    select(id, colnames(doublet)[grepl("DF.classifications", colnames(doublet))])

  # Check matching order
  all(colnames(expr) %in% rownames(anno))
  # TRUE → proceed
  
  # Create Seurat object
  seurat_obj <- CreateSeuratObject(counts = expr, meta.data = anno)
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
diagnosis_list <- sample_list[grepl("D0", sample_list)]
# Merge samples together into single object 
seurat_obj <- merge(AML1012_D0, y = c(AML210A_D0, AML314_D0, AML328_D0, AML329_D0,
                                      AML371_D0, AML419A_D0, AML420B_D0, AML475_D0, 
                                      AML556_D0, AML707B_D0, AML722B_D0, AML870_D0, 
                                      AML916_D0, AML921A_D0, AML997_D0),
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
# Check 
print(table(seurat_obj$doublet))

# Apply SCTranform to normalize the data 
seurat_obj <- SCTransform(seurat_obj)
seurat_obj <- RunPCA(seurat_obj, npcs = 30, verbose = F)

# Harmonize data across samples 
options(future.globals.maxSize = 20 * 1024^3)
seurat_obj <- IntegrateLayers(
  object = seurat_obj,
  method = HarmonyIntegration,
  normalization.method = "SCT",
  verbose = F
)
# Cluster samples 
seurat_obj <- FindNeighbors(seurat_obj, 
                            dims = 1:30, 
                            reduction = "harmony")
seurat_obj <- FindClusters(seurat_obj, 
                           resolution = 2)
seurat_obj <- RunUMAP(seurat_obj, 
                      dims = 1:30, 
                      reduction = "harmony")
# Patient cluster plot 
plots <- DimPlot(
    seurat_obj,
    pt.size = 1, 
    group.by = "Patient",
    combine = FALSE,
    label.size = 2
  )
plots <- lapply(plots, function(p) p + 
                  theme_bw() + 
                  labs(x = "UMAP 1", 
                       y = "UMAP 2", 
                       title = ""))
ggsave("Harmonized-AML-Diagnosis-Patient-Cluster.png", 
       plot = patchwork::wrap_plots(plots), 
       height = 5, 
       width = 6)

# Cell type cluster plot 
plots <- DimPlot(
  seurat_obj,
  pt.size = 1, 
  group.by = "CellType",
  combine = FALSE,
  label.size = 2
)
plots <- lapply(plots, function(p) p + 
                  theme_bw() + 
                  labs(x = "UMAP 1", 
                       y = "UMAP 2", 
                       title = ""))
ggsave("Harmonized-AML-Diagnosis-CellType-Cluster.png", 
       plot = patchwork::wrap_plots(plots), 
       height = 5, 
       width = 6)

# Malignant cell type cluster plot 
plots <- DimPlot(
  seurat_obj,
  pt.size = 1, 
  group.by = "PredictionRF2",
  combine = FALSE,
  label.size = 2
)
plots <- lapply(plots, function(p) p + 
                  theme_bw() + 
                  labs(x = "UMAP 1", 
                       y = "UMAP 2", 
                       title = ""))
ggsave("Harmonized-AML-Diagnosis-PredictionRF2-Cluster.png", 
       plot = patchwork::wrap_plots(plots), 
       height = 5, 
       width = 6)

# Save lean object (drop large raw matrices)
saveRDS(seurat_obj, 
        paste0(save_dir, "Harmonized-AML-Diagnosis-Bone-Marrow.rds"))

# -------------------------------------------------------------------------
# END OF SCRIPT 
# -------------------------------------------------------------------------










