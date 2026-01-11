# Bulk RNA-Seq Quality Control Scripts 
### RNA-Seq-QC-Normal-Tissue.R
- Performs quality control on RNA-Seq data from normal tissue samples in bone marrow. Ensures data integrity before downstream analyses.
### RNA-Seq-QC-Primary-Tumour-Bone-Marrow.R
- Performs quality control on RNA-Seq data from primary tumor samples in bone marrow. Ensures data integrity before downstream analyses.
### RNA-Seq-QC-Primary-Tumour-Peripheral-Blood.R
- Performs quality control on RNA-Seq data from primary tumor samples in peripheral blood. Ensures data integrity before downstream analyses.

# Cox Regression Gene Expression Scripts
### RNA-Seq-Normal-Tissue-Cox-Regression.R
- Performs Cox proportional hazards analysis on RNA-Seq data from normal tissue in the bone marrow. Evaluates the impact of gene expression on survival outcomes.
### RNA-Seq-Primary-Tumour-Bone-Marrow-Cox-Regression.R
- Performs Cox proportional hazards analysis on RNA-Seq data from primary tumor samples in bone marrow. Evaluates the impact of gene expression on survival outcomes.
### RNA-Seq-Primary-Tumour-Peripheral-Blood-Cox-Regression.R
- Performs Cox proportional hazards analysis on RNA-Seq data from primary tumor samples in peripheral blood. Evaluates the impact of gene expression on survival outcomes.

```markdown
Bulk RNA-Seq Quality Control Scripts (Normal Tissue, Bone Marrow, or Peripheral Blood) 
   |
   v
Cox Regression Gene Expression Scripts (Normal Tissue, Bone Marrow, or Peripheral Blood)
   |
   v
Cox Regression Gene-sets -> Rare Variant Polygenic Risk Score Analysis 
```

# Differential Gene Expression Scripts 
### RNA-Seq-Differential-Expression-PCA.R
- Conducts principal component analysis (PCA) on RNA-Seq expression data. Used to visualize sample clustering, detect batch effects, and explore patterns in the dataset prior to downstream analyses.
### RNA-Seq-Differential-Expression-Analysis.R
- Performs differential gene expression analysis on RNA-Seq data. Includes normalization, filtering, and statistical testing to identify genes with significant expression differences between normal tissue and primary tumor samples in bone marrow.

```markdown
RNA-Seq-Differential-Expression-PCA.R
   |
   v
RNA-Seq-Differential-Expression-Analysis.R
   |
   v
Differential Gene Expression Gene-sets -> Rare Variant Polygenic Risk Score Analysis 
```
