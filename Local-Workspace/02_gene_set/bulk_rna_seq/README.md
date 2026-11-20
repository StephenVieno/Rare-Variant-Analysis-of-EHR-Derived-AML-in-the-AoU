# Bulk RNA-Seq Analysis

This directory contains scripts for processing and analyzing bulk RNA-seq data from the NCI Genomic Data Commons (GDC) AML cohort. The workflow includes quality control, gene expression normalization, survival analysis, principal component analysis (PCA), and differential expression analysis. Generated gene sets are used in downstream rare variant polygenic risk score analyses.

## Scripts

| Script | Description |
|---|---|
| `RNA_seq_qc_normal_tissue.R` | Performs quality control of normal bone marrow RNA-seq samples. |
| `RNA_seq_qc_primary_tumour_bone_marrow.R` | Performs quality control of primary tumour bone marrow RNA-seq samples. |
| `RNA_seq_qc_primary_tumour_peripheral_blood.R` | Performs quality control of primary tumour peripheral blood RNA-seq samples. |
| `RNA_seq_normal_tissue_cox_regression.R` | Performs gene-level Cox regression survival analysis using normal bone marrow expression data. |
| `RNA_seq_primary_tumour_bone_marrow_cox_regression.R` | Performs gene-level Cox regression survival analysis using primary tumour bone marrow expression data. |
| `RNA_seq_primary_tumour_peripheral_blood_cox_regression.R` | Performs gene-level Cox regression survival analysis using primary tumour peripheral blood expression data. |
| `RNA_seq_differential_expression_pca.R` | Performs PCA to assess sample clustering and potential batch effects. |
| `RNA_seq_differential_expression_analysis.R` | Performs differential expression analysis between normal and primary tumour bone marrow samples. |

## Quality Control

The three quality control scripts assess bulk RNA-seq data from the following sample types:

- **`RNA_seq_qc_normal_tissue.R`** – Quality control of normal bone marrow samples.
- **`RNA_seq_qc_primary_tumour_bone_marrow.R`** – Quality control of primary tumour bone marrow samples.
- **`RNA_seq_qc_primary_tumour_peripheral_blood.R`** – Quality control of primary tumour peripheral blood samples.

## Cox Regression Gene Expression Analysis

The Cox regression scripts evaluate the association between protein-coding gene expression and patient survival across the three sample types.

Lowly expressed genes are removed based on raw counts <10, and the remaining gene expression values are variance-stabilized using DESeq2. Gene-level Cox regression models are fitted with adjustment for age and gender, with continuous variables standardized before analysis.

Gene-level p-values are Bonferroni-corrected, and significant genes are defined using a corrected p-value <0.05. Genes are separated into increased- and decreased-mortality gene sets according to their estimated hazard ratios (HR >1 and HR <1, respectively).

- **`RNA_seq_normal_tissue_cox_regression.R`** – Cox regression analysis of normal bone marrow gene expression.
- **`RNA_seq_primary_tumour_bone_marrow_cox_regression.R`** – Cox regression analysis of primary tumour bone marrow gene expression.
- **`RNA_seq_primary_tumour_peripheral_blood_cox_regression.R`** – Cox regression analysis of primary tumour peripheral blood gene expression.

## Differential Expression Analysis

**`RNA_seq_differential_expression_pca.R`**

Performs principal component analysis (PCA) to evaluate sample clustering and identify potential batch effects in the bulk RNA-seq dataset.

**`RNA_seq_differential_expression_analysis.R`**

Performs differential expression analysis comparing normal bone marrow and primary tumour bone marrow samples. Differentially expressed genes are used to generate gene sets for downstream analyses.
