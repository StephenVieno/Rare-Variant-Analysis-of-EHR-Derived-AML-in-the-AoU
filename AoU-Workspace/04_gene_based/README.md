# Annotation Sensitivity Pipeline 
### AML-Annotation-Threshold-Analysis.ipynb
- This script submits SAIGE-GENE+ rare variant set-based gene association analyses for four different annotation groups. On the smallest chromosome, chromosome 21, this was performed as part of a sensitivity analysis to determine the optimal threshold for each category to be used in the main analysis. Specifically, this included determining the threshold for LOFTEE to classify loss-of-function variants, the threshold for SpliceAI scores to identify splicing variants, the threshold for AlphaMissense scores to classify missense variants, and the use of synonymous variants as a negative control.
   - Annotation Script: [Single-Class-Annotations.py](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/tree/main/Local-Workspace/Annotation-Scripts)

### AML-Annotation-Threshold-Manhattan-Plot.ipynb
- This script plots the results from the annotation sensitivity analysis to demonstrate which thresholds are optimal for each variant annotation category. In the AML results, the optimal thresholds were determined as follows:

   - high-confidence loss-of-function variants from LOFTEE for the loss-of-function category;
   - SpliceAI scores greater than 0.8 for splice variants;
   - AlphaMissense scores greater than 0.546 for missense variants;
   - and synonymous variants identified by VEP with SpliceAI scores less than 0.5 for the synonymous category.
