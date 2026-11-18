# 14 – Exome-Wide Gene-Set Burden Analyses Excluding CHIP-Associated Genes

## Overview

This directory contains exome-wide gene-set rare-variant burden analyses of acute myeloid leukemia (AML), incorporating rare-variant polygenic risk scores (PRS) and accounting for clonal hematopoiesis of indeterminate potential (CHIP).

The objective is to evaluate the contribution of rare exonic variation across predefined gene sets to AML susceptibility while assessing the potential influence of CHIP-associated genes on observed associations. The analyses include modification of the somatic gene set, logistic regression analyses following CHIP-associated gene exclusion, and sensitivity analyses stratified by participant relatedness.

## Workflow

The notebooks are organized according to the following analytical steps:

| **Notebook** | **Description** |
| ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `14_01_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Remove CHIP-associated genes from the somatic gene set to generate a modified gene set for subsequent burden analyses. |
| `14_02_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Perform logistic regression analyses of AML gene-set burden after removing CHIP-associated genes from the somatic gene set. |
| `14_03_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Repeat gene-set burden logistic regression analyses in unrelated individuals across all gene sets. |
| `14_04_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Repeat gene-set burden logistic regression analyses in related individuals across all gene sets. |

## Analysis Components

The analyses within this directory include:

- **CHIP-associated gene exclusion:** Remove CHIP-associated genes from the somatic gene set to assess the contribution of somatic gene burden independently of genes implicated in clonal hematopoiesis.
- **Logistic regression:** Evaluate associations between AML status and rare-variant gene-set burden following CHIP-associated gene exclusion.
- **Unrelated-individual sensitivity analysis:** Repeat gene-set burden analyses across all gene sets in the subset of unrelated participants.
- **Related-individual sensitivity analysis:** Conduct corresponding gene-set burden analyses in related participants to evaluate the impact of sample relatedness on observed associations.

## Environment Configuration

The following notebook supports execution within the All of Us Researcher Workbench:

- `Setting_Env_Variables.ipynb`: Definition of environment variables required by the analysis scripts.

## Execution

The notebooks should generally be executed in numerical order (14_01–14_04), following the required environment configuration in `Setting_Env_Variables.ipynb`.

The resulting outputs support the evaluation of AML gene-set burden associations following CHIP-associated gene exclusion, including sensitivity analyses assessing the impact of participant relatedness on the observed associations.
