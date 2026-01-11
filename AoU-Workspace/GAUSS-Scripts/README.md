# GAUSS Pipeline 
### AML-GAUSS.ipynb 
- This script performs the GAUSS gene set analysis for genes from GO, KEGG, and MSigDB. For MSigDB, gene sets are filtered based on their relevance to acute myeloid leukemia, and only those related to AML are retained for this analysis. Before running the script, set the number of CPUs to 4 to enable parallel processing in GAUSS. The second half of the script generates plots of the final results.

# Pipeline Overview 
```markdown 
GAUSS ANALYSIS
Set-Based Pipeline 
   |
   v
AML-SAIGE-GENE-Set-Based-Step05 (SAIGE-GENE Step 2)
- Group Annotation Files required 
   |
   v
AML-GAUSS
```
