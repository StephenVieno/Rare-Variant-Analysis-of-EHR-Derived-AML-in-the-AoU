# 05 – GAUSS Gene Set Association Analysis

This directory contains Jupyter notebooks for performing gene set association analyses using the Generalized Association of Variant Sets (GAUSS) method. The analysis evaluates the enrichment of AML-associated genes across predefined gene sets from Gene Ontology (GO), Kyoto Encyclopedia of Genes and Genomes (KEGG), and the Molecular Signatures Database (MSigDB).

## Notebooks

| **Notebook** | **Description** |
|---|---|
| `05_01_aml_gauss.ipynb` | Performs GAUSS gene set association analyses using gene sets from Gene Ontology (GO), Kyoto Encyclopedia of Genes and Genomes (KEGG), and the Molecular Signatures Database (MSigDB). MSigDB gene sets are filtered to retain those relevant to acute myeloid leukemia (AML). The notebook also generates visualizations summarizing the final gene set association results. |

## Notes

- Four CPUs should be allocated to enable parallel processing during GAUSS analysis.
- This notebook was developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily.
- This script is no longer compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.
