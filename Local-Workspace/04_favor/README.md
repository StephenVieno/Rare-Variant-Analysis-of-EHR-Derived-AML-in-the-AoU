# 04 – FAVOR Variant Annotation

## Overview

This directory contains scripts and workflow components used for variant annotation and processing with the **Functional Annotation of Variants (FAVOR)** framework as part of the All of Us (AoU) Acute Myeloid Leukemia (AML) rare-variant analysis project.

The scripts support variant verification, dataset partitioning, annotation processing, and computational job submission for downstream rare-variant analyses.

## Scripts

| Script | Language | Purpose |
|---|---|---|
| `eur_check_snplist_in_favor.py` | Python | Checks SNP availability in the FAVOR annotation dataset against the study variant list. |
| `split_annotate.r` | R | Splits variant datasets into smaller subsets and performs the associated annotation-processing steps. |
| `split_annotate_submission_v8.sh` | Bash | Coordinates and submits the split annotation workflow using the AoU v8 environment. |


## Requirements

| Dependency | Purpose |
|---|---|
| Python 3 | Execution of the SNP verification script |
| R | Variant dataset splitting and annotation processing |
| FAVOR | Functional annotation resources |
| All of Us Researcher Workbench | AoU-specific computational environment and data access |
| Computational resources | Processing and annotation of large variant datasets |

Additional package dependencies, execution parameters, and environment-specific configurations are defined within the individual scripts.

## Notes

- The workflow is designed to support large-scale variant processing.
- The submission script targets the AoU v8 environment; compatibility should be verified before use with other AoU data releases.
- Input/output paths and computational resource requirements should be checked before execution.
- The FAVOR annotation resource files are not included in this directory.

## Project Information

| Field | Details |
|---|---|
| Project | [Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU](https://github.com/StephenVieno/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU) |
| Directory | `Local-Workspace/04_favor/` |
| Author | [Stephen Vieno](https://github.com/StephenVieno) |
