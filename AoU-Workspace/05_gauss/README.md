# GAUSS Pipeline

This directory contains Jupyter notebooks for performing gene set association analyses using the Generalized Association of Variant Sets (GAUSS) method. The analysis evaluates the enrichment of AML-associated genes across predefined gene sets from Gene Ontology (GO), Kyoto Encyclopedia of Genes and Genomes (KEGG), and the Molecular Signatures Database (MSigDB).

## Gene Set Association Analysis

### `05_01_aml_gauss.ipynb`

- This notebook performs GAUSS gene set analysis using genes from Gene Ontology (GO), Kyoto Encyclopedia of Genes and Genomes (KEGG), and the Molecular Signatures Database (MSigDB).
- For MSigDB, gene sets are filtered based on their relevance to acute myeloid leukemia (AML), retaining only those associated with AML for downstream analysis.
- Before executing the analysis, the number of CPUs should be set to 4 to enable parallel processing in GAUSS.
- The second half of the notebook generates visualizations of the final gene set association results.

## Notes

- This notebook was developed for use within the All of Us Research Program Researcher Workbench prior to its transition to Verily.
- This script is no longer compatible with the current platform and should be considered historical documentation rather than functional analysis instructions.
