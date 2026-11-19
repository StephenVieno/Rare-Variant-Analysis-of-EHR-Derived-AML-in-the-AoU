# 4 – Gene-Based Association Analysis

This directory contains Jupyter notebooks for performing rare variant gene-based association analyses using SAIGE-GENE+. The pipeline includes annotation threshold sensitivity analyses, variance ratio estimation, null model fitting, gene-based association testing, and visualization of association results. Additional analyses evaluate the effects of deprivation index adjustment and alternative cohort and age definitions.

## Notebooks

| **Notebook** | **Description** |
|---|---|
| `04_01_annotation_threshold_check.ipynb` | Performs SAIGE-GENE+ rare variant set-based association analyses using four variant annotation categories on chromosome 21 as part of an annotation threshold sensitivity analysis. The analysis evaluates LOFTEE loss-of-function classifications, SpliceAI splicing scores, AlphaMissense missense scores, and synonymous variants as a negative control. |
| `04_02_annotation_threshold_manhattan_plot.ipynb` | Generates Manhattan plots summarizing the annotation threshold sensitivity analyses to evaluate alternative thresholds for each variant annotation category. The selected thresholds include high-confidence LOFTEE variants, SpliceAI scores greater than 0.8, AlphaMissense scores greater than 0.546, and synonymous variants identified using VEP with SpliceAI scores below 0.5. |
| `04_03_aml_manhattan_maf_threshold_plot.ipynb` | Generates Manhattan plots stratified by minor allele frequency (MAF) thresholds to evaluate the impact of allele frequency thresholds on AML gene-based association results. |
| `04_04_aml_saige_gene_based_step04.ipynb` | Fits the null model for SAIGE-GENE+ set-based association analyses using the sparse genetic relationship matrix (GRM), randomly selected variants across specified minor allele count (MAC) categories, and the AML phenotype file with covariates. |
| `04_05_aml_saige_gene_based_step05.ipynb` | Performs chromosome-specific rare variant gene-based association tests using SAIGE-GENE+. The analysis evaluates maximum MAF thresholds of 1%, 0.1%, and 0.001% across missense, loss-of-function, and combined missense and loss-of-function annotation categories. Synonymous variants are analyzed separately as a negative control. |
| `04_06_aml_deprivation_index_saige_gene_based_step04.ipynb` | Fits the SAIGE-GENE+ null model using the phenotype file incorporating the deprivation index as an additional covariate. |
| `04_07_aml_deprivation_index_saige_gene_based_step05.ipynb` | Performs chromosome-specific SAIGE-GENE+ rare variant gene-based association tests using the phenotype file incorporating the deprivation index. The analysis evaluates the same annotation categories and MAF thresholds as the primary analysis. |
| `04_08_aml_qq_plot.ipynb` | Generates quantile–quantile (QQ) plots to evaluate the calibration of gene-based association test p-values and assess potential genomic inflation. |
| `04_09_genomic_inflation.ipynb` | Calculates genomic inflation statistics to assess the calibration of gene-based association results. |
| `04_10_aml_manhattan_plot.ipynb` | Generates standard Manhattan plots to visualize gene-based association signals across chromosomes. |
| `04_11_manhattan_cauchy_plot.ipynb` | Generates Manhattan plots using Cauchy-combined p-values to visualize aggregated association signals across multiple tests or annotation categories. |
| `04_12_aml_deprivation_index_saige_gene_based_step04.ipynb` | Fits the SAIGE-GENE+ null model for the deprivation index analysis using the corresponding phenotype file, sparse GRM, and randomly selected variants across specified MAC categories. |
| `04_13_aml_deprivation_index_saige_gene_based_step05.ipynb` | Performs chromosome-specific SAIGE-GENE+ rare variant gene-based association tests for the deprivation index analysis using the corresponding null model. |
| `04_14_aml_correlation_check_plot.ipynb` | Evaluates correlations between gene-based association summary statistics from analyses with and without adjustment for the deprivation index to assess the impact of covariate adjustment on association results. |
| `04_15_age_definition_saige_gene_based_step04.ipynb` | Fits the SAIGE-GENE+ null model using the alternative age definition incorporated into the AML phenotype file. |
| `04_16_age_definition_saige_gene_based_step05.ipynb` | Performs chromosome-specific SAIGE-GENE+ rare variant gene-based association tests using the alternative age definition and its corresponding null model. |
| `04_17_aml_top_gene_plot.ipynb` | Generates visualizations of the top genes identified in the AML gene-based association analyses. |
| `04_18_aml_top_gene_synonymous_plot.ipynb` | Generates visualizations of the top genes identified in the synonymous variant analyses, providing a comparison with the predicted deleterious variant results. |
| `04_19_combined_supplementary_plots.ipynb` | Generates combined supplementary visualizations summarizing the gene-based association analysis results. |
| `04_20_aml_restricted_cohort_saige_gene_based_step04.ipynb` | Fits the SAIGE-GENE+ null model using the restricted AML cohort phenotype definition. |
| `04_21_aml_restricted_cohort_saige_gene_based_step05.ipynb` | Performs chromosome-specific SAIGE-GENE+ rare variant gene-based association tests using the restricted AML cohort and its corresponding null model. |

## Notes

- The primary SAIGE-GENE+ analyses use a sparse GRM and categorical variance ratio estimation.
- Variance ratios are estimated using randomly selected variants across the specified MAC categories.
- The primary gene-based association analyses evaluate MAF thresholds of 1%, 0.1%, and 0.001% across missense, loss-of-function, and combined annotation categories.
- Synonymous variants are analyzed separately as a negative control.
- Additional analyses evaluate the effects of deprivation index adjustment, alternative age definitions, and restricted AML cohort selection.
- These notebooks were developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily. Some scripts may no longer be compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.
