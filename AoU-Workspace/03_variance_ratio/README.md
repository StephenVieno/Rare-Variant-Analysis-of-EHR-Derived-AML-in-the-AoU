# 3 – Variance Ratio Estimation

This directory contains Jupyter notebooks for preparing the genotype data required for variance ratio estimation in SAIGE-GENE+ set-based association analyses. The scripts calculate minor allele counts (MAC), select variants for variance ratio estimation, and generate the corresponding PLINK files.

## Notebooks

| **Notebook** | **Description** |
|---|---|
| `03_01_aml_saige_gene_based_step01.ipynb` | Calculates variant minor allele counts (MAC) from the PLINK genotype data used to construct the sparse genetic relationship matrix (GRM). Before calculating allele counts, the PLINK dataset is restricted to individuals included in the sparse GRM. |
| `03_02_aml_saige_gene_based_step02.ipynb` | Generates a set of 2,000 randomly selected variants for variance ratio estimation in SAIGE-GENE+ set-based association analyses. When `isCateVarianceRatio=TRUE`, separate variance ratios are estimated for different MAC categories.  |
| `03_03_aml_saige_gene_based_step03.ipynb` | Generates the PLINK genotype files used for variance ratio estimation. The resulting dataset must contain at least 200 variants within each specified MAC category. Variants are randomly selected from the LD-pruned PLINK dataset used for sparse GRM construction and variance ratio estimation. |

## Notes

- The variance ratio estimation procedure follows the SAIGE-GENE+ set-based association testing workflow.
- Multiple variance ratios are required when categorical variance ratio estimation is enabled using `isCateVarianceRatio=TRUE`.
- The selected variants are used for variance ratio estimation and are distinct from the variants tested in the gene-based association analysis.
