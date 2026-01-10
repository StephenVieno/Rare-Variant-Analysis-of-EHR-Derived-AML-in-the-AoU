# Preprocessing Summary Statistics  
### RSID-Assignment.py
 - This script assigns rsIDs to variants present in the AoU using gwaslab [GWASLab](https://cloufield.github.io/gwaslab/). Each chromosome is processed in a loop, and the chromosome-specific results are then combined using the script Merge-Rsid-PLINK.py.
### RSID-Deprivation-Index-Assignment.py
### Merge-Rsid-PLINK.py
### Merge-Rsid-Deprivation-Index-PLINK.py

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









