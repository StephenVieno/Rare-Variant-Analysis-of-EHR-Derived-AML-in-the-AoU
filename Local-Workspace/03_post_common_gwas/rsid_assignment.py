# Load pacakges 
import gwaslab as gl
import pandas as pd
import glob
import os

# Assign rsIDs to summary statistics files using a reference VCF file
if __name__ == "__main__":
# Path to your folder
    # Path to your folder
    folder_path = "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/Summary-Statistics"
    # Path to your rsID reference folder
    rsid_path = "/Volumes/external_storage/RSID-Reference"
    for chrom in range(1,23):
        # Print status 
        print(f"Processing chromosome {chrom} ....")
        # Now use gwaslab to process the combined summary statistics file
        mysumstats = gl.Sumstats(os.path.join(folder_path,f"EUR_aml_phenotype_plink_chr{chrom}"), fmt="plink2")
        # Perform basic checks
        mysumstats.basic_check()
        # Assign rsIDs to the summary statistics
        mysumstats.assign_rsid( ref_rsid_vcf = os.path.join(rsid_path,"GCF_000001405.40.gz"),
                                chr_dict = gl.get_number_to_NC(build="38"),
                                n_cores = 6)
        # Save the updated summary statistics with assigned rsIDs
        mysumstats.data.to_csv(os.path.join(folder_path,f"EUR_aml_phenotype_rsid_assigned_chr{chrom}"), sep = '\t', index = False)
