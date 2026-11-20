# 1 – Variant Effect Predictor (VEP)

This directory contains scripts for preparing genetic variant data, performing functional annotation using the Ensembl Variant Effect Predictor (VEP), and generating annotation-based variant subsets for downstream rare-variant burden and polygenic risk score (PRS) analyses.

The pipeline uses VEP and its associated plugins and annotation resources within the local Docker-based analysis environment.

## Scripts

| Script | Description |
|---|---|
| `format_vep_input.sh` | Formats genetic variant data into the required input format for VEP annotation. |
| `vep_command.sh` | Executes VEP functional annotation using the configured plugins and annotation resources. |
| `gene_check_annotations.py` | Performs gene-level checks on VEP annotation output. |
| `single_class_annotations.py` | Extracts or processes annotations belonging to a specified functional class. |
| `hc_annotations.py` | Processes high-confidence (HC) variant annotations. |
| `lovo_annotations.py` | Processes leave-one-variant-out variant annotations. |
| `uva_lovo_annotations.py` | Processes leave-one-variant-out annotations using the UVA-specific workflow. |
| `hc_burden_prs.py` | Generates high-confidence annotation-based variant sets for burden and PRS analyses. |
| `exome_burden_prs.py` | Prepares exome-wide variant data for downstream burden and PRS analyses. |

## Environment and Dependencies

- Scripts are intended to run within the Docker environment defined in `00_docker`.
- VEP annotations rely on the configured VEP plugins and associated annotation resources.
- Python scripts require their respective Python dependencies and input files.

## Downstream Applications

The annotation outputs support functional variant prioritization, high-confidence loss-of-function filtering, gene-level rare-variant burden analyses, exome-wide burden analyses, and polygenic risk score (PRS) analyses.
