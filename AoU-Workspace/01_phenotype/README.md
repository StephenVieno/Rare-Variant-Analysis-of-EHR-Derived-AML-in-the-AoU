# 1 – Phenotype Scripts

This directory contains Jupyter notebooks for defining and characterizing the electronic health record (EHR)-derived acute myeloid leukemia (AML) phenotype in the All of Us (AoU) Research Program. These scripts generate phenotype files for downstream rare-variant association analyses, calculate relevant demographic and clinical variables, and evaluate phenotype distributions and timing of AML diagnoses.

## Notebooks

| Notebook | Description |
|---|---|
| `01_00_observation_period.ipynb` | Calculates age and the observation period for individuals in the AoU Research Program. Age is defined as age at the most recent EHR encounter, while the observation period is measured between the first and last EHR encounters and converted from days to years. |
| `01_01_aml_phenotype_file.ipynb` | Generates the primary SAIGE-GENE+ phenotype file by integrating exome sample quality control results, ancestry-specific principal components (PCs), age, sex, and case–control status. Individuals are restricted to those passing exome quality control and having available EHR data. Quantitative covariates are standardized. |
| `01_01_aml_phenotype_file_counts.ipynb` | Calculates sample counts for the AML phenotype file. |
| `01_02_aml_phenocodes_plot.ipynb` | Generates age-stratified visualizations of the phenotype code distributions used to define AML cases, enabling assessment of EHR phenotype prevalence across the age spectrum. |
| `01_03_aml_phenotype_time_to_event.ipynb` | Generates a time-to-event phenotype file for EHR-defined AML. The earliest EHR corresponding to AML is considered the event, with time-to-event calculated from both birth and the first recorded EHR encounter. |
| `01_04_aml_phenotype_time_to_event_with_covariates..ipynb` | Generates a time-to-event phenotype file for EHR-defined AML incorporating additional exposure-related covariates, including documented benzene exposure, smoking status, and exposure to alkylating agents. Alkylating agent exposure is included only when documented before the first recorded AML diagnosis. |
| `01_05_aml_deprivation_index_file.ipynb` | Generates the phenotype file for the deprivation index analysis by integrating exome sample quality control results, ancestry-specific PCs, age, sex, and case–control status. Quantitative covariates, including the deprivation index, are standardized. |
| `01_06_aml_deprivation_index_data.ipynb` | Processes the deprivation index data used in the AML phenotype analysis. |
| `01_07_aml_deprivation_index_plot.ipynb` | Generates age-stratified visualizations of the phenotype code distributions used to define AML cases in the deprivation index cohort. |
| `01_08_biosample_collection_age.ipynb` | Calculates age at biosample collection for individuals in the AoU Research Program. |
| `01_09_aml_biosample_age_file.ipynb` | Generates the AML biosample age file for downstream analyses. |
| `01_10_diagnosis_age.ipynb` | Calculates age at the time of AML diagnosis using the available EHR data. |
| `01_11_aml_diagnosis_age_file.ipynb` | Generates the AML diagnosis age file for downstream analyses. |
| `01_12_diagnosis_interval.ipynb` | Calculates the interval between relevant diagnosis dates in the AML phenotype data. |

## Notes

- Some notebooks were developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily.
- Some scripts are no longer compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.
