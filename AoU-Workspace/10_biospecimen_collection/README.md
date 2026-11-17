# 10 – Age at Biospecimen Collection Analyses

## Overview

This directory contains sensitivity analyses investigating the association between rare genetic variants and age at biospecimen collection in the All of Us Research Program.

Age at biospecimen collection is treated as the outcome variable in these analyses. The objective is to investigate whether rare genetic variation, including variants in genes previously implicated in the AML association analyses, is associated with the age at which an individual's biospecimen was collected.

The analyses use SAIGE-GENE+ gene-based association testing, rare single-variant association testing, and leave-one-variant-out (LOVO) analyses to evaluate gene-level and variant-level associations with age at biospecimen collection.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
|---|---|
| `10_01_biospecimen_age_saige_gene_based_step04.ipynb` | Prepare the SAIGE-GENE+ gene-based association analysis using age at biospecimen collection as the outcome. Perform Step 4 to prepare the inputs required for the subsequent association analysis. |
| `10_02_biospecimen_age_saige_gene_based_step05.ipynb` | Perform SAIGE-GENE+ gene-based association testing (Step 5), modelling age at biospecimen collection as the outcome. |
| `10_03_biospecimen_age_qq_plot.ipynb` | Generate quantile-quantile (QQ) plots to assess the distribution of gene-based association test statistics and evaluate potential deviations from the expected null distribution. |
| `10_04_biospecimen_age_rare_single_variant_assoca.ipynb` | Investigate rare single-variant associations with age at biospecimen collection. |
| `10_05_biospecimen_age_lovo_step02.ipynb` | Perform SAIGE-GENE+ leave-one-variant-out (LOVO) analysis to investigate the contribution of individual variants to gene-based associations with age at biospecimen collection. |

## Analysis Components

### 1. Phenotype Generation

Age at biospecimen collection is generated as the outcome variable for the association analyses.

- Derive age at the time of biospecimen collection for each individual.
- Generate the phenotype file required for SAIGE-GENE+ association testing.
- Use the resulting phenotype in subsequent gene-based and single-variant association analyses.

### 2. SAIGE-GENE+ Gene-Based Association Analysis

Gene-based association testing is performed using SAIGE-GENE+ to investigate associations between rare genetic variation and age at biospecimen collection.

- Prepare the analysis inputs using Step 4.
- Perform gene-based association testing using Step 5.
- Evaluate the resulting gene-level association statistics.
- Generate QQ plots to assess the distribution of association test statistics.

### 3. Rare Single-Variant Association Analysis

Additional analyses investigate associations between individual rare genetic variants and age at biospecimen collection.

These analyses provide a complementary assessment of variant-level associations alongside the gene-based results.

### 4. Leave-One-Variant-Out (LOVO) Analysis

LOVO analyses are performed to investigate the contribution of individual variants to gene-based associations with age at biospecimen collection.

By evaluating gene-level associations after leaving out individual variants, these analyses help identify variants that may disproportionately contribute to an observed association signal.

### 5. Additional Gene-Based Association Analyses

The additional analyses in notebooks `10_07` through `10_09` provide further gene-based and LOVO association testing using the age at biospecimen collection phenotype.

## Execution

The phenotype file should first be generated using `10_06_age_biospecimen_file.ipynb`.

The SAIGE-GENE+ gene-based association analyses can then be performed using the Step 4 and Step 5 notebooks. The resulting association statistics are subsequently evaluated using QQ plots, rare single-variant association testing, and LOVO analyses.

**Important:** Some scripts included in this workspace were developed prior to the All of Us Research Program's transition to Verily. As a result, these scripts may require modifications to ensure compatibility with the current AoU Researcher Workbench environment.
