# 07 – Rare Variant Polygenic Risk Score Analysis

## Overview

This directory contains the rare variant polygenic risk score (PRS) analysis pipeline used to investigate the contribution of rare genetic variation to acute myeloid leukemia (AML) in the All of Us Research Program.

The analyses calculate rare variant burden scores at both the gene level and the exome level using SAIGE-GENE+ association results. Gene-level scores are subsequently aggregated into gene-set PRS based on biological and functional gene sets derived from bulk RNA-seq differential gene expression, Cox regression, single-cell RNA-seq differential gene expression, and somatic mutation analyses from the Genomic Data Commons (GDC).

The resulting gene-set and exome-level PRS are incorporated into logistic regression models to investigate associations with AML status. Additional analyses restrict the cohort to unrelated individuals to assess the robustness of the observed associations.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
| --- | --- |
| `07_01_aml_exome_burden_analysis.ipynb` | Calculate rare variant polygenic risk scores at both the gene level and chromosome-specific exome level using the corresponding rare variant association results. |
| `07_02_aml_exome_burden_prs_exome.ipynb` | Aggregate chromosome-specific exome burden score files to calculate an overall exome-level PRS. The resulting score incorporates rare coding and non-coding variation across the exome. |
| `07_03_aml_exome_burden_prs_bulk_dge.ipynb` | Calculate gene-set PRS using gene sets derived from bulk RNA-seq differential gene expression analysis. Gene-level PRS files are retrieved from the workspace bucket and aggregated across the genes belonging to each gene set. |
| `07_04_aml_exome_burden_prs_cox_regression.ipynb` | Calculate gene-set PRS using gene sets derived from bulk RNA-seq Cox regression analysis. Gene-level PRS files are retrieved from the workspace bucket and aggregated across the genes belonging to each gene set. |
| `07_05_aml_exome_burden_prs_single_cell_dge.ipynb` | Calculate gene-set PRS using gene sets derived from single-cell RNA-seq differential gene expression analysis. Gene-level PRS files are retrieved from the workspace bucket and aggregated across the genes belonging to each gene set. |
| `07_06_aml_exome_burden_prs_somatic.ipynb` | Calculate gene-set PRS using gene sets derived from GDC somatic mutation data. Gene-level PRS files are retrieved from the workspace bucket and aggregated across the genes belonging to each gene set. |
| `07_07_aml_exome_burden_logistic_regression.ipynb` | Perform logistic regression using gene-set PRS, exome-level PRS, principal components, age, and sex to investigate associations between rare variant burden and AML status. |
| `07_08_aml_exome_burden_logistic_regression_unrelated.ipynb` | Repeat the logistic regression analysis using unrelated individuals to evaluate the robustness of the gene-set associations while accounting for relatedness within the cohort. |
| `07_09_aml_exome_burden_logistic_regression_results.ipynb` | Format and consolidate the logistic regression results from the exome-based rare variant PRS analyses for downstream interpretation and reporting. |

## Analysis Components

### 1. Gene-Level and Exome-Level Rare Variant PRS Calculation

Rare variant burden scores are calculated using the SAIGE-GENE+ association results.

- Calculate rare variant PRS at the gene level.
- Calculate chromosome-specific exome burden scores.
- Aggregate chromosome-level scores to generate an overall exome-level PRS.
- Incorporate both rare coding and non-coding variation into the exome-level burden score.

### 2. Gene-Set PRS Calculation

Gene-level PRS files are aggregated according to predefined gene sets representing different biological and functional categories.

The following gene-set categories are investigated:

**Bulk RNA-seq Differential Gene Expression**

- Use gene sets derived from bulk RNA-seq differential gene expression analysis.
- Retrieve the corresponding gene-level PRS files from the workspace bucket.
- Iterate through the genes belonging to each gene set.
- Sum the individual gene-level PRS values to generate a gene-set PRS.

**Bulk RNA-seq Cox Regression**

- Use gene sets derived from bulk RNA-seq Cox regression analysis.
- Retrieve the corresponding gene-level PRS files from the workspace bucket.
- Aggregate the gene-level PRS values across each gene set to generate a gene-set PRS.

**Single-Cell RNA-seq Differential Gene Expression**

- Use gene sets derived from single-cell RNA-seq differential gene expression analysis.
- Retrieve the corresponding gene-level PRS files from the workspace bucket.
- Aggregate the gene-level PRS values across each gene set to generate a gene-set PRS.

**GDC Somatic Mutation Gene Sets**

- Use gene sets derived from somatic mutations reported in the GDC.
- Retrieve the corresponding gene-level PRS files from the workspace bucket.
- Aggregate the gene-level PRS values across each gene set to generate a gene-set PRS.

### 3. Logistic Regression Analysis

Logistic regression models are used to investigate associations between rare variant PRS and AML status.

The models incorporate the following variables:

- Gene-set rare variant PRS.
- Overall exome-level rare variant PRS.
- Genetic principal components to account for population structure.
- Age.
- Sex.

The analyses evaluate whether rare variant burden across specific gene sets is associated with AML status after adjustment for the specified covariates.

### 4. Unrelated-Individuals Sensitivity Analysis

A secondary logistic regression analysis is performed using unrelated individuals to assess the robustness of the observed associations.

- Restrict the analysis cohort to unrelated individuals.
- Repeat the logistic regression models using gene-set PRS and exome-level PRS.
- Include principal components, age, and sex as covariates.
- Compare the resulting associations with those from the primary analysis to evaluate the influence of relatedness on the observed findings.

### 5. Results Processing

The final notebook consolidates and formats the logistic regression results generated by the PRS analyses.

- Process the gene-set and exome-level logistic regression results.
- Organize the association statistics for downstream interpretation.
- Prepare the results for reporting and visualization.

## Execution

The rare variant PRS calculation should begin with `07_01_aml_exome_burden_analysis.ipynb`, which generates the gene-level and chromosome-specific exome burden scores.

The exome-level PRS is subsequently calculated using `07_02_aml_exome_burden_prs_exome.ipynb`.

Gene-set PRS are calculated separately according to their respective gene-set definitions using `07_03_aml_exome_burden_prs_bulk_dge.ipynb`, `07_04_aml_exome_burden_prs_cox_regression.ipynb`, `07_05_aml_exome_burden_prs_single_cell_dge.ipynb`, and `07_06_aml_exome_burden_prs_somatic.ipynb`.

Following PRS calculation, the primary logistic regression analysis is performed using `07_07_aml_exome_burden_logistic_regression.ipynb`. The unrelated-individuals sensitivity analysis is conducted separately using `07_08_aml_exome_burden_logistic_regression_unrelated.ipynb`.

Finally, `07_09_aml_exome_burden_logistic_regression_results.ipynb` processes and formats the association results for downstream interpretation and reporting.

**Important:** The gene-set PRS calculations require the corresponding gene-level PRS files to be available in the workspace bucket. Ensure that the gene-level and exome-level PRS calculations have been completed successfully before proceeding with the logistic regression analyses.
