

# Variant Annotation 
### Format-VEP-Input.sh
- This script takes a list of quality-controlled variants from the All of Us (AoU) EUR-like ancestry cohort and converts AoU variant identifiers into VCF format. The resulting file is formatted for direct input into the Variant Effect Predictor (VEP).
### VEP-Command.sh
- This shell script runs the Ensembl Variant Effect Predictor (VEP) using predefined options and plugins. It annotates each variant on the MANE-select transcript and includes functional predictions from LOFTEE, SpliceAI, and AlphaMissense.

# SAIGE-GENE+ Annotation File Scripts 
### HC-Annotations.py
- This script generates the SAIGE-GENE+ annotation file for rare variant set–based testing using the MANE-Select transcript. Variants are categorized as high-confidence loss-of-function (LOFTEE), splice (SpliceAI > 0.8), missense (AlphaMissense > 0.546), or synonymous (VEP-annotated with SpliceAI < 0.5).
### Single-Class-Annotations.py
- This script generates separate SAIGE-GENE+ annotation files for each variant group (loss-of-function, missense, synonymous) for rare variant set–based testing using the MANE-Select transcript. Variants are classified using plugin-specific thresholds: high-confidence LOFTEE for loss-of-function, SpliceAI for splice, AlphaMissense for missense, and VEP-annotated consequence for synonymous. This setup is used in a sensitivity analysis to evaluate the impact of individual variant annotations.
### Leave-One-Variant-Out-Annotations.py
- This script generates SAIGE-GENE+ annotation files where each variant in a given gene is sequentially left out. It enables leave-one-variant-out (LOVO) rare variant tests to assess the contribution of individual variants to gene-level associations. Variants are classified using the same MANE-Select transcript–based criteria as in the single-class annotation scripts.
### UVA-Leave-One-Variant-Out-Annotations.py
- This script performs a gene-based leave-one-variant-out (LOVO) annotation specifically for 'UVA Genes'. 
### GENE-CHECK-Annotations.py 
- This script ensures that all variants are correctly assigned to a corresponding gene. It can be run independently of the main analysis as a sanity check before downstream analyses.
  
# Rare Variant Polygenic Risk Score Scripts 
### HC-Burden-PRS.py
- This script generates a weight file for rare variant burden–based polygenic risk score (PRS) calculation. All predicted deleterious coding rare variants (loss-of-function or missense), as identified by LOFTEE, SpliceAI, or AlphaMissense, are assigned a weight of one, and the output is formatted for use with plink2.
### Exome-Burden-PRS.py
- This script generates a weight file for exome burden–based polygenic risk score (PRS) calculation. All coding and non-coding variants are assigned a weight of one, and the output is formatted for use with plink2.

# Analysis Overview 
```markdown
AoU Quality Controlled Variants 
   |
   v
Format-VEP-Input.sh
   |
   v
VEP-Command.sh -> Rare Variant Polygenic Risk Score Scripts (HC-Burden-PRS.py & Exome-Burden-PRS.py) 
   |
   v
SAIGE-GENE+ Annotation File Scripts
- HC-Annotations.py
- Single-Class-Annotations.py
- Leave-One-Variant-Out-Annotations.py
```
