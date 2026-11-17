# All of Us Research Program Workspace

## Overview

This directory contains the computational workflows used to conduct genetic association analyses of acute myeloid leukemia (AML) within the **All of Us (AoU) Research Program** Researcher Workbench.

The analyses integrate electronic health record (EHR)-derived AML phenotypes with whole-genome sequencing (WGS) data to investigate associations between genetic variation and AML susceptibility. The workflows include phenotype definition, genetic relatedness estimation, variance ratio estimation, gene-based association testing, gene-set analyses, common-variant GWAS, and a series of sensitivity analyses addressing potential confounding from clonal hematopoiesis of indeterminate potential (CHIP).

The numbered folders organize the analysis into individual stages, with each folder containing the corresponding notebooks and scripts.

## Repository Structure

| Folder | Description |
|---|---|
| `00_environment_setup` | Environment setup and configuration for conducting analyses within the AoU Researcher Workbench. |
| `01_phenotype` | Definition and identification of AML cases and controls using EHR-derived phenotypes. |
| `02_sparse_grm` | Construction and quality control of the sparse genetic relationship matrix (GRM) used to account for genetic relatedness in association analyses. |
| `03_variance_ratio` | Estimation of variance ratios required for computationally efficient mixed-model association testing. |
| `04_gene_based` | Primary gene-based rare-variant association analyses investigating the relationship between protein-coding variation and AML susceptibility. |
| `05_gauss` | GAUSS-based association analyses. |
| `06_lovo` | Leave-one-variant-out (LOVO) analyses to investigate the contribution of individual variants to gene-level association signals. |
| `07_gene_set` | Gene-set association analyses to investigate the enrichment of genetic associations across predefined biological pathways and gene sets. |
| `08_common_gwas` | Genome-wide association analyses of common genetic variants associated with AML. |
| `09_covariate_check` | Assessment of covariate selection and adjustment in the association models. |
| `10_biospecimen_collection` | Sensitivity analyses incorporating biospecimen collection timing relative to the recorded AML diagnosis. |
| `11_age_matching` | Age-matching analyses to assess the robustness of genetic association findings while accounting for differences in age between cases and controls. |
| `12_exclude_chip` | Identification and exclusion of variants associated with clonal hematopoiesis of indeterminate potential (CHIP) from subsequent association analyses. |
| `13_gene_based_ex_chip` | Gene-based association analyses repeated after excluding CHIP-associated variants. |
| `14_gene_set_ex_chip` | Gene-set association analyses repeated after excluding CHIP-associated variants. |
| `15_staar` | Gene-based rare-variant association analyses using the Scalable and Accurate Implementation of Generalized mixed model (STAAR) framework. |

## Analysis Workflow

The numbered folders are organized to reflect the general progression of the analytical workflow.

### 1. Data preparation and phenotype definition

- **`00_environment_setup`**: Configure the computational environment within the AoU Researcher Workbench.
- **`01_phenotype`**: Define AML cases and controls using EHR-derived diagnostic information.

### 2. Mixed-model preparation

- **`02_sparse_grm`**: Generate and assess the sparse genetic relationship matrix.
- **`03_variance_ratio`**: Estimate variance ratios for downstream mixed-model association testing.

### 3. Primary genetic association analyses

- **`04_gene_based`**: Conduct gene-based rare-variant association analyses.
- **`05_gauss`**: Perform GAUSS-based association analyses.
- **`06_lovo`**: Investigate individual variant contributions to gene-level association signals.
- **`07_gene_set`**: Investigate rare-variant burden associations across predefined gene sets and biological pathways.
- **`08_common_gwas`**: Conduct common-variant genome-wide association analyses.

### 4. Sensitivity analyses

- **`09_covariate_check`**: Evaluate the influence of covariate selection and adjustment.
- **`10_biospecimen_collection`**: Investigate the association between rare variants and the timing of biospecimen collection.
- **`11_age_matching`**: Assess the robustness of associations following age matching.

### 5. CHIP-related sensitivity analyses

Given the potential contribution of clonal hematopoiesis to genetic association signals in AML, additional analyses investigate the influence of CHIP-associated variants.

- **`12_exclude_chip`**: Identify and exclude CHIP-associated variants.
- **`13_gene_based_ex_chip`**: Repeat gene-based association analyses following CHIP-associated variant exclusion.
- **`14_gene_set_ex_chip`**: Repeat gene-set association analyses following CHIP-associated variant exclusion.

### 6. STAAR analyses

- **`15_staar`**: Conduct additional rare-variant association analyses using the STAAR framework.

## Execution

All analyses are designed to be conducted within the All of Us Researcher Workbench environment.

The numbered directories provide a logical organization of the analysis stages. Where analyses depend on outputs generated by preceding stages, those outputs should be generated and verified before proceeding.

**Important:** The AoU Researcher Workbench is a controlled research environment. Access to the underlying genomic and EHR data requires appropriate AoU authorization. The repository contains analysis code and workflows rather than unrestricted copies of participant-level data.

**Importantt:** Certain scripts require a corresponding Docker image to be built and published to a publicly accessible repository on Docker Hub. These Docker images can then be pulled and executed using the `dsub` command on virtual machines (VMs) within the All of Us Researcher Workbench.

## Reproducibility and Data Availability

- All analyses are conducted using data accessed through the All of Us (AoU) Researcher Workbench.
- Some scripts included in this workspace were developed prior to the All of Us Research Program's transition to Verily.
- As a result, these scripts may require modifications to ensure compatibility with the current AoU Researcher Workbench environment.

## Acknowledgements

This work uses data from the **All of Us Research Program**.

For further information about the program, visit the [All of Us Research Program](https://allofus.nih.gov/).

For the complete analysis repository, see:

[**Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU**](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU)

