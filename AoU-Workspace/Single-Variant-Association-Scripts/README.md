# SAIGE-GENE+ Single Variant Association Pipeline
### AML-SAIGE-GENE-Single-Variant-Step01.ipynb
- This script creates a PLINK file containing 1,000 randomly selected variants from the microarray dataset that was used to calculate the Sparse Genetic Relationship Matrix. To generate this file, the microarray dataset is first subset to include only individuals from the cohort used in the single-variant analysis, after which variants not present in the PLINK file are removed. From the remaining variants, 1,000 are randomly selected for use in the variance ratio estimation step in SAIGE-GENE+ (Step 1) for the single-variant association test.

### AML-SAIGE-GENE-Single-Variant-Step02.ipynb
- This script fits the null model for SAIGE-GENE+ using the sparse GRM and 1,000 randomly selected markers from the PLINK file used to calculate the GRM. In this script, both useSparseGRMtoFitNULL and useSparseGRMforVarRatio must be set to TRUE, while skipVarianceRatioEstimation must be set to FALSE.

### AML-SAIGE-GENE-Single-Variant-Step03.ipynb
- This script runs the single-variant association test for SAIGE-GENE. Logistic Firth regression is used with a Firth cutoff of 0.1 (the default setting). Imputation best guess from SAIGE-GENE was used for the single variant association analysis. The option is_output_moreDetails must be TRUE must be specified to receive the full report for the single-variant SAIGE-GENE+ results.

# Pipeline Overview 
```markdown
Workspace Environment Scripts 
   |
   v
Pre-Analysis Files 
- File of Person IDs corresponding to Cases 
- File of Age and Observation Period (Observation-Period)
- Within-Ancestry PCs 
- Within-Ancestry QC 
   |
   v
 SAIGE-GENE+ Phenotype File 
 - AML-Phenotype-File
 - AML-Deprivation-Index-File 
   |
   v
Set-Based or Single Variant SAIGE-GENE+ -> Set-Based Pipepline 
   |
   v
Single Variant Pipeline <- SAIGE-GENE Step 0 (GRM-QC-Step01-GRM-QC-Step04)
   |
   v
AML-SAIGE-GENE-Single-Variant-Step01 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Single-Variant-Step02 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Single-Variant-Step03 (SAIGE-GENE Step 2)
```
