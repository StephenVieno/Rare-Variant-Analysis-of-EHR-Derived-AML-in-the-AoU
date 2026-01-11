# SPARSE GRM SAIGE-GENE+

# GRM - SAIGE-GENE SET BASED
### GRM-QC-Step01.ipynb
The following script filters variants required for the genetic relationship matrix. Variants were removed if they were duplicated, multi-allelic, non–single nucleotide variants, or ambiguous. The variants that passed these filters were subsequently used in the next step for pruning the microarray data from the All of Us Research Program, followed by calculation of the genetic relationship matrix. In bcftools, a multiallelic site refers to a position in the genome where there are multiple alternative alleles observed at a single variant position. In simpler terms, a multiallelic site occurs when more than one alternative allele is present at a specific position in a set of genomic sequences. Equivalent command: bcftools view -m 2 -M 2 multi_allelic_sites.vcf > biallelic_sites.vcf

### GRM-QC-Step02.ipynb
This script prunes array data in the African, American, and European ancestry groups for both GRM calculation and principal component analysis. Variants are first filtered based on a minor allele frequency of 0.01%, a genotyping missingness rate of less than 0.01%, a Hardy-Weinberg equilibrium p-value threshold of 1x10⁻⁶, and must be biallelic and located on autosomal chromosomes. Linkage disequilibrium (LD) pruning is performed within a 200 kb window, removing variants with an r² > 0.1. The output of this script is a file containing variants that pass these filters. We expect the African and American cohorts to have the highest number of variants passing these filters, with the European cohort having the lowest number. The variants that pass these filters will then undergo a second pruning step before being used for GRM calculation and principal component analysis.

### GRM-QC-Step03.ipynb
This script creates PLINK files from array data in the African, American, and European ancestry groups using variants that passed the second pruning step for GRM calculation.

### GRM-QC-Step04.ipynb
This script calculates the GRM for the African, American, and European ancestry groups using Sparse GRM, 5,000 randomly selected markers, a minor allele frequency (MAF) > 0.01, and a relatedness cutoff of 0.05.

# Pipeline Overview 
```markdown
Workspace Environment Scripts 
   |
   v
 GRM-QC-Step01 (SAIGE-GENE Step 0) 
   |
   v
 GRM-QC-Step02 (SAIGE-GENE Step 0)
 - Within-Ancestry QC required
 - Run once for each Ancestry
   |
   v
 GRM-QC-Step03 (SAIGE-GENE Step 0) 
 - Run once for each Ancestry
   |
   v
 GRM-QC-Step04 (SAIGE-GENE Step 0) 
 - Run once for each Ancestry 
   |
   v
Set-Bassed or Single Variant SAIGE-GENE+
```
