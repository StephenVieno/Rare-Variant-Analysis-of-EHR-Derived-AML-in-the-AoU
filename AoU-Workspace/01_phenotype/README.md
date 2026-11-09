# Phenotype Scripts

This directory contains Jupyter notebooks for defining and characterizing the electronic health record (EHR)-derived acute myeloid leukemia (AML) phenotype in the All of Us (AoU) Research Program. These scripts generate phenotype files for downstream rare-variant association analyses, calculate relevant demographic and clinical variables, and evaluate phenotype distributions and timing of AML diagnoses.

## Phenotype File Generation and Characterization

### `01_01_aml_phenotype_file.ipynb`

- This notebook creates the phenotype file for SAIGE-GENE+. It integrates several inputs, including EUR-like exome sample quality control results, ancestry-specific principal components (PCs), and age and sex files.
- Only individuals who pass exome quality control are retained in the SAIGE-GENE+ phenotype file. Case–control status is assigned using a list of person IDs designated as cases, with all remaining individuals assigned as controls.
- The dataset is further restricted to individuals with available electronic health record data. All quantitative covariates are standardized to have a mean of 0 and a standard deviation of 1.
- Because more samples passed exome quality control than ACAF quality control in this analysis, this phenotype file is also used for the ACAF analysis, with samples failing ACAF quality control excluded at a later stage.

### `01_05_aml_deprivation_index_file.ipynb`

- This notebook creates the phenotype file for the deprivation index analysis. It follows the same general approach as the primary AML phenotype file, integrating EUR-like exome sample quality control results, ancestry-specific PCs, age, sex, and case–control status.
- The dataset is restricted to individuals who pass exome quality control and have available electronic health record data.
- All quantitative covariates, including the deprivation index, are standardized to have a mean of 0 and a standard deviation of 1.
- Because more samples passed exome quality control than ACAF quality control in this analysis, this phenotype file is also used for the ACAF analysis, with samples failing ACAF quality control excluded at a later stage.

### `01_06_aml_deprivation_index_data.ipynb`

- This notebook processes the deprivation index data used in the AML phenotype analysis.

### `01_08_biosample_collection_age.ipynb`

- This notebook calculates age at biosample collection for individuals in the AoU Research Program.

### `01_09_aml_biosample_age_file.ipynb`

- This notebook generates the AML biosample age file for downstream analyses.

### `01_10_diagnosis_age.ipynb`

- This notebook calculates age at the time of AML diagnosis using the available electronic health record data.

### `01_11_aml_diagnosis_age_file.ipynb`

- This notebook generates the AML diagnosis age file for downstream analyses.

### `01_12_diagnosis_interval.ipynb`

- This notebook calculates the interval between relevant diagnosis dates in the AML phenotype data.

## Time-to-Event Analyses

### `01_00_observation_period.ipynb`

- This notebook calculates both age and the observation period for individuals in the AoU Research Program.
- Age is defined as age at the most recent electronic health record encounter, while the observation period is measured from the first to the last electronic health record encounter.
- The observation period, initially calculated in days, is converted to years by dividing by 365.25.

### `01_03_aml_phenotype_time_to_event.ipynb`

- This notebook creates a time-to-event phenotype file for EHR-defined AML. The earliest electronic health record corresponding to AML is considered the event.
- Time-to-event is calculated both from birth and from the date of the earliest electronic health record.

### `01_04_aml_phenotype_time_to_event_with_covariates..ipynb`

- This notebook creates a time-to-event phenotype file for EHR-defined AML, incorporating additional exposure-related covariates.
- The earliest electronic health record corresponding to AML is considered the event. Time-to-event is calculated both from birth and from the date of the earliest electronic health record.
- Covariates include documented benzene exposure, smoking status, and exposure to alkylating agents.
- Exposure to alkylating agents is assigned only when the corresponding electronic health record occurs before the first recorded AML diagnosis.

## Phenotype Visualizations

### `01_02_aml_phenocodes_plot.ipynb`

- This notebook generates age-stratified visualizations of the phenotype code distributions used to define AML cases. These plots enable assessment of EHR phenotype prevalence across the age spectrum.

### `01_07_aml_deprivation_index_plot.ipynb`

- This notebook generates age-stratified visualizations of the phenotype code distributions used to define AML cases in the deprivation index cohort, enabling assessment of EHR phenotype prevalence across the age spectrum.

## Notes

- **Some of these notebooks were developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily.**
- **Some of these scripts are no longer compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.**
