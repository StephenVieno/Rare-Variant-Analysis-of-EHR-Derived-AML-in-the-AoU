# Local Workspace

This directory contains the local computational workflows, scripts, notebooks, and supporting resources used in the analysis of rare genetic variants associated with EHR-derived acute myeloid leukemia (AML) phenotypes in the All of Us (AoU) Research Program.

## Directory Structure

| Directory | Description |
|:---|:---|
| `00_docker` | Docker configuration and containerized environments for reproducible analyses. |
| `01_vep` | Variant Effect Predictor (VEP) annotation workflows, including functional consequence annotation and plugin-based predictions. |
| `02_gene_set` | Gene-set analyses and single-cell RNA sequencing resources used to investigate the biological context of prioritized genes. |
| `03_post_common_gwas`| Post-GWAS analyses and downstream investigation of common-variant association results. |
| `04_favor` | FAVOR-based variant annotation workflows. |
| `05_chip` | Clonal hematopoiesis of indeterminate potential (CHIP) filtering workflows. |

## Workflow Overview

The local workspace is organized into numbered directories corresponding to the major stages and complementary analyses of the project.

1. **Computational environment:** Configure reproducible software environments using Docker.
2. **Variant annotation:** Annotate genetic variants using VEP and associated plugins.
3. **Gene-set analyses:** Investigate biological pathways and gene-level functional context.
4. **Post-GWAS analyses:** Conduct downstream analyses of common-variant association results.
5. **Functional annotation:** Apply FAVOR annotations to support variant interpretation and prioritization.
6. **CHIP investigation:** Evaluate potential clonal hematopoiesis contributions to observed rare-variant association signals.

## Reproducibility

Each subdirectory contains its own README documenting the relevant analysis, software requirements, and scripts.

The workflows are intended to support reproducibility, transparency, and organization of the computational analyses performed outside the All of Us Researcher Workbench.
