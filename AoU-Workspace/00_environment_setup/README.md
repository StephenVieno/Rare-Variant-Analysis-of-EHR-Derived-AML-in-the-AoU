# 0 - Workspace Environment Setup

This directory contains Jupyter notebooks for configuring the computational environment within the All of Us (AoU) Research Program Researcher Workbench. These notebooks establish the tools and dependencies required for downstream genomic analyses, including computational workflows using `dsub` and genetic data processing with PLINK 2.

## Notebooks

| Notebook | Description |
|---|---|
| [00_01_environment_dsub.ipynb](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/blob/main/AoU-Workspace/00_environment_setup/00_01_environment_dsub.ipynb) | Configures the `dsub` environment within the AoU Researcher Workbench Jupyter environment. Originally provided by the All of Us Research Program, this notebook installs and configures the components required to submit and manage computational workflows through `dsub`. |
| [00_02_environment_plink2.ipynb](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/blob/main/AoU-Workspace/00_environment_setup/00_02_environment_plink2.ipynb) | Downloads the latest available Linux release of PLINK 2 and uploads the executable to the Google Cloud Platform (GCP) Workspace Bucket. This allows PLINK 2 to be copied directly into individual `dsub` job environments without requiring a separate Docker image, reducing computational overhead and associated costs. The notebook also verifies the executable by checking its version number. |

## Execution Order

The notebooks should generally be executed in the following order:

1. **`00_01_environment_dsub.ipynb`** – Configure the `dsub` environment.
2. **`00_02_environment_plink2.ipynb`** – Download, upload, and verify PLINK 2 for use in subsequent `dsub` jobs.

## Notes

These notebooks were designed for execution within the All of Us Research Program Researcher Workbench prior to its transition to Verily. **They are no longer compatible with the current platform and should be considered historical documentation rather than functional setup instructions.**
