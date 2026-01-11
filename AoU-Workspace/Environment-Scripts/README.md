# Workspace Environment Scripts  
### Environment-PLINK2.ipynb
- This script first downloads the latest version of PLINK 2 for Linux onto the All of Us Research Program Jupyter platform before uploading it to GCP Workspace Bucket. The uploaded version can then be copied into the working environment of a dsub command. By doing so, the latest release (PLINK v2.0.0-a.7LM, 64-bit Intel, 1 Sep 2025) becomes available for downstream analysis. To update PLINK 2 to a newer release, replace the version being downloaded and repeat the same steps. This method is used instead of running a Docker image, as directly copying PLINK 2 from GCP Workspace Bucket to the working environment is less computationally expensive and more cost-effective. The second half of the script verifies the new PLINK 2 module by checking the version number to confirm that the correct release has been downloaded and is functioning properly.

### Environment-dsub.ipynb
- The following script sets up the dsub environment within the Jupyter workspace of the All of Us (AoU) Research Program. This script was provided by AoU for this purpose. If an error occurs when running the script, it is likely that AoU has updated the command or their dsub system, such as changes to the workspace for the new version of dsub or an equivalent command.

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
