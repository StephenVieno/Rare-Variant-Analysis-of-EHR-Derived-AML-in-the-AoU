# -------------------------------------------------------------------------
# PACKAGES 
# -------------------------------------------------------------------------
library(tidyverse)
library(data.table)
library(survival)
# -------------------------------------------------------------------------
# CLINICAL DATA 
# -------------------------------------------------------------------------
# Directory for clinical data 
setwd("/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Gene-Sets/")
# Load expression data 
data <- fread("GDC/RNA-Seq-Cox-Regression/Formatted-AML-RNA-Seq-Primary-Tumour-Peripheral-Blood.tsv")

# -------------------------------------------------------------------------
# SCALE DATA 
# -------------------------------------------------------------------------

# Select columns to scale
cols_to_scale <- grep("^ENSG|^PC|^diagnoses.age_at_diagnosis$", names(df), value = TRUE)
# Scale selected columns (mean=0, sd=1)
data <- data %>%
  mutate(across(all_of(cols_to_scale), ~ scale(.)))

# -------------------------------------------------------------------------
# COX REGRESSION  
# -------------------------------------------------------------------------

# Loop number 
loop <- 0 
# Loop 1000 number 
loop1000 <- 0 
# List of cox regression results 
gene_data <- list()
# List of all protein coding genes 
gene_list <- colnames(data)[grep("ENSG", colnames(data))]

# Cox regression loop 
for (gene in gene_list) {
  # print(paste("Processing",gene,"...."))
  
  # Print every 100 loops 
  loop <- loop + 1
  if (loop %% 100== 0) {
    loop1000 <- loop1000 + 100
    print(paste("Completed Gene", loop1000))
  }
  
  # Check that factors possess multiple levels 
  vars <- c(gene, "diagnoses.age_at_diagnosis", "gender")
  
  # Keep only variables with > 1 unique value
  valid_vars <- vars[sapply(vars, function(v) length(unique(na.omit(data[[v]]))) > 1)]
  
  # Skip if gene or covariates have no variance
  if (!(gene %in% valid_vars)) {
    warning(paste("Skipping", gene, "- no expression variance"))
    next
  }
  
  # Define formula for cox regression 
  formula_str <- paste0("Surv(time_to_event, vital_status) ~ ", 
                        paste(valid_vars, collapse = " + "))
  
  # Create formula object for cox regression 
  formula_obj <- as.formula(formula_str)
  
  # Fit cox regresssion model 
  cox_model <- coxph(formula_obj, data = data)
  # Summary of cox regression model 
  cox_model_summary <- summary(cox_model)
  # Create data frame of p-value results
  summary <- janitor::clean_names(as.data.frame(cox_model_summary[7]))
  # Select p-value results for each gene 
  gene_data[[gene]] <- summary[1,]
}

# -------------------------------------------------------------------------
# FORMAT AND SAVE RESULTS 
# -------------------------------------------------------------------------

# Combine results together in single data frame 
gene_data <- rownames_to_column(do.call(rbind, gene_data), var ="gene_id") 
# Bonferroni correction
gene_data$bonferroni_p <- p.adjust(gene_data$coefficients_pr_z, method = "bonferroni")
# Save formula
readr::write_tsv(as.data.frame(formula_str),
                 "GDC/RNA-Seq-Cox-Regression/aml-rna-seq-primary-tumour-peripheral-blood-formula.tsv")

# Save cox regression results
readr::write_tsv(gene_data,
                 "GDC/RNA-Seq-Cox-Regression/aml-rna-seq-primary-tumour-peripheral-blood-cox-regression-results.tsv")

# Save significant cox regression results
readr::write_tsv(filter(gene_data, bonferroni_p < 0.05),
                 "GDC/RNA-Seq-Cox-Regression/aml-rna-seq-primary-tumour-peripheral-blood-cox-regression-significant-results.tsv")

# Save significant results that increase the risk of mortality
readr::write_tsv(filter(gene_data, (coefficients_coef > 0) & (bonferroni_p < 0.05)),
                 "GDC/RNA-Seq-Cox-Regression/aml-rna-seq-primary-tumour-peripheral-blood-cox-regression-upregulation-significant-results.tsv")

# Save significant results that decrease the risk of mortality
readr::write_tsv(filter(gene_data, (coefficients_coef < 0) & (bonferroni_p < 0.05)),
                 "GDC/RNA-Seq-Cox-Regression/aml-rna-seq-primary-tumour-peripheral-blood-cox-regression-downregulation-significant-results.tsv")


# -------------------------------------------------------------------------
# END OF SCRIPT 
# -------------------------------------------------------------------------


