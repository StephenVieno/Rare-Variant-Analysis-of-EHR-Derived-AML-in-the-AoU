# Preprocessing Summary Statistics 
### RSID-Assignment.py
- This script assigns rsIDs to variants present in the common single-variant summary statistics (excluding the deprivation index) using [GWASLab](https://cloufield.github.io/gwaslab/). Each chromosome is processed in a loop, and the chromosome-specific results are then combined using the subsequent script, Merge-Rsid-PLINK.py.
 - Summary Statistics Pipepline: [SAIGE-GENE+ Single Variant Association Pipeline](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/tree/main/AoU-Workspace/Single-Variant-Association-Scripts)
### RSID-Deprivation-Index-Assignment.py
- This script assigns rsIDs to variants present in the common single-variant summary statistics (including the deprivation index) using [GWASLab](https://cloufield.github.io/gwaslab/). Each chromosome is processed in a loop, and the chromosome-specific results are then combined using the subsequent script, Merge-Rsid-Deprivation-Index-PLINK.py.
### Merge-Rsid-PLINK.py
- This script combines chromosome-specific summary statistics files (excluding the deprivation index) generated after rsID assignment into a single, genome-wide file. The script merges per-chromosome outputs produced by GWASLab, ensuring consistent formatting and variant alignment across chromosomes, and generates a unified summary statistics file suitable for downstream analyses and workflows.
### Merge-Rsid-Deprivation-Index-PLINK.py
- This script combines chromosome-specific summary statistics files (including the deprivation index) generated after rsID assignment into a single, genome-wide file. The script merges per-chromosome outputs produced by GWASLab, ensuring consistent formatting and variant alignment across chromosomes, and generates a unified summary statistics file suitable for downstream analyses and workflows.

# Summary Statistic Plots 
### Manhattan-QQ-Plot.py
- This script generates Manhattan and quantile–quantile (QQ) plots from common single-variant summary statistics (excluding the deprivation index) using [GWASLab](https://cloufield.github.io/gwaslab/). The script visualizes association signals across the genome by chromosome in the Manhattan plot and assesses the distribution of observed versus expected p-values in the QQ plot to evaluate potential inflation or systematic bias.
### Manhattan-QQ-Deprivation-Index-Plot.py
- This script generates Manhattan and quantile–quantile (QQ) plots from common single-variant summary statistics (including the deprivation index) using [GWASLab](https://cloufield.github.io/gwaslab/). The script visualizes association signals across the genome by chromosome in the Manhattan plot and assesses the distribution of observed versus expected p-values in the QQ plot to evaluate potential inflation or systematic bias.

# MAGMA Scripts  
### MAGMA.sh
- This script performs gene and gene-set association analyses on common single-variant summary statistics (excluding the deprivation index) using [MAGMA](https://cncr.nl/research/magma/) (v1.10). Prior to analysis, common variants were mapped to rsIDs using [GWASLab](https://cloufield.github.io/gwaslab/) with dbSNP Build 157. Variants were then assigned to genes using a window of 35 kb upstream and 10 kb downstream of each gene. Gene-level association tests were followed by gene-set analyses using gene sets from [MSigDB](https://www.gsea-msigdb.org/gsea/msigdb) (release 2025.1.Hs).
### MAGMA-INDEX.sh
- This script performs gene and gene-set association analyses on common single-variant summary statistics (including the deprivation index) using [MAGMA](https://cncr.nl/research/magma/) (v1.10). Prior to analysis, common variants were mapped to rsIDs using [GWASLab](https://cloufield.github.io/gwaslab/) with dbSNP Build 157. Variants were then assigned to genes using a window of 35 kb upstream and 10 kb downstream of each gene. Gene-level association tests were followed by gene-set analyses using gene sets from [MSigDB](https://www.gsea-msigdb.org/gsea/msigdb) (release 2025.1.Hs).
### MAGMA-WINDOW.sh
- This script performs gene- and gene-set association analyses on common single-variant summary statistics (excluding the deprivation index) using [MAGMA](https://cncr.nl/research/magma/) (v1.10). Variants were first mapped to rsIDs using [GWASLab](https://cloufield.github.io/gwaslab/) with dbSNP Build 157. Window sizes were varied across 11 iterations (0–100 kb upstream, 0–50 kb downstream), with gene-level tests followed by gene-set analyses using [MSigDB](https://www.gsea-msigdb.org/gsea/msigdb) gene sets (release 2025.1.Hs).
### MAGMA-INDEX-WINDOWS.sh
- This script performs gene- and gene-set association analyses on common single-variant summary statistics (including the deprivation index) using [MAGMA](https://cncr.nl/research/magma/) (v1.10). Variants were first mapped to rsIDs using [GWASLab](https://cloufield.github.io/gwaslab/) with dbSNP Build 157. Window sizes were varied across 11 iterations (0–100 kb upstream, 0–50 kb downstream), with gene-level tests followed by gene-set analyses using [MSigDB](https://www.gsea-msigdb.org/gsea/msigdb) gene sets (release 2025.1.Hs).
### MAGMA-Window-Plots.R
- MAGMA-Window-Plots.R visualizes MAGMA gene and gene-set results (excluding the deprivation index) across different gene-mapping window sizes to assess the robustness of associations to window choice.
### MAGMA-Window-Index-Plots.R
- MAGMA-Window-Index-Plots.R visualizes MAGMA gene and gene-set results (including the deprivation index) across different gene-mapping window sizes to assess the robustness of associations to window choice.

# Pipeline Overview 
```markdown
Single Variant Summary Statisticis
   |
   v
RSID-Assignment.py or RSID-Deprivation-Index-Assignment.py
   |
   v
Merge-Rsid-PLINK.py or Merge-Rsid-Deprivation-Index-PLINK.py
   |
   v
Preprocessed Summary Statistics -> Summary Statistic Plots  
   |
   v
MAGMA Scripts 
```

# Summary Statistics Correlation Scripts 
### Merge-PLINK.py
- This script combines chromosome-specific summary statistics files (excluding the deprivation index) generated before rsID assignment into a single, genome-wide file. 
### Merge-Deprivation-Index-PLINK.py
- This script combines chromosome-specific summary statistics files (including the deprivation index) generated before rsID assignment into a single, genome-wide file. 
### Correlation-Single-Variant-Plot.R
This script computes the Spearman correlation between common single variant summary statistics generated with and without the deprivation index as a covariate. The Spearman correlation coefficient is reported in the plot, which compares the negative log p-values from the two analyses.

# Pipeline Overview 
```markdown
Single Variant Summary Statisticis
   |
   v
Merge-PLINK.py or Merge-Deprivation-Index-PLINK.py
   |
   v
Correlation-Single-Variant-Plot.R
```




