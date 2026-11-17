# 15 – STAAR Rare Variant Association Analyses

## Overview

This directory contains the Jupyter notebooks used to perform rare-variant association analyses using the **STAAR (variant-Set Test for Association using Annotation infoRmation)** framework in the All of Us (AoU) Research Program.

The workflow processes whole-genome sequencing (WGS) data, prepares genotype and variant annotation files, constructs the genetic relatedness matrix, and performs gene-centric rare-variant association analyses using the STAAR framework.

The primary objective is to identify associations between rare coding variants and electronic health record (EHR)-derived acute myeloid leukemia (AML).

The analysis is conducted within the AoU Researcher Workbench environment.

## Workflow

The notebooks are organized into sequential stages, beginning with genotype data conversion and ending with gene-centric association testing.

### 1. Genotype Data Conversion

Replace the separate **Workflow** and **Environment Configuration** tables with one consolidated table:

| Notebook                                    | Description                                                                                |
| ------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `Environment_DSUB.ipynb`                    | Configure the dsub environment and required dependencies for executing the analysis.       |
| `Setting_Env_Variables.ipynb`               | Define environment variables and workspace-specific configuration settings.                |
| `15_00_conversion_to_bgen.ipynb`            | Convert WGS genotype data into BGEN format.                                                |
| `15_01_conversion_to_gds.ipynb`             | Convert BGEN genotype data into GDS format for downstream STAAR analysis.                  |
| `15_02_variant_info.ipynb`                  | Extract and prepare variant-level information required for STAAR analysis.                 |
| `15_03_variant_info_gds.ipynb`              | Prepare variant information in the format required for integration with GDS genotype data. |
| `15_05_preparation.ipynb`                   | Prepare phenotype, covariate, genotype, and annotation inputs for STAAR analysis.          |
| `15_06_null_model_spa.ipynb`                | Fit the null logistic mixed model with saddlepoint approximation (SPA).                    |
| `15_07_staar_gene_centric_coding_spa.ipynb` | Perform gene-centric rare coding variant association testing using STAAR with SPA.         |

## Analysis Components

### 1. Genotype Data Processing

Whole-genome sequencing genotype data are converted into formats compatible with downstream STAAR analyses.

- Convert genotype data into BGEN format.
- Convert the resulting genotype data into GDS format.
- Prepare the corresponding variant-level information for downstream analyses.

### 2. Variant Information and Annotation

Variant-level information is extracted and organized to support gene-centric rare-variant association testing.

- Extract variant information from the genotype data.
- Prepare variant information corresponding to the GDS dataset.
- Organize genotype and annotation inputs for subsequent association analyses.

### 3. Null Model Fitting

The STAAR workflow uses a logistic mixed-model framework to account for population structure and genetic relatedness.

The null model incorporates the saddlepoint approximation (SPA) to improve statistical inference under case-control imbalance.

### 4. Gene-Centric Rare Variant Association Analysis

Gene-centric association analyses are performed using STAAR to investigate the cumulative effects of rare coding variants within genes.

- Evaluate rare coding variants using functional annotation information.
- Incorporate annotation-weighted association testing.
- Apply SPA-based null model adjustment.
- Identify genes associated with EHR-derived AML.

## Environment Configuration

The following notebooks contain environment configuration and setup procedures for running the analysis within the AoU Researcher Workbench.

| Notebook | Description |
|---|---|
| `Environment_DSUB.ipynb` | Configure the computational environment and dependencies for executing analyses using `dsub`. |
| `Setting_Env_Variables.ipynb` | Define environment variables and workspace-specific configuration parameters required by the analysis pipeline. |

## Execution

The general execution order is:

1. `Environment_DSUB.ipynb`
2. `Setting_Env_Variables.ipynb`
3. `15_00_conversion_to_bgen.ipynb`
4. `15_01_conversion_to_gds.ipynb`
5. `15_02_variant_info.ipynb`
6. `15_03_variant_info_gds.ipynb`
7. `15_05_preparation.ipynb`
8. `15_06_null_model_spa.ipynb`
9. `15_07_staar_gene_centric_coding_spa.ipynb`

## Analysis Framework

The STAAR workflow incorporates functional annotation information to improve the power of rare-variant association testing. Gene-centric analyses evaluate the cumulative effects of rare coding variants within genes using annotation-weighted association tests.

The analysis uses a logistic mixed-model framework to account for population structure and genetic relatedness, with saddlepoint approximation to improve statistical inference under case-control imbalance.

**Important:** Some scripts included in this workspace were developed prior to the All of Us Research Program's transition to Verily. As a result, these scripts may require modifications to ensure compatibility with the current AoU Researcher Workbench environment.
