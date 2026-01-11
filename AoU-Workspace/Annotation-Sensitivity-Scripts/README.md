# Annotation Sensitivity Pipeline 
### AML-Annotation-Threshold-Analysis.ipynb
- This script submits SAIGE-GENE+ rare variant set-based gene association analyses for four different annotation groups. On the smallest chromosome, chromosome 21, this was performed as part of a sensitivity analysis to determine the optimal threshold for each category to be used in the main analysis. Specifically, this included determining the threshold for LOFTEE to classify loss-of-function variants, the threshold for SpliceAI scores to identify splicing variants, the threshold for AlphaMissense scores to classify missense variants, and the use of synonymous variants as a negative control.
   - ([Annotation Files](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/tree/main/Local-Workspace/Annotation-Scripts))

### AML-Annotation-Threshold-Manhattan-Plot.ipynb
- This script plots the results from the annotation sensitivity analysis to demonstrate which thresholds are optimal for each variant annotation category. In the AML results, the optimal thresholds were determined as follows:

   - high-confidence loss-of-function variants from LOFTEE for the loss-of-function category;
   - SpliceAI scores greater than 0.8 for splice variants;
   - AlphaMissense scores greater than 0.546 for missense variants;
   - and synonymous variants identified by VEP with SpliceAI scores less than 0.5 for the synonymous category.

# Pipeline Overview 
```markdown
Workspace Environment Scripts 
   |
   v
Pre-Analysis Files 
- File of Person IDs corresponding to Cases 
- File of Age and Observation Period (Observation-Period)
- Within-Ancestry PCs 
- Within-Ancestry QC 
   |
   v
 SAIGE-GENE+ Phenotype File 
 - AML-Phenotype-File
 - AML-Deprivation-Index-File 
   |
   v
Set-Based or Single Variant SAIGE-GENE+ -> Single Variant Pipepline 
   |
   v
Set-Based Pipeline <- GRM-QC-Step04 <- GRM-QC-Step03 <- GRM-QC-Step02 <- GRM-QC-Step01 (SAIGE-GENE Step 0) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step01 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step02 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step03 (SAIGE-GENE Step 1) 
   |
   v
AML-SAIGE-GENE-Set-Based-Step04 (SAIGE-GENE Step 1) or AML-SAIGE-GENE-Set-Based-Step04-Deprivation-Index
   |
   v
AML-Annotation-Threshold-Analysis (SAIGE-GENE Step 2) <- Single-Class-Annotations.py
- Group Annotation Files required 
   |
   v
AML-Annotation-Threshold-Manhattan-Plot
```


# Links
- [Variant Effect Predictor](https://www.ensembl.org/info/docs/tools/vep/index.html)
- [Variant Effect Predictor Plugins](https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html)
- [LOFTEE](https://github.com/konradjk/loftee)
- [SpliceAI](https://github.com/Illumina/SpliceAI?tab=readme-ov-file)
- [AlphaMissense](https://alphamissense.hegelab.org)
  

