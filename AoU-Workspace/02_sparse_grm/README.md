## Sparse GRM SAIGE-GENE+

This directory contains Jupyter notebooks for preparing genotype data and calculating ancestry-specific sparse genetic relationship matrices (GRMs) for downstream SAIGE-GENE+ analyses in the All of Us (AoU) Research Program. The workflow includes variant-level quality control, linkage disequilibrium (LD) pruning, genotype data preparation, and sparse GRM calculation across the African, American, and European ancestry groups.

### Notebook Descriptions

| Notebook | Description |
|---|---|
| `02_01_grm_qc_step01.ipynb` | Filters variants for GRM construction by removing duplicate, multiallelic, non-single nucleotide variant (non-SNV), and ambiguous variants. The resulting variant set is used for subsequent array genotype pruning, GRM calculation, and principal component analysis (PCA). |
| `02_02_grm_qc_step02.ipynb` | Performs ancestry-specific genotype quality control and LD pruning for the African, American, and European ancestry groups. Initial filtering includes MAF ≥ 0.01%, genotype missingness < 0.01%, HWE p-value > 1 × 10⁻⁶, and biallelic autosomal variants. LD pruning is performed using a 200 kb window and an r² threshold of 0.1. Variants passing the initial filters undergo a second pruning step before GRM calculation and PCA. |
| `02_03_grm_qc_step03.ipynb` | Generates ancestry-specific PLINK genotype files using array variants that passed the second pruning step. These files serve as input for subsequent GRM calculation and PCA. |
| `02_04_grm_qc_step04.ipynb` | Calculates ancestry-specific sparse genetic relationship matrices for the African, American, and European ancestry groups. GRMs are constructed using 5,000 randomly selected markers, a MAF threshold of > 0.01, and a relatedness cutoff of 0.05. The resulting sparse GRMs are used as input for downstream SAIGE-GENE+ association analyses. |

### Execution Order

The notebooks should be executed sequentially, following the order listed in the table above.

### Notes

- These notebooks were developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily.
- These scripts are no longer compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.
