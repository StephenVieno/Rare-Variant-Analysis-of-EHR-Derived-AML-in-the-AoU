# 10 – Biospecimen Collection Timing Sensitivity Analyses

## Overview

This directory contains sensitivity analyses investigating the influence of biospecimen collection timing on the primary AML rare-variant gene-based association findings.

The analyses account for the timing of biospecimen collection relative to the first EHR-recorded AML diagnosis. This is particularly important when interpreting rare-variant associations involving genes susceptible to clonal hematopoiesis of indeterminate potential (CHIP), as variants detected in blood-derived biospecimens may reflect acquired clonal expansions rather than germline variation.

The analyses use alternative sample subsets and SAIGE-GENE+ gene-based and leave-one-variant-out (LOVO) association testing approaches to evaluate the robustness of the observed associations.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
|---|---|
| `10_01_biospecimen_age_saige_gene_based_step04.ipynb` | Prepare the SAIGE-GENE+ gene-based association analysis using the biospecimen collection timing subset. Perform Step 4 to prepare the variance ratio and null model inputs for the subsequent association analysis. |
| `10_02_biospecimen_age_saige_gene_based_step05.ipynb` | Perform SAIGE-GENE+ gene-based association testing (Step 5) using the biospecimen collection timing subset. |
| `10_03_biospecimen_age_qq_plot.ipynb` | Generate quantile-quantile (QQ) plots to assess the distribution of gene-based association test statistics and evaluate potential deviations from the expected null distribution. |
| `10_04_biospecimen_age_rare_single_variant_assoca.ipynb` | Investigate rare single-variant associations within the biospecimen collection timing subset. |
| `10_05_biospecimen_age_lovo_step02.ipynb` | Perform SAIGE-GENE+ leave-one-variant-out (LOVO) association testing (Step 2) for the biospecimen collection timing analysis. |
| `10_06_age_biospecimen_file.ipynb` | Generate the age and biospecimen collection timing file required for the corresponding sensitivity analyses. |
| `10_07_biospecimen_age_saige_gene_based_step04.ipynb` | Prepare an additional SAIGE-GENE+ gene-based association analysis using an alternative biospecimen collection timing specification or sample subset. |
| `10_08_biospecimen_age_saige_gene_based_step05.ipynb` | Perform SAIGE-GENE+ gene-based association testing (Step 5) using the alternative biospecimen collection timing specification or sample subset. |
| `10_09_biospecimen_age_lovo_step02.ipynb` | Perform an additional SAIGE-GENE+ leave-one-variant-out (LOVO) association analysis using the alternative biospecimen collection timing specification or sample subset. |

## Analysis Components

### 1. Biospecimen Collection Timing

The analyses investigate whether the timing of biospecimen collection relative to the first EHR-recorded AML diagnosis influences the observed rare-variant associations.

- Generate age and biospecimen collection timing information for the analysis cohort.
- Define the relevant sample subsets based on biospecimen collection timing.
- Evaluate the association findings under alternative sample selection specifications.

### 2. SAIGE-GENE+ Gene-Based Association Analysis

Gene-based association testing is performed using SAIGE-GENE+.

- Prepare the analysis inputs using Step 4.
- Perform gene-based association testing using Step 5.
- Evaluate the resulting gene-level association statistics.
- Generate QQ plots to assess the distribution of association test statistics.

### 3. Rare Single-Variant Association Analysis

Additional analyses investigate rare single-variant associations within the biospecimen collection timing subset.

These analyses provide a complementary assessment of individual variant associations alongside the gene-based results.

### 4. Leave-One-Variant-Out (LOVO) Analysis

LOVO analyses are performed to investigate the contribution of individual variants to gene-based association signals.

By evaluating gene-level associations after leaving out individual variants, these analyses help assess whether observed associations are driven by particular variants.

### 5. Alternative Biospecimen Timing Specifications

Additional SAIGE-GENE+ gene-based and LOVO analyses are performed using alternative biospecimen collection timing specifications or sample subsets.

These analyses provide an additional assessment of the robustness of the gene-based association findings to the definition of the biospecimen collection timing subset.

## Execution

The notebooks should generally be executed in numerical order, beginning with the generation of the age and biospecimen collection timing file in `10_06_age_biospecimen_file.ipynb`, followed by the corresponding SAIGE-GENE+ association analyses.

The gene-based association analyses should be completed before generating QQ plots and evaluating the rare single-variant and LOVO results.

The additional analyses in `10_07` through `10_09` provide an alternative assessment of the gene-based and LOVO association findings using a separate biospecimen collection timing specification or sample subset.

**Important:** Some scripts included in this workspace were developed prior to the All of Us Research Program's transition to Verily. As a result, these scripts may require modifications to ensure compatibility with the current AoU Researcher Workbench environment.
