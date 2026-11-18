# 13 – Gene-Based Tests Excluding CHIP-Associated Variants

## Overview

This directory contains gene-based rare-variant association analyses repeated after excluding variants associated with clonal hematopoiesis of indeterminate potential (CHIP).

The objective is to assess the robustness of the primary acute myeloid leukemia (AML) gene-based association findings following CHIP-associated variant exclusion. The analyses use SAIGE-GENE and incorporate genotype-level quality-control filters, CHIP hotspot exclusion, and sample-subset sensitivity analyses.

## Workflow

The notebooks are organized according to the following analytical steps:

| **Notebook** | **Description** |
|---|---|
| `13_01_aml_ab0.35_dp20_saige_gene_based_step05.ipynb` | Conduct gene-based association analyses using SAIGE-GENE Step 5 after applying allele balance (AB) and read depth (DP) filters of 0.35 and 20, respectively. |
| `13_02_aml_ab0.35_dp20_ex_hotspots_saige_gene_based_step05.ipynb` | Repeat gene-based association analyses after excluding established CHIP-associated hotspot variants from the AB 0.35 and DP 20 filtered dataset. |
| `13_03_aml_ab0.35_dp20_sample_subset_saige_gene_based_step04ipynb.ipynb` | Prepare SAIGE-GENE Step 4 model specifications for the restricted sample-subset analysis. |
| `13_04_aml_ab0.35_dp20_sample_subset_saige_gene_based_step05.ipynb` | Conduct SAIGE-GENE Step 5 association analyses in the restricted sample subset using the AB 0.35 and DP 20 filtered dataset. |
| `13_05_aml_ab0.35_dp20_sample_subset_ex_hotspots_saige_gene_based_step05.ipynb` | Repeat sample-subset gene-based association analyses after excluding established CHIP-associated hotspot variants. |

## Analysis Components

The analyses within this directory include:

- **CHIP hotspot exclusion:** Repeat gene-based association testing after removing established CHIP-associated hotspot variants to evaluate their contribution to gene-level association signals.
- **Sample-subset sensitivity analyses:** Repeat association testing in a restricted sample subset to assess the robustness of the primary findings.
- **SAIGE-GENE association testing:** Perform gene-based rare-variant association analyses using SAIGE-GENE Step 4 and Step 5.

## Environment Configuration

The following notebooks support execution within the All of Us Researcher Workbench:

- `Environment_DSUB.ipynb`: Configuration and execution of computational workflows using the All of Us `dsub` infrastructure.
- `Setting_Env_Variables.ipynb`: Definition of environment variables required by the analysis scripts.

## Execution

The notebooks should generally be executed in numerical order. SAIGE-GENE Step 4 preparation should precede the corresponding Step 5 association analyses.

The resulting outputs support sensitivity analyses of the primary AML gene-based association findings, particularly the assessment of whether identified associations persist after applying genotype-level quality-control filters and excluding CHIP-associated hotspot variants.

