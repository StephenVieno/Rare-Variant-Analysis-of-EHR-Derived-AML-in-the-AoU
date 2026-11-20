# Summary Statistics Post-Processing and MAGMA Analysis

This directory contains scripts for preprocessing SAIGE-GENE+ single-variant association summary statistics, assigning variant rsIDs, generating association plots, evaluating correlations between analyses with and without the deprivation index, and performing downstream gene and gene-set association analyses using MAGMA.

## Scripts

| Script | Description |
|---|---|
| `merge_plink.py` | Combines chromosome-specific summary statistics files (excluding the deprivation index) generated before rsID assignment into a single, genome-wide file. |
| `merge_deprivation_index_plink.py` | Combines chromosome-specific summary statistics files (including the deprivation index) generated before rsID assignment into a single, genome-wide file. |
| `rsid_assignment.py` | Assigns rsIDs to variants present in the common single-variant summary statistics (excluding the deprivation index) using GWASLab. Each chromosome is processed in a loop, and chromosome-specific results are subsequently combined using `merge_rsid_plink.py`. |
| `rsid_deprivation_index_assignment.py` | Assigns rsIDs to variants present in the common single-variant summary statistics (including the deprivation index) using GWASLab. Each chromosome is processed in a loop, and chromosome-specific results are subsequently combined using `merge_rsid_deprivation_index_plink.py`. |
| `merge_rsid_plink.py` | Combines chromosome-specific summary statistics files (excluding the deprivation index) generated after rsID assignment into a single, genome-wide file, ensuring consistent formatting and variant alignment across chromosomes. |
| `merge_rsid_deprivation_index_plink.py` | Combines chromosome-specific summary statistics files (including the deprivation index) generated after rsID assignment into a single, genome-wide file, ensuring consistent formatting and variant alignment across chromosomes. |
| `manhattan_qq_plot.py` | Generates Manhattan and quantile–quantile (QQ) plots from common single-variant summary statistics (excluding the deprivation index) using GWASLab. The Manhattan plot visualizes association signals across the genome, while the QQ plot assesses the distribution of observed versus expected p-values to evaluate potential inflation or systematic bias. |
| `manhattan_qq_deprivation_index_plot.py` | Generates Manhattan and quantile–quantile (QQ) plots from common single-variant summary statistics (including the deprivation index) using GWASLab. The Manhattan plot visualizes association signals across the genome, while the QQ plot assesses the distribution of observed versus expected p-values to evaluate potential inflation or systematic bias. |
| `correlation_single_variant_plot.R` | Computes the Spearman correlation between common single-variant summary statistics generated with and without the deprivation index as a covariate. The Spearman correlation coefficient is reported in the plot, which compares the negative log p-values from the two analyses. |
| `magma.sh` | Performs gene and gene-set association analyses on common single-variant summary statistics (excluding the deprivation index) using MAGMA (v1.10). Prior to analysis, common variants were mapped to rsIDs using GWASLab with dbSNP Build 157. Variants were then assigned to genes using a window of 35 kb upstream and 10 kb downstream of each gene. Gene-level association tests were followed by gene-set analyses using gene sets from MSigDB (release 2025.1.Hs). |
| `magma_index.sh` | Performs gene and gene-set association analyses on common single-variant summary statistics (including the deprivation index) using MAGMA (v1.10). Prior to analysis, common variants were mapped to rsIDs using GWASLab with dbSNP Build 157. Variants were then assigned to genes using a window of 35 kb upstream and 10 kb downstream of each gene. Gene-level association tests were followed by gene-set analyses using gene sets from MSigDB (release 2025.1.Hs). |
| `magma_window.sh` | Performs gene- and gene-set association analyses on common single-variant summary statistics (excluding the deprivation index) using MAGMA (v1.10). Variants were first mapped to rsIDs using GWASLab with dbSNP Build 157. Window sizes were varied across 11 iterations (0–100 kb upstream, 0–50 kb downstream), with gene-level tests followed by gene-set analyses using MSigDB gene sets (release 2025.1.Hs). |
| `magma_index_window.sh` | Performs gene- and gene-set association analyses on common single-variant summary statistics (including the deprivation index) using MAGMA (v1.10). Variants were first mapped to rsIDs using GWASLab with dbSNP Build 157. Window sizes were varied across 11 iterations (0–100 kb upstream, 0–50 kb downstream), with gene-level tests followed by gene-set analyses using MSigDB gene sets (release 2025.1.Hs). |
| `magma_window_plots.R` | Visualizes MAGMA gene and gene-set results (excluding the deprivation index) across different gene-mapping window sizes to assess the robustness of associations to window choice. |
| `magma_window_index_plots.R` | Visualizes MAGMA gene and gene-set results (including the deprivation index) across different gene-mapping window sizes to assess the robustness of associations to window choice. |

## Pipeline Overview

### Preprocessing Summary Statistics

**rsid_assignment.py**

This script assigns rsIDs to variants present in the common single-variant summary statistics (excluding the deprivation index) using GWASLab. Each chromosome is processed in a loop, and the chromosome-specific results are then combined using the subsequent script, `merge_rsid_plink.py`.

Summary Statistics Pipeline: SAIGE-GENE+ Single Variant Association Pipeline

**rsid_deprivation_index_assignment.py**

