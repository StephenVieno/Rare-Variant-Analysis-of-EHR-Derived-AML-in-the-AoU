# Workspace Environment Setup

This directory contains Jupyter notebooks for configuring the computational environment within the All of Us (AoU) Research Program Researcher Workbench. These scripts establish the necessary tools and dependencies for downstream genomic analyses, including running computational workflows through `dsub` and performing genetic data processing with PLINK 2.

## Notebooks

### 1. `00_01_environment_dsub.ipynb`

- This notebook configures the `dsub` environment within the AoU Researcher Workbench Jupyter environment. The script was originally provided by the All of Us Research Program to facilitate the setup and use of `dsub` for submitting computational jobs.
- It installs and configures the necessary components for submitting and managing computational workflows through the AoU Researcher Workbench.
- If an error occurs during execution, it may reflect changes to the AoU environment, updates to the `dsub` system, or modifications to the installation commands and workspace configuration. In such cases, consult the latest AoU documentation for updated setup instructions.

### 2. `00_02_environment_plink2.ipynb`

- This notebook downloads the latest available PLINK 2 release for Linux within the AoU Researcher Workbench and uploads the executable to the Google Cloud Platform (GCP) Workspace Bucket.
- Storing PLINK 2 in the Workspace Bucket allows the executable to be copied directly into the working environment of individual `dsub` jobs, making it available for downstream genetic data processing and quality control.
- This approach avoids the need to initialize a separate Docker image for PLINK 2, reducing computational overhead and associated costs.
- The notebook also verifies the downloaded executable by checking its version number to confirm that the expected release has been installed successfully.
- To update PLINK 2, modify the download URL to point to the desired release, rerun the notebook, and verify the installed version.

## Execution Order

The notebooks should generally be executed in the following order:

1. **`00_01_environment_dsub.ipynb`** – Configure the `dsub` environment.
2. **`00_02_environment_plink2.ipynb`** – Download, upload, and verify PLINK 2 for use in subsequent `dsub` jobs.

## Notes

**These notebooks were designed to be executed within the All of Us Research Program Researcher Workbench prior to its transition to Verily.**
**These scripts are no longer compatible with the current platform and should be considered historical documentation rather than functional setup instructions.**
- Ensure that the appropriate Workspace Bucket is configured and accessible before executing the notebooks.
- The PLINK 2 executable stored in the Workspace Bucket can be reused across subsequent `dsub` jobs without repeatedly downloading or installing the software.
