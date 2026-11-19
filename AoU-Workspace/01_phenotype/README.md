# 1 – Phenotype Scripts

This directory contains Jupyter notebooks for defining and characterizing the electronic health record (EHR)-derived acute myeloid leukemia (AML) phenotype in the All of Us (AoU) Research Program. These scripts generate phenotype files for downstream rare-variant association analyses, calculate relevant demographic and clinical variables, and evaluate the timing of AML diagnoses relative to biospecimen collection.

## Notebooks

| **Notebook** | **Description** |
|---|---|
| `01_00_observation_period.ipynb` | Calculates age and the observation period for individuals in the AoU Research Program. Age is defined as age at the most recent EHR encounter, while the observation period is calculated as the interval between the first and last recorded EHR encounters and converted from days to years. |
| `01_01_aml_phenotype_file.ipynb` | Generates the primary SAIGE-GENE+ phenotype file by integrating exome sample quality control results, ancestry-specific principal components (PCs), age, sex, and AML case–control status. Individuals are restricted to those passing exome quality control and having available EHR data. Quantitative covariates are standardized. |
| `01_02_aml_phenotype_file_counts.ipynb` | Calculates sample counts for the primary AML phenotype file, including case and control counts. |
| `01_03_aml_phenotype_time_to_event.ipynb` | Generates a time-to-event phenotype file for EHR-defined AML. The earliest recorded AML diagnosis is considered the event, with time-to-event calculated relative to birth and the first recorded EHR encounter. |
| `01_04_aml_phenotype_time_to_event_with_covariates.ipynb` | Generates a time-to-event phenotype file incorporating additional exposure-related covariates, including documented benzene exposure, smoking status, and exposure to alkylating agents. Alkylating agent exposure is included only when documented before the first recorded AML diagnosis. |
| `01_05_aml_deprivation_index_file.ipynb` | Generates the phenotype file for the deprivation index analysis by integrating exome sample quality control results, ancestry-specific PCs, age, sex, and AML case–control status. Quantitative covariates, including the deprivation index, are standardized. |
| `01_06_biosample_collection_age.ipynb` | Calculates age at biospecimen collection for individuals in the AoU Research Program using available biospecimen collection dates and demographic data. |
| `01_07_aml_biosample_age_file.ipynb` | Generates the AML biospecimen collection age phenotype file for downstream association analyses, incorporating age at biospecimen collection and the relevant AML case–control status. |
| `01_08_diagnosis_age.ipynb` | Calculates age at AML diagnosis using the available EHR diagnosis dates and demographic data. |
| `01_09_aml_diagnosis_age_file.ipynb` | Generates the AML diagnosis age phenotype file for downstream association analyses, incorporating age at diagnosis and the relevant AML case–control status. |
| `01_10_diagnosis_interval.ipynb` | Calculates the interval between biospecimen collection and the first recorded AML diagnosis among cases. This analysis characterizes the temporal relationship between biospecimen collection and EHR-based AML ascertainment. |

## Notes

- Some notebooks were developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily.
- Some scripts may no longer be compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.
