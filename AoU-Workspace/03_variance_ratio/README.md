# SAIGE-GENE+ Set-based Association Pipeline
### AML-SAIGE-GENE-Set-Based-Step01.ipynb
- This script calculates variant minor allele counts from the genomic PLINK file used to generate the sparse Genetic Relationship Matrix (GRM). Before computing the counts, the PLINK file is subsetted to exclude samples that were not used in constructing the sparse GRM.

### AML-SAIGE-GENE-Set-Based-Step02.ipynb
- This script generates a list of 2,000 randomly selected variants for variance ratio estimation in SAIGE-GENE set-based analysis. Multiple variance ratios must be estimated based on different minor allele count (MAC) categories when –isCateVarianceRatio=TRUE. This differs from Step 1 in SAIGE for single-variant tests, where only a single variance ratio is estimated. By default, two variance ratios are estimated for the categories 10 ≤ MAC < 20 and MAC ≥ 20.

### AML-SAIGE-GENE-Set-Based-Step03.ipynb
- This script creates the PLINK file used for variance ratio estimation. Note that the file must contain at least 200 variants with MAC values falling within the specified categories. This PLINK file is used only for variance ratio estimation and contains random markers extracted from the LD-pruned PLINK file used for constructing the GRM and performing variance ratio estimation.
