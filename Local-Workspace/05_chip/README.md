# 05 – Clonal Hematopoiesis of Indeterminate Potential (CHIP)

## Overview

This directory contains scripts for identifying, filtering, and prioritising genetic variants associated with **clonal hematopoiesis of indeterminate potential (CHIP)** within the broader Rare Variant Analysis of EHR-Derived Acute Myeloid Leukemia (AML) project using the All of Us (AoU) dataset.

The analysis focuses on CHIP-associated somatic variants in genes relevant to clonal hematopoiesis and AML development. Particular attention is given to identifying recurrent hotspot variants and annotating variants in genes of interest to support downstream biological interpretation.

## Directory Contents

| File | Description |
|---|---|
| `vep_top_genes.py` | Processes Variant Effect Predictor (VEP) annotations to examine and prioritise variants affecting genes of interest. |
| `chip_hotspot_filter.py` | Filters CHIP-associated variants based on hotspot-related criteria to prioritise variants of potential biological and clinical relevance. |


## Analysis Workflow

The scripts support two complementary aspects of CHIP variant analysis:

### 1. CHIP Hotspot Filtering

**Script:** `chip_hotspot_filter.py`

This script supports the identification and prioritisation of CHIP-associated hotspot variants.

Hotspot filtering is important because recurrent somatic mutations in genes associated with clonal hematopoiesis can provide insight into the molecular mechanisms underlying clonal expansion and progression towards hematological malignancies, including AML.

The filtering step is intended to help distinguish potentially relevant recurrent variants from the broader set of identified genetic variants.

### 2. VEP Annotation of Top Genes

**Script:** `vep_top_genes.py`

This script works with Variant Effect Predictor (VEP) annotation data to examine variants affecting genes of interest.

VEP annotations provide information about the predicted consequences of genetic variants, supporting the interpretation and prioritisation of variants identified during the analysis.

This step helps contextualise candidate variants according to their affected genes and predicted functional consequences.

## Relationship to the Overall Project

This directory contributes to the broader investigation of rare genetic variation and its relationship to AML using EHR-derived phenotypes from the All of Us Research Program.

CHIP is particularly relevant to AML research because somatic mutations associated with clonal hematopoiesis can precede the development of hematological malignancies.

The analysis in this directory therefore provides an additional layer of investigation into the genetic characteristics of CHIP and its potential relevance to AML-associated findings.

## Dependencies

The scripts are written in Python.

The specific Python packages, external tools, input formats, and reference files required should be determined from the individual script implementations.

For variant annotation, this workflow incorporates information generated using the Ensembl Variant Effect Predictor (VEP).

- [Ensembl Variant Effect Predictor documentation](https://www.ensembl.org/info/docs/tools/vep/index.html)
- [All of Us Research Program](https://www.researchallofus.org/)

## Usage

Run the scripts from the project environment after preparing the required input files and dependencies.

```bash
python chip_hotspot_filter.py
```

```bash
python vep_top_genes.py
```

The exact command-line arguments, input paths, output locations, and configuration requirements should be verified against the current script implementations.

## Notes

- CHIP-associated variants should be interpreted in the context of their somatic or germline origin.
- Variant hotspot status alone does not establish pathogenicity.
- VEP-predicted consequences represent computational annotations and require appropriate biological interpretation.
- Findings should be considered alongside the project's AML phenotyping and rare variant analysis results.
- Analyses should follow the applicable All of Us data-use and governance requirements.

## References

1. Ensembl Variant Effect Predictor (VEP): https://www.ensembl.org/info/docs/tools/vep/index.html
2. All of Us Research Program: https://www.researchallofus.org/
3. Genomics of clonal hematopoiesis and its association with hematological malignancies.


