# 13 – Gene-Based Association Analyses Excluding CHIP-Associated Variants

## Overview

This directory contains gene-based rare-variant association analyses repeated after excluding variants associated with clonal hematopoiesis of indeterminate potential (CHIP).

The objective is to investigate the robustness of the primary AML gene-based association findings following CHIP-related variant exclusion. The analyses use SAIGE-GENE and incorporate additional covariate adjustments and sample-subset sensitivity analyses.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
|---|---|
| `13_01_aml_additional_covariates_file.ipynb` | Generate additional covariate files for inclusion in the gene-based association models. |
| `13_02_aml_check_covariates_saige_gene_based_step04.ipynb` | Evaluate covariates and prepare model specifications for SAIGE-GENE Step 4. |
| `13_03_aml_ab0.35_dp20_saige_gene_based_step05.ipynb` | Conduct gene-based association analyses using SAIGE-GENE Step 5, applying allele balance (AB) and read depth (DP) filtering thresholds of 0.35 and 20, respectively. |
| `13_04_aml_ab0.35_dp20_additional_covariates_saige_gene_based_step05.ipynb` | Repeat gene-based association analyses incorporating additional covariates, using the AB 0.35 and DP 20 filtered dataset. |
| `13_05_aml_check_covariates_sample_subset_saige_gene_based_step04ipynb.ipynb` | Evaluate covariates and prepare SAIGE-GENE Step 4 model specifications for the sample-subset analysis. |
| `13_06_aml_ab0.35_dp20_sample_subset_saige_gene_based_step05.ipynb` | Conduct gene-based association analyses in the sample subset using the AB 0.35 and DP 20 filtered dataset. |
| `13_07_aml_ab0.35_dp20_sample_subset_ex_hotspots_saige_gene_based_step05.ipynb` | Repeat sample-subset gene-based association analyses after excluding established CHIP-associated hotspot variants. |
| `13_08_aml_ab0.35_dp20_ex_hotspots_saige_gene_based_step05.ipynb` | Conduct gene-based association analyses after excluding CHIP-associated hotspot variants using the full analysis sample. |

## Analysis Components

The analyses within this directory include:

- **Additional covariate adjustment:** Evaluate the impact of incorporating additional covariates into the gene-based association models.
- **Allele balance and read depth filtering:** Apply genotype-level quality-control criteria using an allele balance threshold of 0.35 and minimum read depth of 20.
- **Sample-subset analyses:** Repeat association testing in a restricted sample subset to investigate the robustness of association findings.
- **CHIP hotspot exclusion:** Assess the contribution of established CHIP-associated hotspot variants to gene-level association signals.

## Environment Configuration

The following notebooks support execution within the All of Us Researcher Workbench:

- `Environment_DSUB.ipynb`: Configuration and execution of computational workflows using the AoU `dsub` infrastructure.
- `Setting_Env_Variables.ipynb`: Definition of environment variables required by the analysis scripts.

## Execution

The notebooks should generally be executed in numerical order, with SAIGE-GENE Step 4 preparation preceding the corresponding Step 5 association analyses.

The outputs generated within this directory support sensitivity analyses of the primary AML gene-based association findings following CHIP-associated variant exclusion.

