# Variant Effect Predictor (VEP)

This directory contains scripts for preparing genetic variant data and running functional annotation using the Ensembl Variant Effect Predictor (VEP). These scripts support the annotation of variants using VEP and its associated plugins within the local analysis environment.

## Scripts

| Script | Description |
|---|---|
| `00_format_vep_input.sh` | Formats genetic variant data into the required input format for VEP annotation. |
| `01_vep_command.sh` | Executes VEP for functional annotation of genetic variants using the configured plugins and annotation resources. |

## Notes

- Scripts are intended for use with the Docker environment defined in `00_docker`.
- VEP annotations are used in downstream variant filtering, functional prioritization, and rare-variant association analyses.
