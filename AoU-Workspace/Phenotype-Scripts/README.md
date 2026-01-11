# Phenotype Scripts 
### AML-Phenotype-File.ipynb
- This script creates the phenotype file for SAIGE-GENE+. It integrates several inputs, including EUR-like exome sample quality control results, ancestry-specific PCs, and age and sex files. Only individuals who pass exome quality control are retained in the SAIGE-GENE+ phenotype file. Case–control status is assigned by providing a list of person IDs for individuals designated as cases; all remaining individuals are assigned as controls. The script also restricts the dataset to individuals who have electronic health record data. All quantitative covariates are standardized to have a mean of 0 and a standard deviation of 1. Because more samples passed exome quality control than ACAF quality control in this analysis, this phenotype file will also be used for the ACAF analysis, with samples failing ACAF quality control excluded at a later stage.

### AML-Deprivation-Index.ipynb
- This script creates the phenotype file for SAIGE-GENE+. It integrates several inputs, including EUR-like exome sample quality control results, ancestry-specific PCs, and age and sex files. Only individuals who pass exome quality control are retained in the SAIGE-GENE+ phenotype file. Case–control status is assigned by providing a list of person IDs for individuals designated as cases; all remaining individuals are assigned as controls. The script also restricts the dataset to individuals who have electronic health record data. All quantitative covariates including the deprivation index are standardized to have a mean of 0 and a standard deviation of 1. Because more samples passed exome quality control than ACAF quality control in this analysis, this phenotype file will also be used for the ACAF analysis, with samples failing ACAF quality control excluded at a later stage.

### AML-Phenotype-Time-To-Event.ipynb
- This script creates a time-to-event phenotype file for electronic health record–defined acute myeloid leukemia. The earliest electronic health record corresponding to acute myeloid leukemia is considered the event. Time-to-event was calculated both from birth and from the date of the earliest electronic health record.

### AML-Phenotype-Time-To-Event-With-Covariates.ipynb
- This script creates a time-to-event phenotype file for electronic health record–defined acute myeloid leukemia. The earliest electronic health record corresponding to acute myeloid leukemia is considered the event. Time-to-event was calculated both from birth and from the date of the earliest electronic health record. Covariates include documented benzene exposure, smoking status, and exposure to alkylating agents. Additionally, exposure to alkylating agents was assigned only if the electronic health record occurred before the first record of acute myeloid leukemia.

### Observation-Period.ipynb
- The script calculates both the age and the observation period for all individuals in the AoU. Age is defined as the age at the most recent electronic health record encounter, while the observation period is measured from the first to the last electronic health record. The duration in days is then converted to years by dividing by 365.25.

# Phenotype Plots 
### AML-Phenocodes-Plot.ipynb
- This notebook generates age-stratified visualizations of phenotype code distributions used to define AML cases, enabling assessment of EHR phenotype prevalence across the age spectrum.

### AML-Deprivation-Index-Plot.ipynb
- This notebook generates age-stratified visualizations of phenotype code distributions used to define AML cases (in the deprviation index cohort), enabling assessment of EHR phenotype prevalence across the age spectrum.

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
Set-Based or Single Variant SAIGE-GENE+
```
