# Workspace Environment Scripts  
### Environment-PLINK2.ipynb
- This script first downloads the latest version of PLINK 2 for Linux onto the All of Us Research Program Jupyter platform before uploading it to GCP Workspace Bucket. The uploaded version can then be copied into the working environment of a dsub command. By doing so, the latest release (PLINK v2.0.0-a.7LM, 64-bit Intel, 1 Sep 2025) becomes available for downstream analysis. To update PLINK 2 to a newer release, replace the version being downloaded and repeat the same steps. This method is used instead of running a Docker image, as directly copying PLINK 2 from GCP Workspace Bucket to the working environment is less computationally expensive and more cost-effective. The second half of the script verifies the new PLINK 2 module by checking the version number to confirm that the correct release has been downloaded and is functioning properly.

### Environment-dsub.ipynb
- The following script sets up the dsub environment within the Jupyter workspace of the All of Us (AoU) Research Program. This script was provided by AoU for this purpose. If an error occurs when running the script, it is likely that AoU has updated the command or their dsub system, such as changes to the workspace for the new version of dsub or an equivalent command.


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

- These notebooks are intended to be executed within the All of Us Research Program Researcher Workbench.
- Ensure that the appropriate Workspace Bucket is configured and accessible before executing the notebooks.
- The PLINK 2 executable stored in the Workspace Bucket can be reused across subsequent `dsub` jobs without repeatedly downloading or installing the software.
- AoU may periodically update its Researcher Workbench environment, `dsub` implementation, or supported installation procedures. Consequently, commands in these notebooks may require modification to remain compatible with the current platform.
