# Sparse GRM SAIGE-GENE+

This directory contains Jupyter notebooks for preparing genotype data and calculating ancestry-specific sparse genetic relationship matrices (GRMs) for downstream SAIGE-GENE+ analyses in the All of Us (AoU) Research Program. The scripts perform variant-level quality control, linkage disequilibrium (LD) pruning, genotype data preparation, and sparse GRM calculation across the African, American, and European ancestry groups.

## GRM Quality Control and Preparation

### `02_04_grm_qc_step01.ipynb`

- This notebook filters variants for inclusion in the genetic relationship matrix (GRM). Variants are removed if they are duplicated, multiallelic, non-single nucleotide variants (non-SNVs), or ambiguous.
- Variants passing these filters are subsequently used for pruning the All of Us microarray data before calculating the GRM and performing principal component analysis (PCA).
- In `bcftools`, a multiallelic site refers to a genomic position with more than one alternative allele. The equivalent command for retaining biallelic variants is:

  ```bash
  bcftools view -m 2 -M 2 multi_allelic_sites.vcf > biallelic_sites.vcf
  ```

### `02_02_grm_qc_step02.ipynb`

- This notebook prunes array genotype data in the African, American, and European ancestry groups for GRM calculation and PCA.
- Variants are initially filtered based on the following criteria:
  - Minor allele frequency (MAF) of at least 0.01%.
  - Genotype missingness rate below 0.01%.
  - Hardy–Weinberg equilibrium (HWE) p-value greater than \(1 \times 10^{-6}\).
  - Biallelic variants located on autosomal chromosomes.
- Linkage disequilibrium (LD) pruning is performed within a 200 kb window, removing variants with \(r^2 > 0.1\).
- The output consists of variant lists containing markers that pass these filters. The African and American ancestry groups are expected to retain the highest numbers of variants, while the European ancestry group is expected to retain the lowest number.
- Variants passing this initial filtering undergo a second pruning step before being used for GRM calculation and PCA.

### `02_03_grm_qc_step03.ipynb`

- This notebook generates PLINK files from array genotype data for the African, American, and European ancestry groups using variants that passed the second pruning step.
- The resulting genotype files are used for subsequent GRM calculation and PCA.

## Sparse GRM Calculation

### `02_04_grm_qc_step04.ipynb`

- This notebook calculates ancestry-specific genetic relationship matrices for the African, American, and European ancestry groups using the Sparse GRM approach.
- The GRMs are constructed using 5,000 randomly selected markers, a minor allele frequency (MAF) threshold of greater than 0.01, and a relatedness cutoff of 0.05.
- The resulting sparse GRMs are used as input for downstream SAIGE-GENE+ association analyses.

## Execution Order

The notebooks should generally be executed in the following order:

1. **`02_04_grm_qc_step01.ipynb`** – Filter variants for GRM construction.
2. **`02_02_grm_qc_step02.ipynb`** – Perform ancestry-specific genotype filtering and LD pruning.
3. **`02_03_grm_qc_step03.ipynb`** – Generate PLINK genotype files using the filtered variants.
4. **`02_04_grm_qc_step04.ipynb`** – Calculate ancestry-specific sparse GRMs.

## Notes

- These notebooks were developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily.
- These scripts are no longer compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.
- The resulting sparse GRMs were intended for use in downstream SAIGE-GENE+ rare-variant association analyses.
