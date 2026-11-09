# STAAR Rare Variant Association Analysis

## Overview

This directory contains the Jupyter notebooks used to perform rare variant association analyses using the **STAAR (variant-Set Test for Association using Annotation infoRmation)** framework in the All of Us (AoU) Research Program.

The workflow processes whole-genome sequencing (WGS) data, prepares genotype and variant annotation files, constructs the genetic relatedness matrix, and performs gene-centric rare variant association analyses using the STAAR framework.

The primary objective is to identify associations between rare coding variants and electronic health record (EHR)-derived acute myeloid leukemia (AML).

The analysis is conducted within the AoU Researcher Workbench environment.

## Workflow

The notebooks are organized into sequential stages, beginning with genotype data conversion and ending with gene-centric association testing.

### 1. Genotype Data Conversion

| Notebook | Description |
|---|---|
| [00_Conversion_To_BGEN.ipynb](00_Conversion_To_BGEN.ipynb) | Converts genotype data into BGEN format for downstream genetic analyses. |
| [01_Conversion_To_GDS.ipynb](01_Conversion_To_GDS.ipynb) | Converts genotype data into Genomic Data Structure (GDS) format for use with the STAAR framework. |

### 2. Variant Information and Annotation

| Notebook | Description |
|---|---|
| [02_Variant_Info.ipynb](02_Variant_Info.ipynb) | Extracts and prepares variant-level information from the genotype data. |
| [03_Annotate.ipynb](03_Annotate.ipynb) | Annotates genetic variants using functional and deleteriousness prediction information. |
| [04_Variant_Info_GDS.ipynb](04_Variant_Info_GDS.ipynb) | Prepares and organizes variant information corresponding to the GDS genotype data for downstream analyses. |

### 3. Genetic Relatedness and Analysis Preparation

| Notebook | Description |
|---|---|
| [05_Sparse_GRM.ipynb](05_Sparse_GRM.ipynb) | Constructs the sparse genetic relatedness matrix (GRM) required for mixed-model association testing. |
| [06_Preparation.ipynb](06_Preparation.ipynb) | Prepares phenotype, covariate, genotype, and annotation inputs required for STAAR analyses. |
| [07_Null_Model_SPA.ipynb](07_Null_Model_SPA.ipynb) | Fits the null logistic mixed model incorporating the saddlepoint approximation (SPA) to account for case-control imbalance and population structure. |

### 4. Rare Variant Association Analysis

| Notebook | Description |
|---|---|
| [08_STAAR_Gene_Centric_Coding_SPA.ipynb](08_STAAR_Gene_Centric_Coding_SPA.ipynb) | Performs gene-centric rare coding variant association analyses using STAAR with SPA-based null model adjustment. |

## Environment Configuration

The following notebooks contain environment configuration and setup procedures for running the analysis within the AoU Researcher Workbench.

| Notebook | Description |
|---|---|
| [Environment_DSUB.ipynb](Environment_DSUB.ipynb) | Configures the computational environment and dependencies for executing analyses using `dsub`. |
| [Setting_Env_Variables.ipynb](Setting_Env_Variables.ipynb) | Defines environment variables and workspace-specific configuration parameters required by the analysis pipeline. |

## Execution Order

The general execution order is:

1. `Environment_DSUB.ipynb`
2. `00_Conversion_To_BGEN.ipynb`
3. `01_Conversion_To_GDS.ipynb`
4. `02_Variant_Info.ipynb`
5. `03_Annotate.ipynb`
6. `04_Variant_Info_GDS.ipynb`
7. `05_Sparse_GRM.ipynb`
8. `06_Preparation.ipynb`
9. `07_Null_Model_SPA.ipynb`
10. `08_STAAR_Gene_Centric_Coding_SPA.ipynb`

## Analysis Framework

The STAAR workflow incorporates functional annotation information to improve the power of rare variant association testing. Gene-centric analyses evaluate the cumulative effects of rare coding variants within genes using annotation-weighted association tests.

The analysis uses a logistic mixed-model framework to account for population structure and genetic relatedness, with saddlepoint approximation to improve statistical inference under case-control imbalance.


All notebooks and associated analysis code are maintained in the following repository:

[**Rare Variant Analysis of EHR-Derived AML in the All of Us Research Program**](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU)

