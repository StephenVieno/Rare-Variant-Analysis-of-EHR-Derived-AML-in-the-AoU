setwd("/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/")

# Load the package
library(tidyverse)
library(ggplot2)
library(data.table)

# -------------------------------------------------------------------------
# CORRELATION PLOT 
# -------------------------------------------------------------------------

EUR_aml_phenotype_plink <- list()

for (chrom in 1:22){
  print(paste0("Processing chromosome ", chrom," ...."))
  EUR_aml_phenotype_plink_chr <- 
    fread(paste0("Summary-Statistics/EUR_aml_phenotype_plink_chr", chrom))
  EUR_aml_phenotype_plink_chr_deprivation_index <- 
    fread(paste0("Summary-Statistics/EUR_aml_phenotype_plink_chr", chrom,"_deprivation_index"))
  EUR_aml_phenotype_plink_chr <- 
    dplyr::select(as.data.frame(EUR_aml_phenotype_plink_chr), ID, P) %>% 
    rename("P_No_Deprivation_Index" = "P")
  EUR_aml_phenotype_plink_chr_deprivation_index <- 
    dplyr::select(as.data.frame(EUR_aml_phenotype_plink_chr_deprivation_index), ID, P) %>% 
    rename("P_Deprivation_Index" = "P")
  
  EUR_aml_phenotype_plink_chr <- inner_join(EUR_aml_phenotype_plink_chr_deprivation_index, 
                                            EUR_aml_phenotype_plink_chr, 
                                            by ="ID")
  
  EUR_aml_phenotype_plink[[chrom]] <- EUR_aml_phenotype_plink_chr
}

EUR_aml_phenotype_plink <- do.call(rbind, EUR_aml_phenotype_plink)

results_joined <- 
  EUR_aml_phenotype_plink %>% 
  mutate(Negative_Log_P_Deprivation_Index = -log10(P_Deprivation_Index), 
         Negative_Log_P_No_Deprivation_Index = -log10(P_No_Deprivation_Index))

# Compute Spearman correlation
spearman <- cor(results_joined$Negative_Log_P_No_Deprivation_Index,
                results_joined$Negative_Log_P_Deprivation_Index, 
                method = "spearman")

# Create a new column for color
results_joined$point_color <- ifelse(results_joined$Negative_Log_P_Deprivation_Index > 
                                       results_joined$Negative_Log_P_No_Deprivation_Index, 
                                     "#F5D000FF", "#172869FF")

correlation_plot <- 
  ggplot(results_joined, aes(x = Negative_Log_P_No_Deprivation_Index, 
                             y = Negative_Log_P_Deprivation_Index)) + 
  geom_point(color = results_joined$point_color, alpha = 0.5) + 
  geom_abline(intercept = 0, slope = 1, color = "#DD5129FF", linetype = "dashed", linewidth = 1.2) +
  labs(title = paste0("Spearman Correlation: ", round(spearman, 3)), 
       x = "No Deprivation Index (-log10(p-values))", 
       y = "Deprivation Index (-log10(p-values))") +
  theme_bw()

# Save plot
ggsave(
  filename = paste0("Plots/corrrelation_single_variant_plot.png"), 
  plot = correlation_plot, height = 9, width = 9, dpi = 300
)

# -------------------------------------------------------------------------
# END OF SCRIPT  
# -------------------------------------------------------------------------
