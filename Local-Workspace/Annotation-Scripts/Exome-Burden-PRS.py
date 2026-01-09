###################################################################################################
# PACKAGES   
###################################################################################################
import pandas as pd 
import numpy as np
import os 

###################################################################################################
# CSQ CODING RANK ORDER 
###################################################################################################

CSQ_CODING_HIGH_IMPACT = [
    "transcript_ablation",
    "splice_acceptor_variant",
    "splice_donor_variant",
    "stop_gained",
    "frameshift_variant",
    "stop_lost",
]

CSQ_CODING_MEDIUM_IMPACT = [
    "start_lost",  # considered high impact in v105, previously medium
    "initiator_codon_variant",  # deprecated
    "transcript_amplification",  # considered high impact in v105, previously medium
    "inframe_insertion",
    "inframe_deletion",
    "missense_variant",
    "protein_altering_variant",  # new in v79
]

CSQ_CODING_LOW_IMPACT = [
    "splice_donor_5th_base_variant",  # new in v105
    "splice_region_variant",  # Considered low impact in v105, previously medium
    "splice_donor_region_variant",  # new in v105
    "splice_polypyrimidine_tract_variant",  # new in v105
    "incomplete_terminal_codon_variant",
    "start_retained_variant",  # new in v92
    "stop_retained_variant",
    "synonymous_variant",
    "coding_sequence_variant",  # considered modifier/non-coding in v105, but keeping as low
    "coding_transcript_variant",  # considered modifier/non-coding in v105, but keeping as low
]

CSQ_NON_CODING = [
    "mature_miRNA_variant",
    "5_prime_UTR_variant",
    "3_prime_UTR_variant",
    "non_coding_transcript_exon_variant",
    "non_coding_exon_variant",  # deprecated
    "intron_variant",
    "NMD_transcript_variant",
    "non_coding_transcript_variant",
    "nc_transcript_variant",  # deprecated
    "upstream_gene_variant",
    "downstream_gene_variant",
    "TFBS_ablation",
    "TFBS_amplification",
    "TF_binding_site_variant",
    "regulatory_region_ablation",
    "regulatory_region_amplification",
    "feature_elongation",  # considered high impact in v105, but keeping as modifier/non-coding
    "regulatory_region_variant",
    "feature_truncation",  # considered high impact in v105, but keeping as modifier/non-coding
    "intergenic_variant",
    "sequence_variant",
]

CSQ_ORDER = (
    CSQ_CODING_HIGH_IMPACT
    + CSQ_CODING_MEDIUM_IMPACT
    + CSQ_CODING_LOW_IMPACT
    + CSQ_NON_CODING
)

CSQ_CODING = CSQ_CODING_HIGH_IMPACT + CSQ_CODING_MEDIUM_IMPACT + CSQ_CODING_LOW_IMPACT

###################################################################################################
# FUNCTIONS 
###################################################################################################

CSQ_ORDER_INDEX = {csq: i for i, csq in enumerate(CSQ_ORDER)}

def most_severe_consequence(csq_string):
    """
    Given a string containing one or more consequences separated by commas (or spaces),
    return the highest-impact consequence according to CSQ_ORDER.
    """
    # Split string into individual consequences
    consequences = [c.strip() for c in csq_string.split(',')]
    
    # Filter to known consequences
    known = [c for c in consequences if c in CSQ_ORDER_INDEX]
    if not known:
        return None  # no known consequences found
    
    # Return the one with the smallest index (highest impact)
    return min(known, key=lambda x: CSQ_ORDER_INDEX[x])

# Assigns categories based on the VEP plugins  
def annotation(row):
    scores = [
        row["SpliceAI_acceptor_gain"],
        row["SpliceAI_acceptor_loss"],
        row["SpliceAI_donor_gain"],
        row["SpliceAI_donor_loss"]
    ]
    m = max(scores)
    if row["LoF"] == "HC":
        return "LOFTEE-HC", 5
    elif m >= 0.8:
        return "SpliceAI-0.8", 4
    elif row["am_pathogenicity"] > 0.564:
        return "AlphaMissense-0.564", 3
    elif row["LoF"] == "LC":
        return "LOFTEE-LC", 2
    elif isinstance(row["Most_Severe_Consequence"], str) and "synonymous_variant" in row["Most_Severe_Consequence"].lower() and m < 0.5:
        return "Synonymous", 1
    else:
        return np.nan, np.nan      

