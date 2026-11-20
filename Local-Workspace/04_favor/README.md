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




