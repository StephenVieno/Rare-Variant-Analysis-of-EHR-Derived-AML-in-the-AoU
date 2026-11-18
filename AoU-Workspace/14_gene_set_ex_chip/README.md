# 14 – Gene-Set Burden Analyses Excluding CHIP-Associated Genes

## Overview

This directory contains exome-wide gene-set rare-variant burden analyses of acute myeloid leukemia (AML), incorporating polygenic risk scores (PRS) and excluding CHIP-associated genes.

The objective is to evaluate the contribution of rare exonic variation across predefined gene sets to AML susceptibility while assessing the potential influence of clonal hematopoiesis of indeterminate potential (CHIP) on observed associations. The analyses use the All of Us (AoU) exome dataset and incorporate PRS and CHIP-associated gene exclusion to evaluate the robustness of gene-set burden findings.

## Workflow

The notebooks are organized according to the following analytical steps:

| **Notebook** | **Description** |
| ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `14_01_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Conduct initial AML exome-wide gene-set burden analyses incorporating polygenic risk scores and excluding CHIP-associated genes. |
| `14_02_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Perform subsequent exome-wide gene-set burden analyses incorporating PRS and CHIP-associated gene exclusion. |
| `14_03_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Conduct additional gene-set burden analyses and evaluate the resulting AML gene-set associations. |
| `14_04_aml_exome_burden_analysis_prs_somatic_ex_chip.ipynb` | Perform further gene-set burden analyses and sensitivity assessments incorporating PRS and CHIP-associated gene exclusion. |

## Analysis Components

The analyses within this directory include:

- **Exome-wide gene-set burden analysis:** Evaluate the cumulative burden of rare exonic variants across predefined gene sets associated with AML and relevant biological processes.
- **Polygenic risk score adjustment:** Incorporate PRS into the analytical framework to account for common-variant genetic susceptibility when evaluating rare-variant gene-set burden.
- **CHIP-associated gene exclusion:** Exclude genes associated with clonal hematopoiesis to assess whether gene-set burden associations are driven by genes potentially affected by somatic clonal expansion.
- **Gene-set association assessment:** Evaluate the contribution of rare exonic variation across predefined gene sets to AML susceptibility.

## Environment Configuration

The following notebook supports execution within the All of Us Researcher Workbench:

- `Setting_Env_Variables.ipynb`: Definition of environment variables required by the analysis scripts.

## Execution

The notebooks should generally be executed in numerical order (14_01–14_04), following the required environment configuration in `Setting_Env_Variables.ipynb`.

The resulting outputs support the evaluation of AML gene-set burden associations while accounting for polygenic susceptibility and potential confounding from CHIP-associated genes.