This script assigns rsIDs to variants present in the common single-variant summary statistics (including the deprivation index) using GWASLab. Each chromosome is processed in a loop, and the chromosome-specific results are then combined using the subsequent script, `merge_rsid_deprivation_index_plink.py`.

Summary Statistics Pipeline: SAIGE-GENE+ Single Variant Association Pipeline

**merge_rsid_plink.py**

This script combines chromosome-specific summary statistics files (excluding the deprivation index) generated after rsID assignment into a single, genome-wide file. The script merges per-chromosome outputs produced by GWASLab, ensuring consistent formatting and variant alignment across chromosomes, and generates a unified summary statistics file suitable for downstream analyses and workflows.

**merge_rsid_deprivation_index_plink.py**

This script combines chromosome-specific summary statistics files (including the deprivation index) generated after rsID assignment into a single, genome-wide file. The script merges per-chromosome outputs produced by GWASLab, ensuring consistent formatting and variant alignment across chromosomes, and generates a unified summary statistics file suitable for downstream analyses and workflows.

### Summary Statistic Plots

**manhattan_qq_plot.py**

This script generates Manhattan and quantile–quantile (QQ) plots from common single-variant summary statistics (excluding the deprivation index) using GWASLab. The script visualizes association signals across the genome by chromosome in the Manhattan plot and assesses the distribution of observed versus expected p-values in the QQ plot to evaluate potential inflation or systematic bias.

**manhattan_qq_deprivation_index_plot.py**

This script generates Manhattan and quantile–quantile (QQ) plots from common single-variant summary statistics (including the deprivation index) using GWASLab. The script visualizes association signals across the genome by chromosome in the Manhattan plot and assesses the distribution of observed versus expected p-values in the QQ plot to evaluate potential inflation or systematic bias.

### MAGMA Scripts

**magma.sh**

This script performs gene and gene-set association analyses on common single-variant summary statistics (excluding the deprivation index) using MAGMA (v1.10). Prior to analysis, common variants were mapped to rsIDs using GWASLab with dbSNP Build 157. Variants were then assigned to genes using a window of 35 kb upstream and 10 kb downstream of each gene. Gene-level association tests were followed by gene-set analyses using gene sets from MSigDB (release 2025.1.Hs).

**magma_index.sh**

This script performs gene and gene-set association analyses on common single-variant summary statistics (including the deprivation index) using MAGMA (v1.10). Prior to analysis, common variants were mapped to rsIDs using GWASLab with dbSNP Build 157. Variants were then assigned to genes using a window of 35 kb upstream and 10 kb downstream of each gene. Gene-level association tests were followed by gene-set analyses using gene sets from MSigDB (release 2025.1.Hs).

**magma_window.sh**

This script performs gene- and gene-set association analyses on common single-variant summary statistics (excluding the deprivation index) using MAGMA (v1.10). Variants were first mapped to rsIDs using GWASLab with dbSNP Build 157. Window sizes were varied across 11 iterations (0–100 kb upstream, 0–50 kb downstream), with gene-level tests followed by gene-set analyses using MSigDB gene sets (release 2025.1.Hs).

**magma_index_window.sh**

This script performs gene- and gene-set association analyses on common single-variant summary statistics (including the deprivation index) using MAGMA (v1.10). Variants were first mapped to rsIDs using GWASLab with dbSNP Build 157. Window sizes were varied across 11 iterations (0–100 kb upstream, 0–50 kb downstream), with gene-level tests followed by gene-set analyses using MSigDB gene sets (release 2025.1.Hs).

**magma_window_plots.R**

This script visualizes MAGMA gene and gene-set results (excluding the deprivation index) across different gene-mapping window sizes to assess the robustness of associations to window choice.

**magma_window_index_plots.R**

This script visualizes MAGMA gene and gene-set results (including the deprivation index) across different gene-mapping window sizes to assess the robustness of associations to window choice.

### Summary Statistics Correlation Scripts

**merge_plink.py**

This script combines chromosome-specific summary statistics files (excluding the deprivation index) generated before rsID assignment into a single, genome-wide file.

Summary Statistics Pipeline: SAIGE-GENE+ Single Variant Association Pipeline

**merge_deprivation_index_plink.py**

This script combines chromosome-specific summary statistics files (including the deprivation index) generated before rsID assignment into a single, genome-wide file.

Summary Statistics Pipeline: SAIGE-GENE+ Single Variant Association Pipeline

**correlation_single_variant_plot.R**

This script computes the Spearman correlation between common single-variant summary statistics generated with and without the deprivation index as a covariate. The Spearman correlation coefficient is reported in the plot, which compares the negative log p-values from the two analyses.

## Pipeline Overview

**Preprocessing and MAGMA Analysis**

```text
Single Variant Summary Statistics
   |
   v
rsid_assignment.py or rsid_deprivation_index_assignment.py
   |
   v
merge_rsid_plink.py or merge_rsid_deprivation_index_plink.py
   |
   v
Preprocessed Summary Statistics -> Summary Statistic Plots
   |
   v
MAGMA Scripts
```

**Summary Statistics Correlation Analysis**

```text
Single Variant Summary Statistics
   |
   v
merge_plink.py or merge_deprivation_index_plink.py
   |
   v
correlation_single_variant_plot.R
```
