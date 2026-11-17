# 09 – Covariate Sensitivity Analyses

## Overview

This directory contains sensitivity analyses investigating the robustness of the primary AML gene-based association findings to covariate adjustment and alternative statistical modelling approaches.

The analyses focus on the top three significant genes identified through the SAIGE-GENE+ set-based association analyses. Rare-variant polygenic risk scores (PRS) are generated for these genes and subsequently evaluated using logistic regression and Cox proportional hazards regression.

Additional analyses investigate the influence of smoking status, prior exposure to alkylating agents, and socioeconomic deprivation on the observed gene-level associations.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
|---|---|
| `09_01_aml_exome_burden_analysis_top_genes_prs.ipynb` | Generate rare-variant polygenic risk scores for the top three significant genes identified through SAIGE-GENE+ set-based association analyses. Predicted deleterious rare variants (missense and loss-of-function; MAF less than 1%) are assigned a weight of 1, with gene-level scores calculated as the sum of qualifying variants carried by each individual. |
| `09_02_aml_top_genes_sensitivity_analysis.ipynb` | Perform logistic regression and Cox regression analyses using the gene-level rare-variant PRS. Evaluate associations under alternative covariate specifications, including age, sex, ten principal components, exome burden, EHR index date, and observation period. |
| `09_03_aml_top_genes_with_covariates_sensitivity_analysis.ipynb` | Repeat logistic and Cox regression analyses incorporating additional covariates, specifically smoking status and prior exposure to alkylating agents before the first EHR diagnosis of AML. |
| `09_04_aml_top_genes_with_deprivation_index_sensitivity_analysis.ipynb` | Perform additional logistic and Cox regression sensitivity analyses incorporating the overall socioeconomic deprivation index or its individual components as covariates. |
| `09_05_aml_top_gene_based_results.ipynb` | Consolidate and evaluate the top gene-based association results across the sensitivity analyses. |

## Analysis Components

### 1. Rare-Variant PRS Generation

Gene-level rare-variant PRS are generated for the top three significant genes identified through SAIGE-GENE+ set-based association testing.

- Include predicted deleterious missense and loss-of-function variants.
- Apply a minor allele frequency (MAF) threshold of less than 1%.
- Assign a weight of 1 to each qualifying variant.
- Calculate individual gene-level scores by summing the qualifying variants carried by each individual.

### 2. Logistic Regression

Logistic regression models are used to investigate associations between gene-level rare-variant PRS and AML status.

The covariates include:

- Age
- Sex
- Ten genetic principal components
- Exome burden
- EHR index date or observation period

Additional models incorporate smoking status, prior alkylating agent exposure, and socioeconomic deprivation measures.

### 3. Cox Proportional Hazards Regression

Cox regression models are used to investigate the relationship between gene-level rare-variant PRS and time-to-event outcomes.

Two alternative time-to-event definitions are considered:

- Time from birth.
- Time from the first EHR record.

Covariates include sex, ten genetic principal components, exome burden, and year of birth or year of the first EHR record. The EHR index date and additional covariates are incorporated where specified.

### 4. Additional Covariate Sensitivity Analyses

Additional analyses assess the influence of potential environmental and socioeconomic confounders:

- **Smoking status:** Evaluate the influence of smoking history on gene-level associations.
- **Alkylating agent exposure:** Account for prior exposure to alkylating agents before the first EHR diagnosis of AML.
- **Socioeconomic deprivation:** Incorporate the overall deprivation index or its individual components into the regression models.

## Execution

The notebooks should generally be executed in numerical order, beginning with the generation of gene-level rare-variant PRS in `09_01_aml_exome_burden_analysis_top_genes_prs.ipynb`.

The resulting PRS files are subsequently used as inputs for the logistic and Cox regression sensitivity analyses.

The final notebook, `09_05_aml_top_gene_based_results.ipynb`, consolidates the results generated across the different analytical approaches.

**Some scripts included in this workspace were developed prior to the All of Us Research Program's transition to Verily.
As a result, these scripts may require modifications to ensure compatibility with the current AoU Researcher Workbench environment.**