# Format annotations into annotation file for SAIGE-GENE+ 
def annotation_file(Annotations, Variant="#Uploaded_variation", Gene="Gene", Class="Group"): 
    # Group by Gene and aggregate the data
    annotation_table = (Annotations.groupby(Gene)
                        .agg(var=(Variant, ' '.join), anno=(Class, ' '.join))
                        .reset_index())
    # Reshape the data into a long format
    annotation_table = pd.melt(annotation_table, 
                            id_vars=[Gene], 
                            var_name='rownames', 
                            value_name='information')
    # Create a new column 'annotation_file' by combining Gene, rownames, and information
    annotation_table['annotation_file'] = annotation_table[Gene] + ' ' + annotation_table['rownames'] + ' ' + annotation_table['information']
    # Sort the DataFrame by 'Gene' and 'rownames'
    annotation_table = annotation_table.sort_values(by=[Gene, 'rownames'], ascending=[True, False])
    # Write the result 
    return annotation_table[['annotation_file']]

###################################################################################################
# ANNOTATION LOOP 
###################################################################################################

exome = "/Volumes/external_storage/vep_input/exome"
# Path for VEP files 
vep = "/Volumes/external_storage/vep_output"
# Path for SAIGE-GENE+ annoation files 
save = "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Annotations/Exome-Burden-Polygenic-Risk-Score"

# Annotation Loop 
for chrom in range(1,23):
    print(f"Processing chromosome {chrom} ....")
    
    ###############################################################################################
    # Format VEP file  
    ###############################################################################################
    # VEP file name 
    input_file = f"EUR_exome_chr{chrom}.txt"
    # File name after remvoing commented lines 
    filtered_file = f"EUR_exome_chr{chrom}_formatted.txt"  
    
    # Filter out commented lines starting with ## 
    with open(os.path.join(vep, input_file)) as f_in, open(os.path.join(vep, filtered_file), "w") as f_out:
        for line in f_in:
            if not line.startswith("##"):
                f_out.write(line)
    # Read formated file back into python environment                        
    file = pd.read_csv(os.path.join(vep, filtered_file), dtype={15: str}, sep='\t')
    # Read in list of the variants 
    exome_list = pd.read_csv(os.path.join(exome, f"EUR_exome_chr{chrom}_variant_qc.snplist"), names = ["#Uploaded_variation"])
    
    # Check if all exome variants are in the VEP file
    missing_in_exome = file.loc[~file["#Uploaded_variation"].isin(exome_list["#Uploaded_variation"])]
    if not missing_in_exome.empty:
        print(f"Variants missing in exome_list: {len(missing_in_exome)}")
        print(missing_in_exome["#Uploaded_variation"].tolist())
        break 
    
    # Check if all exome variants are in the VEP file
    missing_variants = exome_list.loc[~exome_list["#Uploaded_variation"].isin(file["#Uploaded_variation"].unique())]
    if not missing_variants.empty:
        print(f"Missing variants from VEP file: {len(missing_variants)}")
        print(missing_variants["#Uploaded_variation"].tolist())
        break 

    ###############################################################################################
    # Format into PLINK2 score file
    ###############################################################################################

    # Split the column by ":" and expand into separate columns
    exome_list_split = exome_list["#Uploaded_variation"].str.split(":", expand=True)
    exome_list = pd.concat([exome_list, exome_list_split], axis=1)
    # Optionally, give names to the new columns
    exome_list = exome_list.rename(columns={"#Uploaded_variation":"SNP", 
                            0:"CHR",
                            1:"POS",
                            2:"A2",
                            3:"A1"})
    # Create weight for each rare variant 
    exome_list[["WEIGHT"]] = 1 
    # Reorder columns 
    exome_list = exome_list[["CHR", "POS", "SNP", "A2", "A1", "WEIGHT"]]
    # Save SAIGE-GENE+ annoation files 
    exome_list.to_csv(os.path.join(save, f"Exome-burden-prs-chr{chrom}.txt"), 
                                                     sep='\t', 
                                                     index=False, 
                                                     header=False)
    
###################################################################################################
# FINISH OF SCRIPT  
###################################################################################################
