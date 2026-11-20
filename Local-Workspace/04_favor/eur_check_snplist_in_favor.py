# This script checks that all variants in the QC'd variant list
# are present in the FAVOR annotation file.

# Load packages
import os
import pandas as pd 

# Loop through each chromosome 
for chrom in [2, 4, 15, 17]:
    # Input
    input_file = f'C:\\Users\\User\\Projects\\favor\\exome\\european\\EUR_exome_chr{chrom}_variant_qc.snplist'

    # Output
    output_file = f'C:\\Users\\User\\Projects\\favor\\output\\anno_chr{chrom}_STAARpipeline.csv'

    # Read files
    input_df = pd.read_csv(input_file, names=['VarInfo'])
    output_df = pd.read_csv(output_file)
    
    # Convert AoU variant IDs to the format used by FAVOR
    input_df['VarInfo'] = (
        input_df['VarInfo']
        .str.replace("chr", "")
        .str.replace(":", "-")
    )

    # Check whether all FAVOR variants are present in the AoU variant list
    all_present = output_df['VarInfo'].isin(input_df['VarInfo']).all()

    print(f'chr{chrom}: all variants present = {all_present}')


