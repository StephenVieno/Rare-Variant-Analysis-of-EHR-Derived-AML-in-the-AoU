# Preprocessing Summary Statistics  
### RSID-Assignment.py
 - This script assigns rsIDs to variants present in the common single-variant summary statistics (excluding the deprivation index) using [GWASLab](https://cloufield.github.io/gwaslab/). Each chromosome is processed in a loop, and the chromosome-specific results are then combined using the subsequent script, Merge-Rsid-PLINK.py.
### RSID-Deprivation-Index-Assignment.py
 - This script assigns rsIDs to variants present in the common single-variant summary statistics (including the deprivation index) using [GWASLab](https://cloufield.github.io/gwaslab/). Each chromosome is processed in a loop, and the chromosome-specific results are then combined using the subsequent script, Merge-Rsid-Deprivation-Index-PLINK.py.
### Merge-Rsid-PLINK.py
- Merge-Rsid-PLINK.py combines chromosome-specific summary statistics files generated after rsID assignment into a single, genome-wide file. The script merges per-chromosome outputs produced by GWASLab, ensuring consistent formatting and variant alignment across chromosomes, and generates a unified summary statistics file suitable for downstream analyses and workflows.
### Merge-Rsid-Deprivation-Index-PLINK.py
- Merge-Rsid-Deprivation-Index-PLINK.py combines chromosome-specific summary statistics files generated after rsID assignment into a single, genome-wide file. The script merges per-chromosome outputs produced by GWASLab, ensuring consistent formatting and variant alignment across chromosomes, and generates a unified summary statistics file suitable for downstream analyses and workflows.

# Summary Statistic Plots 
### Manhattan-QQ-Plot.py
### Manhattan-QQ-Deprivation-Index-Plot.py

# MAGMA Scripts  
### MAGMA.sh
### MAGMA-INDEX.sh
### MAGMA-WINDOW.sh
### MAGMA-INDEX-WINDOWS.sh

# Analysis Overview 
```markdown
Single Variant Summary Statisticis
   |
   v
 Merge-PLINK.py or Merge-Deprivation-Index-PLINK.py
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
### Merge-PLINK.py
### Merge-Deprivation-Index-PLINK.py









