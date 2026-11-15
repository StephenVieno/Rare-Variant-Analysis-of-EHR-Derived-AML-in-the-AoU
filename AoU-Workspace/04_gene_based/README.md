# Annotation Sensitivity Pipeline 
### AML-Annotation-Threshold-Analysis.ipynb
- This script submits SAIGE-GENE+ rare variant set-based gene association analyses for four different annotation groups. On the smallest chromosome, chromosome 21, this was performed as part of a sensitivity analysis to determine the optimal threshold for each category to be used in the main analysis. Specifically, this included determining the threshold for LOFTEE to classify loss-of-function variants, the threshold for SpliceAI scores to identify splicing variants, the threshold for AlphaMissense scores to classify missense variants, and the use of synonymous variants as a negative control.
   - Annotation Script: [Single-Class-Annotations.py](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/tree/main/Local-Workspace/Annotation-Scripts)

### AML-Annotation-Threshold-Manhattan-Plot.ipynb
- This script plots the results from the annotation sensitivity analysis to demonstrate which thresholds are optimal for each variant annotation category. In the AML results, the optimal thresholds were determined as follows:

   - high-confidence loss-of-function variants from LOFTEE for the loss-of-function category;
   - SpliceAI scores greater than 0.8 for splice variants;
   - AlphaMissense scores greater than 0.546 for missense variants;
   - and synonymous variants identified by VEP with SpliceAI scores less than 0.5 for the synonymous category.

# SAIGE-GENE+ Set-based Association Pipeline
### AML-SAIGE-GENE-Set-Based-Step01.ipynb
- This script calculates variant minor allele counts from the genomic PLINK file used to generate the sparse Genetic Relationship Matrix (GRM). Before computing the counts, the PLINK file is subsetted to exclude samples that were not used in constructing the sparse GRM.

### AML-SAIGE-GENE-Set-Based-Step02.ipynb
- This script generates a list of 2,000 randomly selected variants for variance ratio estimation in SAIGE-GENE set-based analysis. Multiple variance ratios must be estimated based on different minor allele count (MAC) categories when –isCateVarianceRatio=TRUE. This differs from Step 1 in SAIGE for single-variant tests, where only a single variance ratio is estimated. By default, two variance ratios are estimated for the categories 10 ≤ MAC < 20 and MAC ≥ 20.

### AML-SAIGE-GENE-Set-Based-Step03.ipynb
- This script creates the PLINK file used for variance ratio estimation. Note that the file must contain at least 200 variants with MAC values falling within the specified categories. This PLINK file is used only for variance ratio estimation and contains random markers extracted from the LD-pruned PLINK file used for constructing the GRM and performing variance ratio estimation.

### AML-SAIGE-GENE-Set-Based-Step04.ipynb
- The following script is used to fit the null model for the set-based SAIGE-GENE analysis. The options useSparseGRMtoFitNULL, useSparseGRMforVarRatio, and isCateVarianceRatio must be set to TRUE. This script uses the sparse GRM, 2,000 randomly selected variants in the specified MAC categories, and the phenotype file with covariates to fit the null model.

### AML-SAIGE-GENE-Set-Based-Step05.ipynb
- This script performs rare variant set-based gene association tests for each chromosome using SAIGE-GENE+. It is configured to use the sparse GRM with 2,000 randomly selected markers to estimate the variance ratio. Maximum minor allele frequency thresholds for each test are set at 1%, 0.1%, and 0.001%. The script evaluates the annotation groups Missense, Loss-of-Function, and a combination of Missense and Loss-of-Function. An additional analysis is conducted using only synonymous variants; this is executed with a separate command so that the Cauchy values from the first test reflect only predicted deleterious variants (Missense and Loss-of-Function).

### AML-SAIGE-GENE-Set-Based-Step04-Deprivation-Index.ipynb
- The following script is used to fit the null model for the set-based SAIGE-GENE analysis. The options useSparseGRMtoFitNULL, useSparseGRMforVarRatio, and isCateVarianceRatio must be set to TRUE. This script uses the sparse GRM, 2,000 randomly selected variants in the specified MAC categories, and the phenotype file with covariates to fit the null model.

### AML-SAIGE-GENE-Set-Based-Step05-Deprivation-Index.ipynb
- This script performs rare variant set-based gene association tests for each chromosome using SAIGE-GENE+. It is configured to use the sparse GRM with 2,000 randomly selected markers to estimate the variance ratio. Maximum minor allele frequency thresholds for each test are set at 1%, 0.1%, and 0.001%. The script evaluates the annotation groups Missense, Loss-of-Function, and a combination of Missense and Loss-of-Function. An additional analysis is conducted using only synonymous variants; this is executed with a separate command so that the Cauchy values from the first test reflect only predicted deleterious variants (Missense and Loss-of-Function).

### AML-SAIGE-GENE-Set-Based-Step04-Deprivation.ipynb
- The following script is used to fit the null model for the set-based SAIGE-GENE analysis. The options useSparseGRMtoFitNULL, useSparseGRMforVarRatio, and isCateVarianceRatio must be set to TRUE. This script uses the sparse GRM, 2,000 randomly selected variants in the specified MAC categories, and the phenotype file with covariates to fit the null model.

### AML-SAIGE-GENE-Set-Based-Step05-Deprivation.ipynb
- This script performs rare variant set-based gene association tests for each chromosome using SAIGE-GENE+. It is configured to use the sparse GRM with 2,000 randomly selected markers to estimate the variance ratio. Maximum minor allele frequency thresholds for each test are set at 1%, 0.1%, and 0.001%. The script evaluates the annotation groups Missense, Loss-of-Function, and a combination of Missense and Loss-of-Function. An additional analysis is conducted using only synonymous variants; this is executed with a separate command so that the Cauchy values from the first test reflect only predicted deleterious variants (Missense and Loss-of-Function).

# SAIGE-GENE+ Set-based Association Plot Scripts 
### AML-Manhattan-Plot.ipynb 
– This script generates a standard Manhattan plot to visualize genome-wide association signals across chromosomes.
### AML-Manhattan-Cauchy-Plot.ipynb 
– This script produces a Manhattan plot based on Cauchy-combined p-values, enabling aggregation of multiple tests or models into a single association signal.
### AML-Manhattan-MAF-Threshold-Plot.ipynb 
– This script creates Manhattan plots stratified or filtered by minor allele frequency (MAF) thresholds to evaluate the impact of allele frequency on association signals.
### AML-QQ-Plot.ipynb 
– This script generates quantile–quantile (QQ) plots to assess p-value calibration, inflation, and potential population stratification.
### AML-Correlation-Check-Plot.ipynb 
– This script visualizes correlations among summary statistics (comparing analyses with and without inclusion of the deprivation index) to identify differences in genetic signals.
