# 00 – Docker Configuration

This directory contains Dockerfiles for building containerized environments used in the local processing and annotation of genetic data. These containers provide the required software dependencies and tools for variant annotation, genomic data conversion, and downstream rare-variant analyses.

## Dockerfiles

| Dockerfile | Description |
|---|---|
| `dockerfile_FAVOR` | Defines a Docker environment for running FAVOR-based variant annotation. |
| `dockerfile_VEP_plugins` | Defines a Docker environment containing the Variant Effect Predictor (VEP) and its associated plugins for functional variant annotation. |
| `dockerfile_gds2bgen` | Defines a Docker environment for converting BGEN files to Genomic Data Structure (GDS) format. |

## Notes

- Each Dockerfile specifies the software dependencies and configuration required for its respective processing workflow.
