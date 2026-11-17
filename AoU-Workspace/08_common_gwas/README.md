# 08 – Common Variant Association Analyses

## Overview

This directory contains the SAIGE-GENE+ single-variant association analysis pipeline used to investigate common variant associations with acute myeloid leukemia (AML) in the All of Us Research Program.

The analyses follow the SAIGE-GENE+ single-variant association workflow, consisting of genetic marker selection for variance ratio estimation, null model fitting using the sparse genetic relationship matrix (GRM), and single-variant association testing.

A secondary analysis incorporates socioeconomic deprivation as an additional covariate to investigate its influence on the observed genetic associations.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
|---|---|
| `08_01_saige_single_assoc_step01.ipynb` | Prepare a PLINK dataset containing 1,000 randomly selected genetic markers for variance ratio estimation. The microarray dataset used to construct the sparse GRM is first subset to include individuals from the single-variant analysis cohort. Variants not present in the PLINK dataset are removed before randomly selecting 1,000 markers. |
| `08_02_saige_single_assoc_step02.ipynb` | Fit the SAIGE-GENE+ null model using the sparse GRM and the 1,000 randomly selected genetic markers. Enable sparse GRM fitting and variance ratio estimation by setting `useSparseGRMtoFitNULL` and `useSparseGRMforVarRatio` to `TRUE`, and `skipVarianceRatioEstimation` to `FALSE`. |
| `08_03_saige_single_assoc_step03.ipynb` | Perform single-variant association testing using SAIGE-GENE+. Logistic Firth regression is used with the default Firth cutoff of 0.1, alongside imputation best-guess genotypes. Set `is_output_moreDetails = TRUE` to generate the full single-variant association results. |
| `08_04_saige_single_assoc_deprivation_step02.ipynb` | Fit the SAIGE-GENE+ null model for the single-variant association analysis incorporating socioeconomic deprivation as an additional covariate. |
| `08_05_saige_single_assoc_deprivation_step03.ipynb` | Perform single-variant association testing using the null model incorporating socioeconomic deprivation as an additional covariate. |

## Analysis Components

### 1. Genetic Marker Selection

A set of 1,000 randomly selected genetic markers is prepared for variance ratio estimation in SAIGE-GENE+.

- Start with the microarray dataset used to calculate the sparse GRM.
- Subset the dataset to include individuals from the single-variant analysis cohort.
- Remove variants not present in the corresponding PLINK dataset.
- Randomly select 1,000 markers from the remaining variants.

### 2. Null Model Fitting

The SAIGE-GENE+ null model is fitted using the sparse GRM and the selected genetic markers.

The following parameters are specified:

- `useSparseGRMtoFitNULL = TRUE`
- `useSparseGRMforVarRatio = TRUE`
- `skipVarianceRatioEstimation = FALSE`

These settings enable the sparse GRM for null model fitting and variance ratio estimation.

### 3. Single-Variant Association Testing

Single-variant association testing is performed using SAIGE-GENE+.

- Use logistic Firth regression with the default Firth cutoff of 0.1.
- Apply imputation best-guess genotypes for single-variant association testing.
- Set `is_output_moreDetails = TRUE` to generate the full association results.

### 4. Socioeconomic Deprivation Sensitivity Analysis

A secondary single-variant association analysis evaluates the influence of socioeconomic deprivation on the observed genetic associations.

- Incorporate the deprivation index as an additional covariate in the null model.
- Repeat single-variant association testing using the deprivation-adjusted null model.
- Compare the resulting association findings with those from the primary analysis.

## Execution

The primary analysis notebooks should be executed in numerical order, beginning with genetic marker selection in `08_01_saige_single_assoc_step01.ipynb`, followed by null model fitting and single-variant association testing.

The deprivation-adjusted analysis is performed separately using `08_04_saige_single_assoc_deprivation_step02.ipynb` and `08_05_saige_single_assoc_deprivation_step03.ipynb`.

**Important:** Some scripts included in this workspace were developed prior to the All of Us Research Program's transition to Verily. As a result, these scripts may require modifications to ensure compatibility with the current AoU Researcher Workbench environment.
