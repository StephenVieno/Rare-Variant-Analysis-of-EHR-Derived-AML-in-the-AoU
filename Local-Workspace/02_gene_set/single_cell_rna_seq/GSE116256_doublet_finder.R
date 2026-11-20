
# -------------------------------------------------------------------------
# PACKAGES 
# -------------------------------------------------------------------------

# load libraries
library(Seurat)
library(SeuratDisk)
library(ggplot2)
library(tidyverse)
library(gridExtra)
library(data.table)
library(DoubletFinder)
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
  mutate(sample_id = gsub("-anno", "", title))
# List of unique samples 
sample_list <- unique(metadata$sample_id)
sample_list <- sample_list[!grepl("OCI-AML3|MUTZ3", sample_list)]

# -------------------------------------------------------------------------
# SINGLE CELL DOUBLET FINDER LOOP 
# -------------------------------------------------------------------------

# Proportion of cell to nanowells 
y <- (10000/90000)
# Expected proportion of doublets using Poisson disturbition 
expected_doublet  <- (1-exp(-y)*(1+y))
# Check expected doublet rate 
print(expected_doublet)

# Loop for generating single sample QC plots 
for (sample_id in sample_list){ 
  # Load single cell data 
  print(sample_id)
  # Create Seurat objects
  seurat_obj <- readRDS(paste0(save_dir,"Processed-SCT-",sample_id,".rds"))
    
  # Pk identification parameter sweep 
    sweep_seurat_obj <- paramSweep(seurat_obj, 
                                   PCs = 1:10, 
                                   sct = TRUE, 
                                   num.cores = 1)
    # Acquire sweep statistics 
    sweep_stats_seurat_obj<- summarizeSweep(sweep_seurat_obj, GT = FALSE)
    # Find pk values 
    stats_seurat_obj <- find.pK(sweep_stats_seurat_obj)
    
    # Pk value plot 
    plot <- 
    ggplot(stats_seurat_obj, aes(pK, BCmetric, group = 1)) +
      geom_point() +
      geom_line() + 
      theme_bw() 
    ggsave(paste0(save_dir,"Doublet-Finder-",sample_id,"-BCMetric.png"),
           plot = plot,
           height = 4, 
           width = 10)
    
    # select the pK that corresponds to max bcmvn to optimize doublet detection
    pK <- stats_seurat_obj %>% 
      filter(BCmetric == max(BCmetric)) %>%
      dplyr::select(pK) 
    pK <- as.numeric(as.character(pK[[1]]))
    
    ## Assuming 0.5734092 % doublet formation rate 
    annotations <- seurat_obj@meta.data$seurat_clusters
    homotypic.prop <- modelHomotypic(annotations)    
    nExp_poi <- round(expected_doublet*nrow(seurat_obj@meta.data)) 
    nExp_poi.adj <- round(nExp_poi*(1-homotypic.prop))
    
    # Run Doublet Finder 
    seurat_obj <- doubletFinder(seurat_obj, 
                                PCs = 1:10, 
                                pN = 0.25, 
                                pK = pK, 
                                nExp = nExp_poi.adj,
                                reuse.pANN = NULL, 
                                sct = TRUE)
    # Cluster plot 
    group <- colnames(seurat_obj@meta.data)[grepl("DF.classifications", colnames(seurat_obj@meta.data))]
    plot <- DimPlot(seurat_obj, 
            reduction = 'umap', 
            cols = c("#F5D000FF", "#172869FF"), 
            pt.size = 1.5, 
            group.by = group) + 
    labs(x = "UMAP 1" , y = "UMAP 2", title ="") + 
    theme_bw() 
    
    ggsave(paste0(save_dir,"Doublet-Finder-",sample_id,"-Cluster.png"),
           plot = plot,
           height = 5, 
           width = 6)
    
    # Format Doublet Finder results  
    doublet_seurat_info <- 
      seurat_obj@meta.data |> 
      as.data.frame() |> 
      rownames_to_column(var = "molecular_id") 
    doublet_seurat_info$sample_id <- rep(sample_id, nrow(doublet_seurat_info))
    # Save Doublet Finder results 
    write_tsv(doublet_seurat_info, 
              paste0(save_dir, "Doublet-Finder-",sample_id,".tsv"))
    
    # Clean up large objects
    rm(seurat_obj, doublet_seurat_info, sweep_seurat_obj,
       sweep_stats_seurat_obj, stats_seurat_obj, annotations)
    gc(verbose = TRUE)
} 

print("End of Script")
# -------------------------------------------------------------------------
# END OF THE SCRIPT 
# -------------------------------------------------------------------------
  

