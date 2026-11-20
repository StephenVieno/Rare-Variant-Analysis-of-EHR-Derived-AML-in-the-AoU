# 05 – Clonal Hematopoiesis of Indeterminate Potential (CHIP)

## Overview

This directory contains scripts for identifying, filtering, and prioritising genetic variants associated with **clonal hematopoiesis of indeterminate potential (CHIP)** within the broader Rare Variant Analysis of EHR-Derived Acute Myeloid Leukemia (AML) project using the All of Us (AoU) dataset.

The analysis focuses on CHIP-associated somatic variants in genes relevant to clonal hematopoiesis and AML development. Particular attention is given to identifying recurrent hotspot variants and annotating variants in genes of interest to support downstream biological interpretation.

## Scripts

| File | Description |
|---|---|
| `vep_top_genes.py` | Processes Variant Effect Predictor (VEP) annotations to identify CHIP-associated variants affecting genes of interest. |
| `chip_hotspot_filter.py` | Filters CHIP-associated variants based on hotspot-related criteria. |

## Dependencies

The scripts are written in Python.

The specific Python packages, external tools, input formats, and reference files required should be determined from the individual script implementations.

For variant annotation, this workflow incorporates information generated using the Ensembl Variant Effect Predictor (VEP).

- [Ensembl Variant Effect Predictor documentation](https://www.ensembl.org/info/docs/tools/vep/index.html)


