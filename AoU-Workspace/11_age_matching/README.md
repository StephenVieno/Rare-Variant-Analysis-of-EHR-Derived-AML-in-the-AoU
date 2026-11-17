# 11 – Age-Matched Sensitivity Analyses

## Overview

This directory contains sensitivity analyses investigating the robustness of the primary AML rare-variant gene-based association findings following age matching between AML cases and controls.

Age matching is performed to account for potential confounding by age, particularly given the age-dependent prevalence of clonal hematopoiesis of indeterminate potential (CHIP) and its potential influence on rare-variant association findings.

The analyses use SAIGE-GENE+ gene-based and rare single-variant association testing to evaluate genetic associations within the age-matched cohort. Additional analyses investigate gene-based associations using age at phenotype ascertainment as an outcome.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
|---|---|
| `11_01_matching.ipynb` | Perform age matching between AML cases and controls to generate an age-matched analysis cohort. |
| `11_02_matched_saige_gene_based_step02.ipynb` | Prepare the SAIGE-GENE+ analysis by fitting the null model using the age-matched cohort. |
| `11_03_matched_saige_gene_based_step03.ipynb` | Perform the corresponding SAIGE-GENE+ variance ratio estimation and prepare the inputs required for gene-based association testing. |
| `11_04_matched_saige_gene_based_step04.ipynb` | Complete the SAIGE-GENE+ Step 4 procedure for the age-matched cohort, preparing the inputs for association testing. |
| `11_05_matched_saige_gene_based_step05.ipynb` | Perform SAIGE-GENE+ gene-based association testing (Step 5) using the age-matched cohort. |
| `11_06_matched_rare_single_variant_assoc.ipynb` | Investigate rare single-variant associations within the age-matched cohort. |
| `11_07_matched_phenotype_age_saige_gene_based_step04.ipynb` | Fit the null model for the SAIGE-GENE+ gene-based association analysis, modelling age at phenotype ascertainment as the outcome in the matched cohort. |
| `11_08_matched_phenotype_age_saige_gene_based_step05.ipynb` | Perform SAIGE-GENE+ gene-based association testing (Step 5), modelling age at phenotype ascertainment as the outcome in the matched cohort. |
| `11_09_matching_plots.ipynb` | Generate plots to evaluate the age-matching procedure and assess the age distributions of AML cases and matched controls. |

## Analysis Components

### 1. Age Matching

Age matching is performed to improve comparability between AML cases and controls.

- Generate an age-matched cohort of AML cases and controls.
- Evaluate the age distributions of the matched groups.
- Generate visualizations to assess the matching procedure.

### 2. SAIGE-GENE+ Gene-Based Association Analysis

Gene-based association testing is performed using SAIGE-GENE+ in the age-matched cohort.

- Fit the null model.
- Perform variance ratio estimation.
- Complete the required association testing preparation steps.
- Perform gene-based association testing using Step 5.
- Evaluate the resulting gene-level association statistics.

### 3. Rare Single-Variant Association Analysis

Additional analyses investigate associations between individual rare genetic variants and AML status within the age-matched cohort.

These analyses provide a complementary assessment of variant-level associations alongside the gene-based results.

### 4. Age at Phenotype Ascertainment Analysis

A separate analysis investigates associations between rare genetic variation and age at phenotype ascertainment within the matched cohort.

- Model age at phenotype ascertainment as the outcome.
- Fit the SAIGE-GENE+ null model using Step 4.
- Perform gene-based association testing using Step 5.
- Evaluate the resulting gene-level association statistics.

## Execution

The age-matching procedure should first be performed using `11_01_matching.ipynb`, followed by the SAIGE-GENE+ analysis notebooks using the resulting matched cohort.

The primary gene-based association analysis is performed using `11_02` through `11_05`, followed by rare single-variant association testing in `11_06`.

The separate age-at-phenotype-ascertainment analysis is performed using `11_07` and `11_08`. Matching diagnostics and visualizations can be generated using `11_09_matching_plots.ipynb`.
