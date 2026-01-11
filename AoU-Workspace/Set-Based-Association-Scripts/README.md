
# AML - SAIGE-GENE SET BASED - ASSOCIATION ANALYSIS
### AML-SAIGE-GENE-Set-Based-Step01.ipynb
This script calculates variant minor allele counts from the genomic PLINK file used to generate the sparse Genetic Relationship Matrix (GRM). Before computing the counts, the PLINK file is subsetted to exclude samples that were not used in constructing the sparse GRM.

### AML-SAIGE-GENE-Set-Based-Step02.ipynb
This script generates a list of 2,000 randomly selected variants for variance ratio estimation in SAIGE-GENE set-based analysis. Multiple variance ratios must be estimated based on different minor allele count (MAC) categories when –isCateVarianceRatio=TRUE. This differs from Step 1 in SAIGE for single-variant tests, where only a single variance ratio is estimated. By default, two variance ratios are estimated for the categories 10 ≤ MAC < 20 and MAC ≥ 20.

### AML-SAIGE-GENE-Set-Based-Step03.ipynb
This script creates the PLINK file used for variance ratio estimation. Note that the file must contain at least 200 variants with MAC values falling within the specified categories. This PLINK file is used only for variance ratio estimation and contains random markers extracted from the LD-pruned PLINK file used for constructing the GRM and performing variance ratio estimation.

### AML-SAIGE-GENE-Set-Based-Step04.ipynb
The following script is used to fit the null model for the set-based SAIGE-GENE analysis. The options useSparseGRMtoFitNULL, useSparseGRMforVarRatio, and isCateVarianceRatio must be set to TRUE. This script uses the sparse GRM, 2,000 randomly selected variants in the specified MAC categories, and the phenotype file with covariates to fit the null model.

### AML-SAIGE-GENE-Set-Based-Step05.ipynb
This script performs rare variant set-based gene association tests for each chromosome using SAIGE-GENE+. It is configured to use the sparse GRM with 2,000 randomly selected markers to estimate the variance ratio. Maximum minor allele frequency thresholds for each test are set at 1%, 0.1%, and 0.001%. The script evaluates the annotation groups Missense, Loss-of-Function, and a combination of Missense and Loss-of-Function. An additional analysis is conducted using only synonymous variants; this is executed with a separate command so that the Cauchy values from the first test reflect only predicted deleterious variants (Missense and Loss-of-Function).

### AML-SAIGE-GENE-Set-Based-Step04-Deprivation-Index.ipynb
The following script is used to fit the null model for the set-based SAIGE-GENE analysis. The options useSparseGRMtoFitNULL, useSparseGRMforVarRatio, and isCateVarianceRatio must be set to TRUE. This script uses the sparse GRM, 2,000 randomly selected variants in the specified MAC categories, and the phenotype file with covariates to fit the null model.

### AML-SAIGE-GENE-Set-Based-Step05-Deprivation-Index.ipynb
This script performs rare variant set-based gene association tests for each chromosome using SAIGE-GENE+. It is configured to use the sparse GRM with 2,000 randomly selected markers to estimate the variance ratio. Maximum minor allele frequency thresholds for each test are set at 1%, 0.1%, and 0.001%. The script evaluates the annotation groups Missense, Loss-of-Function, and a combination of Missense and Loss-of-Function. An additional analysis is conducted using only synonymous variants; this is executed with a separate command so that the Cauchy values from the first test reflect only predicted deleterious variants (Missense and Loss-of-Function).

### AML-SAIGE-GENE-Set-Based-Step04-Deprivation.ipynb
The following script is used to fit the null model for the set-based SAIGE-GENE analysis. The options useSparseGRMtoFitNULL, useSparseGRMforVarRatio, and isCateVarianceRatio must be set to TRUE. This script uses the sparse GRM, 2,000 randomly selected variants in the specified MAC categories, and the phenotype file with covariates to fit the null model.

### AML-SAIGE-GENE-Set-Based-Step05-Deprivation.ipynb
This script performs rare variant set-based gene association tests for each chromosome using SAIGE-GENE+. It is configured to use the sparse GRM with 2,000 randomly selected markers to estimate the variance ratio. Maximum minor allele frequency thresholds for each test are set at 1%, 0.1%, and 0.001%. The script evaluates the annotation groups Missense, Loss-of-Function, and a combination of Missense and Loss-of-Function. An additional analysis is conducted using only synonymous variants; this is executed with a separate command so that the Cauchy values from the first test reflect only predicted deleterious variants (Missense and Loss-of-Function).

# Overview Pipeline 
```markdown
SET-BASED SAIGE-GENE+
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
Set-Based or Single Variant SAIGE-GENE+ -> Single Variant Pipepline 
   |
   v
Set-Based Pipeline <- GRM-QC-Step04 <- GRM-QC-Step03 <- GRM-QC-Step02 <- GRM-QC-Step01 (SAIGE-GENE Step 0) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step01 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step02 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step03 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step04 (SAIGE-GENE Step 1) or AML-SAIGE-GENE-Set-Based-Step04-Deprivation-Index
   |
   v
AML-SAIGE-GENE-Set-Based-Step05 (SAIGE-GENE Step 2) or AML-SAIGE-GENE-Set-Based-Step05-Deprivation-Index
- Group Annotation Files required
```

