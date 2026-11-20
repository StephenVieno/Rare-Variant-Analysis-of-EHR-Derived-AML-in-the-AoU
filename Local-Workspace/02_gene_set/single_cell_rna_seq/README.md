# 2 – Single-Cell RNA-Seq Analysis ([GSE116256](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116256))

This directory contains scripts for processing and analyzing single-cell RNA-seq data from [GSE116256](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116256), comprising 16 AML and 5 healthy bone marrow samples collected at diagnosis. The workflow includes quality control, normalization, doublet removal, data integration, and cell type–specific differential expression analysis to generate upregulated and downregulated gene sets for downstream rare variant polygenic risk score analyses.

## Scripts

| Script | Description |
|---|---|
| `GSE116256_single_cell_qc_plots.R` | Performs cell-level quality control filtering and generates QC visualizations. |
| `GSE116256_single_cell_SCTransform.R` | Normalizes individual samples using SCTransform. |
| `GSE116256_doublet_finder.R` | Identifies and removes doublets on a per-sample basis using DoubletFinder. |
| `GSE116256_single_cell_diagnosis_intergration.R` | Integrates AML and healthy bone marrow samples using Harmony. |
| `GSE116256_single_cell_differential_expression.R` | Performs cell type–specific differential expression analysis and generates upregulated and downregulated gene sets. |

## Quality Control and Preprocessing

**`GSE116256_single_cell_qc_plots.R`**

Performs initial quality control and visualization. Cells are filtered based on the following criteria:

- At least 1,000 UMIs.
- At least 500 detected genes.
- Less than 20% mitochondrial and ribosomal RNA content.

The script also generates QC plots to assess sample quality and filtering characteristics. Cells had undergone prior quality control and annotation before this additional filtering.

**`GSE116256_single_cell_SCTransform.R`**

Normalizes each sample independently using SCTransform (Seurat v5.3.0), reducing technical variability while preserving biological signal.

**`GSE116256_doublet_finder.R`**

Identifies and removes doublets on a per-sample basis using DoubletFinder (v2.0.6), with a Poisson-derived expected doublet rate of 0.5734%.

## Data Integration

**`GSE116256_single_cell_diagnosis_intergration.R`**

Integrates AML and healthy bone marrow samples using Harmony with 30 principal components. This enables joint downstream analysis while retaining previously assigned cell type annotations.

## Differential Expression and Gene-Set Generation

**`GSE116256_single_cell_differential_expression.R`**

Performs cell type–specific differential expression analysis using MAST, including only malignant and normal cells. Multiple contrasts are evaluated, comparing malignant versus unaffected cells and individual cell types versus all others, with and without healthy samples.

Age and sex are included as covariates, with sample ID additionally included where applicable. Significant protein-coding genes are defined using a Bonferroni-corrected p-value <0.01 and an absolute log2 fold change ≥0.58. Genes are separated into upregulated and downregulated sets according to their expression direction.
