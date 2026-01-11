# LEAVE-ONE-VARIANT-OUT ANALYSIS

# CROSS REFERENCE MARK LIST WITH GDC AND CLINVAR
### AML-Marker-List.ipynb
This script cross-references variants in the SAIGE-GENE+ marker list with somatic variants from the GDC and germline variants from ClinVar. Analyses are conducted separately for ultra-rare variants (MAC ≤ 10) and rare variants (MAF < 1% and MAC > 10). AoU IDs are converted to HGVS IDs, and the GDC somatic mutation file is annotated to indicate the presence or absence of each variant. For ClinVar, variants are filtered to retain only those present in the marker list, resulting in a final consolidated list of variants.

### AML-Marker-List-Deprivation-Index.ipynb
This script cross-references variants in the SAIGE-GENE+ marker list from the deprivation index with somatic variants from the GDC and germline variants from ClinVar. Analyses are conducted separately for ultra-rare variants (MAC ≤ 10) and rare variants (MAF < 1% and MAC > 10). AoU IDs are converted to HGVS IDs, and the GDC somatic mutation file is annotated to indicate the presence or absence of each variant. For ClinVar, variants are filtered to retain only those present in the marker list, resulting in a final consolidated list of variants.

# LEAVE ONE VARIANT OUT ANALYSIS
### AML-LOVO-Step01.ipynb
This script creates a PLINK BED file from the exome dataset by subsetting variants that pass quality control within the genes of interest. The script must be submitted once for each chromosome containing a gene of interest. The resulting BED file is then used in a leave-one-variant-out analysis to determine which variants contribute most to the genome-wide significance of the genes of interest. Additionally, the script requires a list of variants that passed exome quality control and are located within the genes of interest.

### AML-LOVO-Step02.ipynb
This script submits the commands for the leave-one-variant-out (LOVO) analysis. It performs Step 2 of the SAIGE-GENE+ association tests for each variant set, where each set has exactly one variant removed from the full collection. The script iterates over all annotation files, with each file representing a reduced variant set missing one specific variant. By looping through these files, the pipeline re-runs Step 2 for every leave-one-out subset, allowing for evaluation of each variant’s individual contribution to the overall gene-based association signal and identifying variants that disproportionately influence the test statistic.

### AML-LOVO-Step02-Deprivation-Index.ipynb
This script submits the commands for the leave-one-variant-out (LOVO) analysis incorporating the deprivation index. It performs Step 2 of the SAIGE-GENE+ association tests for each variant set, where each set has exactly one variant removed from the full collection. The script iterates over all annotation files, with each file representing a reduced variant set missing one specific variant. By looping through these files, the pipeline re-runs Step 2 for every leave-one-out subset, allowing for evaluation of each variant’s individual contribution to the overall gene-based association signal and identifying variants that disproportionately influence the test statistic.

### AML-LOVO-Step01-UVA.ipynb
This script creates a PLINK BED file from the exome dataset by subsetting variants that pass quality control within the genes of interest. The script must be submitted once for each chromosome containing a gene of interest. The resulting BED file is then used in a leave-one-variant-out analysis to determine which variants contribute most to the genome-wide significance of the genes of interest. Additionally, the script requires a list of variants that passed exome quality control and are located within the genes of interest.

### AML-LOVO-Step02-UVA.ipynb
This script submits the commands for the leave-one-variant-out (LOVO) analysis. It performs Step 2 of the SAIGE-GENE+ association tests for each variant set, where each set has exactly one variant removed from the full collection. The script iterates over all annotation files, with each file representing a reduced variant set missing one specific variant. By looping through these files, the pipeline re-runs Step 2 for every leave-one-out subset, allowing for evaluation of each variant’s individual contribution to the overall gene-based association signal and identifying variants that disproportionately influence the test statistic.

# Pipeline Overview 
```markdown
Set-Based Pipeline 
   |
   v
AML-SAIGE-GENE-Set-Based-Step05 (SAIGE-GENE Step 2)
- Group Annotation Files required 
   |
   v
AML-Marker-List or AML-Marker-List-Deprivation-Index (Cross Reference with GDC and Clinvar) 
- File of GDC variants required 
- Clinvar variants are downloaed in script 
   |
   v
AML-LOVO-Step01 or AML-LOVO-Step01-Deprivation-Index 
- List of variants in each gene required 
- Run once for each chromosome 
   |
   v
AML-LOVO-Step02 or AML-LOVO-Step02-Deprivation-Index (SAIGE-GENE Step 2)
- SAIGE-GENE Step 1 files required
```
