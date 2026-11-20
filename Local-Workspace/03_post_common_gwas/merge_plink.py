# Load pacakges 
import pandas as pd
import glob
import os

# Merge all chromosome summary statistics files into single master file 
# Path to your folder
folder_path = "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/Summary-Statistics"
# Get all files in the folder (change extension as needed)
all_files = glob.glob(os.path.join(folder_path, "EUR_aml_phenotype_plink_chr*"))  # or "*.tsv", "*.txt", etc.
# Load each file into a list of DataFrames
df_list = [pd.read_csv(f, sep = '\t') for f in all_files]
# Combine all DataFrames into one
df = pd.concat(df_list, ignore_index=True)
# Save the combined DataFrame to a new file if needed
df.to_csv(os.path.join(folder_path,"EUR_aml_phenotype_plink"),sep ='\t', index = False)
