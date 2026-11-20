# -------------------------------------------------------------------------
# PACKAGES 
# -------------------------------------------------------------------------

library(Seurat)
library(SeuratDisk)
library(ggplot2)
library(tidyverse)
library(gridExtra)
library(data.table)
library(patchwork)
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
  filter(!grepl("OCI", title)) |> 
  mutate(sample_id = gsub("-anno", "", title))
# List of unique samples 
sample_list <- unique(metadata$sample_id)

# -------------------------------------------------------------------------
# SINGLE CELL QC LOOP 
# -------------------------------------------------------------------------

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

  # Labels for violin plot 
  metric_labels <- c(
    nFeature_RNA = "Number of Features",
    nCount_RNA   = "Total Counts",
    percent.mt   = "Percent Mitochondrial"
  )
  
  # Violin plot of Features, RNA Count, and Mitochondrial Percentage 
  plot1 <- 
    seurat_obj@meta.data %>%
    as.data.frame() %>%
    pivot_longer(
      cols = c("nFeature_RNA", "nCount_RNA", "percent.mt"),
      names_to = "metric_type",
      values_to = "metric_value"
    ) %>%
    ggplot(aes(x = metric_type, y = metric_value, fill = metric_type)) +
    geom_violin(alpha = 0.5) +
    geom_jitter(width = 0.2, size = 0.5, alpha = 0.5) +
    labs(y = "Actual value", x = "Metric type") +
    theme_bw() +
    paletteer::scale_fill_paletteer_d("LaCroixColoR::Lemon") + 
    facet_wrap(vars(metric_type), scales = "free", labeller = as_labeller(metric_labels)) + 
    guides(fill = "none") + 
    theme(
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank()
    ) + labs(x = NULL, y = NULL)
  
  # Scatter plot of Features vs RNA Count 
  plot2 <- 
    FeatureScatter(seurat_obj, feature1 = "nCount_RNA", feature2 = "nFeature_RNA") +
    geom_smooth(method = 'lm', color = "black")  + 
    theme_bw() + 
    guides(color = "none") + 
    paletteer::scale_color_paletteer_d("LaCroixColoR::Lemon") + 
    labs(y = "Number of Features", x = "RNA Count")

  # Merge plots 
  plot <- (plot1 | plot2)
  
  # Save plot of QC metrics 
  ggsave(paste0(save_dir, sample_id, "-QC-Plot.png"), 
         plot = plot, 
         width = 20, 
         height = 10)
} 

print("Completed QC Check")
# -------------------------------------------------------------------------
# END OF THE SCRIPT 
# -------------------------------------------------------------------------

