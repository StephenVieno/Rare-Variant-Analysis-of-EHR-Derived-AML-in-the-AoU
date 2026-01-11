# Single-Cell RNA-Seq Analysis Summary ([GSE116256](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116256))
Single-cell, cell type–specific gene sets were derived from differential expression analyses of [GSE116256](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116256), using 16 AML and 5 healthy bone marrow samples collected at diagnosis. Cells had undergone prior quality control and annotation; additional filtering required ≥1,000 UMIs, ≥500 genes, and <20% mitochondrial or ribosomal reads. Samples were normalized with SCTransform, doublets were removed using DoubletFinder, and data were integrated with Harmony. Differential expression was performed with MAST, including only malignant and normal cells. Multiple contrasts were tested, comparing malignant versus unaffected cells and individual cell types versus all others, with or without healthy samples. Age and sex (and sample ID when applicable) were included as covariates. Significant protein-coding genes were defined using a Bonferroni-corrected p-value <0.01 and |log2 fold change| ≥0.58, and were categorized into upregulated or downregulated gene sets based on expression direction.

# Single-Cell RNA-Seq Analysis Pipeline ([GSE116256](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116256))
- This repository implements a stepwise single-cell RNA-seq analysis workflow for AML diagnosis samples from GSE116256, from quality control through differential expression and gene-set generation.
### GSE116256-Single-Cell-QC-Plots.R
- This script performs initial quality control and visualization by filtering cells with <1,000 UMIs, <500 detected genes, or >20% mitochondrial/ribosomal RNA content, and generates QC plots to assess sample quality.
### GSE116256-Single-Cell-SCTransform.R
- This script normalizes each sample independently using SCTransform (Seurat v5.3.0) to reduce technical variability while preserving biological signal.
### GSE116256-Doublet-Finder.R
- This script identifies and removes doublets on a per-sample basis using DoubletFinder (v2.0.6) with a Poisson-derived expected doublet rate of 0.5734%.
### GSE116256-Single-Cell-Diagnosis-Intergration.R
- This script integrates AML and healthy bone marrow samples using Harmony with 30 principal components, enabling joint analysis while retaining prior cell type annotations.
### GSE116256-Single-Cell-Differential-Expresssion.R
- This script performs cell type–specific differential gene expression analysis using MAST, including only malignant and normal cells, testing multiple contrasts with appropriate covariates, and generating upregulated and downregulated gene sets using Bonferroni-corrected p-values <0.01 and |log2 fold change| ≥0.58.

# Analysis Overview
```markdown
GSE116256-Single-Cell-QC-Plots.R
   |
   v
GSE116256-Single-Cell-SCTransform.R
   |
   v
GSE116256-Doublet-Finder.R
   |
   v
GSE116256-Single-Cell-Diagnosis-Intergration.R
   |
   v
GSE116256-Single-Cell-Differential-Expresssion.R
   |
   v
Single-Cell RNA-Seq Gene-sets -> Rare Variant Polygenic Risk Score Pipeline 
```
