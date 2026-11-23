# 06 – Leave-One-Variant-Out (LOVO) Analysis

## Overview

This directory contains the variant cross-referencing and leave-one-variant-out (LOVO) analysis pipelines used to investigate rare variant associations with acute myeloid leukemia (AML) in the All of Us Research Program.

The variant cross-referencing workflow compares variants identified in SAIGE-GENE+ marker lists with somatic mutations reported in the Genomic Data Commons (GDC) and germline variants reported in ClinVar. Analyses are conducted separately for ultra-rare variants (minor allele count [MAC] ≤ 10) and rare variants (minor allele frequency [MAF] < 1% and MAC > 10).

The LOVO workflow uses SAIGE-GENE+ to evaluate the contribution of individual variants to gene-based association signals. This is achieved by iteratively removing one variant at a time from the original variant set and repeating the association testing procedure.

Additional analyses incorporate socioeconomic deprivation as a covariate and use a separate University of Virginia (UVA) analysis dataset to investigate the robustness of the observed associations.

## Workflow

The notebooks are organized according to the following analytical steps:

| Notebook | Description |
| --- | --- |
| `06_01_aml_marker_list.ipynb` | Cross-reference variants from the primary AML SAIGE-GENE+ marker list with somatic mutations from GDC and germline variants from ClinVar. AoU variant identifiers are converted to HGVS identifiers to facilitate matching with external databases. GDC somatic mutation records are annotated to indicate whether each variant is present, while ClinVar records are filtered to retain variants included in the marker list. |
| `06_02_aml_lovo_step01.ipynb` | Generate chromosome-specific PLINK BED files from the exome dataset by selecting variants that pass QC within the genes of interest. The notebook must be submitted separately for each chromosome containing a gene of interest. |
| `06_03_aml_lovo_step02.ipynb` | Perform SAIGE-GENE+ Step 2 association testing for each leave-one-variant-out annotation set. Each annotation set contains the original collection of variants with one individual variant removed, allowing its contribution to the gene-based association signal to be evaluated. |
| `06_04_aml_lovo_plot.ipynb` | Process and visualize the primary AML LOVO association results to evaluate the influence of individual variants on the gene-based association statistics. |
| `06_05_aml_deprivation_index_marker_list.ipynb` | Cross-reference variants from the AML SAIGE-GENE+ marker list incorporating the Area Deprivation Index with somatic mutations from GDC and germline variants from ClinVar. |
| `06_06_aml_deprivation_index_lovo_step02.ipynb` | Perform SAIGE-GENE+ Step 2 association testing for each leave-one-variant-out annotation set from the AML analysis incorporating the Area Deprivation Index. |
| `06_07_aml_deprivation_index_lovo_plot.ipynb` | Process and visualize the deprivation-index-adjusted LOVO association results to evaluate the contribution of individual variants to the corresponding gene-based association signals. |
| `06_08_aml_uva_lovo_step01.ipynb` | Generate chromosome-specific PLINK BED files from the UVA exome dataset by selecting variants that pass QC within the genes of interest. The notebook must be submitted separately for each chromosome containing a gene of interest. |
| `06_09_aml_uva_lovo_step02.ipynb` | Perform SAIGE-GENE+ Step 2 association testing for each leave-one-variant-out annotation set using the UVA analysis dataset. |
| `06_10_aml_marker_list_plot.ipynb` | Process and visualize the primary AML marker-list LOVO results. |

## Analysis Components

### 1. Variant Cross-Referencing

SAIGE-GENE+ marker lists are cross-referenced with external somatic and germline variant databases to characterize the variants identified in the AML association analyses.

- Separate variants into ultra-rare (MAC ≤ 10) and rare (MAF < 1% and MAC > 10) categories.
- Convert AoU variant identifiers into HGVS identifiers to facilitate cross-referencing.
- Annotate GDC somatic mutation records to indicate the presence or absence of each variant.
- Filter ClinVar records to retain variants included in the corresponding SAIGE-GENE+ marker lists.
- Generate consolidated variant lists incorporating the external database annotations.

### 2. Leave-One-Variant-Out Analysis

The LOVO analysis evaluates the contribution of individual variants to gene-based association signals identified by SAIGE-GENE+.

The workflow consists of two main steps:

**Step 1 – Variant Subsetting**

- Identify variants within the genes of interest that pass exome QC.
- Subset the exome dataset to retain the selected variants.
- Generate chromosome-specific PLINK BED files for subsequent association testing.
- Submit the notebook separately for each chromosome containing a gene of interest.

**Step 2 – Association Testing**

- Generate or use annotation files representing variant sets with one individual variant removed.
- Iterate over the annotation files, performing SAIGE-GENE+ Step 2 association testing for each reduced variant set.
- Compare the resulting association statistics with those obtained using the complete variant set.
- Identify variants whose removal substantially changes the gene-based association statistics.

### 3. Socioeconomic Deprivation Sensitivity Analysis

A secondary LOVO analysis investigates the influence of socioeconomic deprivation on the observed gene-based association signals.

- Use the SAIGE-GENE+ marker list generated from the AML analysis incorporating the Area Deprivation Index.
- Cross-reference the corresponding variants with GDC and ClinVar.
- Perform LOVO association testing using the deprivation-adjusted annotation sets.
- Compare the resulting association statistics with those from the primary AML analysis.
- Evaluate whether individual variants contribute differently to the association signals after adjustment for socioeconomic deprivation.

### 4. University of Virginia (UVA) LOVO Analysis

An additional LOVO analysis is performed using the UVA analysis dataset to investigate the contribution of individual variants to the gene-based association signals.

- Identify variants passing exome QC within the genes of interest.
- Generate chromosome-specific PLINK BED files using the UVA exome dataset.
- Perform SAIGE-GENE+ Step 2 association testing across the leave-one-variant-out annotation sets.
- Evaluate the contribution of individual variants to the resulting gene-based association statistics.

### 5. Results Visualization

The LOVO association results are processed and visualized to facilitate comparisons between the complete variant sets and the corresponding leave-one-variant-out analyses.

- Visualize changes in gene-based association statistics following the removal of individual variants.
- Identify variants whose removal substantially attenuates the observed association signals.
- Compare the primary AML and deprivation-index-adjusted LOVO results.

## Execution

The primary AML LOVO analysis should be executed in numerical order, beginning with variant subsetting in `06_02_aml_lovo_step01.ipynb`, followed by association testing in `06_03_aml_lovo_step02.ipynb` and visualization in `06_04_aml_lovo_plot.ipynb`.

The variant cross-referencing analysis can be performed separately using `06_01_aml_marker_list.ipynb`.

The deprivation-index-adjusted analysis uses `06_05_aml_deprivation_index_marker_list.ipynb` for variant cross-referencing, followed by `06_06_aml_deprivation_index_lovo_step02.ipynb` for association testing and `06_07_aml_deprivation_index_lovo_plot.ipynb` for visualization.

The UVA LOVO analysis is performed separately using `06_08_aml_uva_lovo_step01.ipynb` and `06_09_aml_uva_lovo_step02.ipynb`.

The additional marker-list visualization notebooks, `06_10_aml_marker_list_plot.ipynb` and `06_11_aml_deprivation_index_marker_list_plot.ipynb`, can be executed to generate the corresponding visualizations.

**Important:** Step 1 of the LOVO workflow must be submitted separately for each chromosome containing a gene of interest. The resulting chromosome-specific PLINK BED files must be available before proceeding with the corresponding association testing. Each leave-one-variant-out annotation set should contain the original variant collection with exactly one individual variant removed.
