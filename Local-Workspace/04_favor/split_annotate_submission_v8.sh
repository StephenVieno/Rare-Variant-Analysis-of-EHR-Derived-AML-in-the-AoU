#!/bin/bash

# This script was modified from the original script provided in the STAARpipeline tutorial to use a Docker image.
# It also uses another modified script, split_annotate.r, which performs variant annotation with FAVOR in chunks, avoiding the need to decompress all files at once.

# [https://github.com/li-lab-genetics/STAARpipeline-Tutorial]

# Root directory 
PROJECT=/mnt/c/Users/User/Projects/favor
# Docker image 
IMAGE=vieno99/favor:v1.0

# Loop through each chromosome 
for CHROM in 2 4 15 17; do
    ##############################################
    # SPLIT: GDS files for each chromosome and FAVOR database information.
    # DATABASE: Untarred FAVOR annotation files. [https://favor.genohub.org/favor-annotator]
    # INPUT: A list of variants for each chromosome in the format:
    #   CHROM-POSITION-REF-ALT
    #   Example: 1-100000-A-G
    # OUTPUT: Directory containing the annotation output files.
    # TEMP: Temporary directory used to store uncompressed database files.
    ##############################################
    SPLIT="$PROJECT/STAARpipeline-Tutorial/FAVORannotator_csv/FAVORdatabase_chrsplit.csv"
    DATABASE="$PROJECT/cache/chr${CHROM}.tar.gz"
    INPUT="$PROJECT/input/chr${CHROM}"
    OUTPUT="$PROJECT/output"
    TEMP="$PROJECT/tmp"

    echo "========================================"
    echo "Chromosome: $CHROM"
    echo "SPLIT:      $SPLIT"
    echo "DATABASE:   $DATABASE"
    echo "INPUT:      $INPUT"
    echo "OUTPUT:     $OUTPUT"
    echo "TEMPORARY:  $TEMP"
    echo "========================================"

    # Create temporary directory
    mkdir -p "$TEMP"

    # Run docker command 
    docker run --rm \
        -v "$PROJECT:/favor" \
        "$IMAGE" \
        Rscript /favor/src/split_annotate.r \
        "/favor/STAARpipeline-Tutorial/FAVORannotator_csv/FAVORdatabase_chrsplit.csv" \
        "/favor/cache/chr${CHROM}.tar.gz" \
        "/favor/input/chr${CHROM}" \
        "/favor/output" \
        "$CHROM" \
        "/favor/tmp" 

    # Delete extracted temporary files
    rm -rf "$TEMP"

done
