# 04 – FAVOR Variant Annotation

## Overview

This directory contains scripts and workflow components used for variant annotation and processing with the **Functional Annotation of Variants (FAVOR)** framework as part of the All of Us (AoU) Acute Myeloid Leukemia (AML) rare-variant analysis project.

The scripts support variant verification, dataset partitioning, annotation processing, and computational job submission for downstream rare-variant analyses.

## Scripts

| Script | Language | Purpose |
|---|---|---|
| `split_annotate_submission_v8.sh` | Bash | Coordinates and submits the split annotation workflow for FAVOR. |
| `split_annotate.r` | R | Annotates the variants with FAVOR after splitting them into chunks. |
| `eur_check_snplist_in_favor.py` | Python | Checks whether all variants in the variant list are present in the FAVOR annotation output. |


