###################################################################################################
# PACKAGES   
###################################################################################################
import pandas as pd 
import numpy as np
import os 

###################################################################################################
# FUNCTIONS 
###################################################################################################

# Assigns categories to missense variants based on the VEP plugins  
def missense(row):
    if row["REVEL"] > 0.5 and row["am_pathogenicity"] > 0.564:
        return "REVEL-0.5-AlphaMissense-0.564", 5
    elif row["am_pathogenicity"] > 0.564:
        return "AlphaMissense-0.564", 4
    elif row["REVEL"] > 0.5:
        return "REVEL-0.5", 3
    elif isinstance(row["Consequence"], str) and "missense_variant" in row["Consequence"].lower():
        return "Missense", 2
    elif row["IMPACT"] == "MODERATE": 
        return "MODERATE-IMPACT", 1
    else:
        return np.nan, np.nan      

# Assigns categories to splice variants based on the VEP plugins              
def splice(row):
    scores = [
        row["SpliceAI_acceptor_gain"],
        row["SpliceAI_acceptor_loss"],
        row["SpliceAI_donor_gain"],
        row["SpliceAI_donor_loss"]
    ]
    m = max(scores)
    if m > 0.9:
        return "SpliceAI-0.9", 5
    elif m > 0.8:
        return "SpliceAI-0.8", 4 
    elif m > 0.7:
        return "SpliceAI-0.7", 3
    elif m > 0.6:
        return "SpliceAI-0.6", 2
    elif m > 0.5:
        return "SpliceAI-0.5", 1
    else:
        return np.nan, np.nan      
    
# Assigns categories to loss of function variants based on the VEP plugins   
def lof(row):
    if row["LoF"] == "HC":
        return "LOFTEE-HC", 3
    elif row["LoF"] == "LC":
        return "LOFTEE-LC", 2
    elif row["IMPACT"] == "HIGH": 
        return "HIGH-IMPACT", 1
    else:
        return np.nan, np.nan

# Assigns categories to synonymous variants
def synonymous(row):
    if isinstance(row["Consequence"], str) and "synonymous_variant" in row["Consequence"].lower():
        return "Synonymous"
    else:
        return np.nan      

# Format annotations into annotation file for SAIGE-GENE+ 
def annotation_file(Annotations, Variant="#Uploaded_variation", Gene="Gene", Class="Class"): 
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
save = "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Annotations/Single-Class-Annotation-Files"

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
    # Filter transcripts 
    ###############################################################################################
    # Filter for protein_coding variants 
    file = file[file['BIOTYPE'].str.contains("protein", case=False, na=False)]
    # Filter for MANE Select transcripts 
    file = file[file["MANE"] == "MANE_Select"]
    
    # Check for protein coding varinats 
    if not (file['BIOTYPE'] == "protein_coding").all():
        print("Presence of non protein coding variants after filterting .....")
        break 
    
    # Check for MANE Select transcript 
    if not (file['MANE'] == "MANE_Select").all():
        print("Presence of non MANE Select transcripts after filterting .....")
        break 
    
    ###############################################################################################
    # Format missense  
    ###############################################################################################
    # Format vep missense plugins annotations columns 
    file["REVEL"] = pd.to_numeric(file["REVEL"].replace("-", 0))
    file["am_pathogenicity"] = pd.to_numeric(file["am_pathogenicity"].replace("-", 0))
    
    ###############################################################################################
    # Format splice 
    ###############################################################################################
    # Expand Splice AI predictions 
    file = file.join(file["SpliceAI_pred"].str.split(r"|", expand=True).fillna(0))
    # Rename Splice AI columns 
    file = file.rename(columns = {1:"SpliceAI_acceptor_gain",
                            2:"SpliceAI_acceptor_loss",
                            3:"SpliceAI_donor_gain",
                            4:"SpliceAI_donor_loss"})
    # Convert columns to numeric 
    cols = [
        "SpliceAI_acceptor_gain", 
        "SpliceAI_acceptor_loss",
        "SpliceAI_donor_gain",
        "SpliceAI_donor_loss",
    ]
    file[cols] = file[cols].apply(pd.to_numeric, errors="coerce")
    
    ###############################################################################################
    # Assingment functions: Assign annotations and rankings (score) based on plugins 
    ###############################################################################################
    # Synonymous function 
    file["Synonymous"] = file.apply(synonymous, axis=1)
    # Missense function 
    file[["Missense", "Missense-Score"]] = file.apply(missense, axis=1, result_type="expand")
    # Splice function 
    file[["Splice", "Splice-Score"]] = file.apply(splice, axis=1, result_type="expand")
     # Loss-of-Function function 
    file[["Loss-of-Function", "LoF-Score"]] = file.apply(lof, axis=1, result_type="expand")
    
    ###############################################################################################
    # Check annotations 
    ###############################################################################################
    
    # Check missense assignments 
    if not (file[file["Missense-Score"] == 5]["REVEL"].min() > 0.5): 
        print("Erorr: Missense-Score ....")
        break 
    # Check missense assignments 
    if not (file[file["Missense-Score"] == 5]["am_pathogenicity"].min() > 0.564): 
        print("Erorr: Missense-Score ....")
        break 
    # Check missense assignments 
    if not (file[file["Missense-Score"] == 4]["am_pathogenicity"].min() > 0.564): 
        print("Erorr: Missense-Score ....")
        break 
    # Check missense assignments 
    if not (file[file["Missense-Score"] == 3]["REVEL"].min() > 0.5): 
        print("Erorr: Missense-Score ....")
        break 
    # Check missense assignments 
    if not (file[(file["Missense-Score"] == 2)
                 & file["Consequence"].astype(str).str.lower().str.contains("missense_variant")].any().any()):
        print("Erorr: Missense-Score ....")
        break
    # Check missense assignments 
    if not (file.loc[file["Missense-Score"] == 1, "IMPACT"].eq("MODERATE").all()):
        print("Error: Missense-Score ....")
        break 
  
    # Check splice assignments 
    if not (file.loc[file["Splice-Score"] == 5, cols].max().min() > 0.9):
        print("Erorr: Splice-Score ....")
        break
     # Check splice assignments 
    if not (file.loc[file["Splice-Score"] == 4, cols].max().min() > 0.8):
        print("Erorr: Splice-Score ....")
        break
     # Check splice assignments 
    if not (file.loc[file["Splice-Score"] == 3, cols].max().min() > 0.7):
        print("Erorr: Splice-Score ....")
        break
    if not (file.loc[file["Splice-Score"] == 2, cols].max().min() > 0.6):
        print("Erorr: Splice-Score ....")
        break
     # Check splice assignments 
    if not (file.loc[file["Splice-Score"] == 1, cols].max().min() > 0.5):
        print("Erorr: Splice-Score ....")
        break
    
    # Check loss-of-function assignments 
    if not (file.loc[file["LoF-Score"] == 3, "Loss-of-Function"].eq("LOFTEE-HC").all()):
        print("Erorr: LoF-Score ....")
        break 
    # Check loss-of-function assignments 
    if not (file.loc[file["LoF-Score"] == 2, "Loss-of-Function"].eq("LOFTEE-LC").all()):
        print("Erorr: LoF-Score ....")
        break 
    # Check loss-of-function assignments 
    if not (file.loc[file["LoF-Score"] == 1, "IMPACT"].eq("HIGH").all()):
        print("Error: LoF-Score ....")
        break 

    ###############################################################################################
    # Sort into SAIGE-GENE+ annotation files 
    ###############################################################################################
    # Filter for synonymous 
    synonymous_subclass = file[file["Synonymous"] == "Synonymous"]
    # Remove duplicates for synonymous 
    synonymous_subclass = synonymous_subclass.drop_duplicates(subset=["#Uploaded_variation"], keep="first")
    
    # Filter for missense  
    missense_subclass = file.dropna(axis=0, how='all', subset= ["Missense"])
    # Remove duplicates for missense  
    missense_subclass = (
        missense_subclass.sort_values("Missense-Score", ascending=False)   
            .drop_duplicates(subset=["#Uploaded_variation"], keep="first")
    )
    # Filter for splice   
    splice_subclass = file.dropna(axis=0, how='all', subset= ["Splice"])
    # Remove duplicates for splices  
    splice_subclass = (
        splice_subclass.sort_values("Splice-Score", ascending=False)   
            .drop_duplicates(subset=["#Uploaded_variation"], keep="first")
    )
    # Filter for loss-of-function    
    lof_subclass = file.dropna(axis=0, how='all', subset= ["Loss-of-Function"])
    # Remove duplicates for loss-of-function     
    lof_subclass = (
        lof_subclass.sort_values("LoF-Score", ascending=False)   
            .drop_duplicates(subset=["#Uploaded_variation"], keep="first")
    )
    # Check for duplicates in synonymous class
    if synonymous_subclass["#Uploaded_variation"].duplicated().any(): 
        print("Presence of duplicates in synonymous class ....")
        break
    # Check for duplicates in missense class
    if missense_subclass["#Uploaded_variation"].duplicated().any(): 
        print("Presence of duplicates in missense class ....")
        break
    # Check for duplicates in splice class
    if splice_subclass["#Uploaded_variation"].duplicated().any(): 
        print("Presence of duplicates in splice class ....")
        break
    # Check for duplicates in loss-of-function class
    if lof_subclass["#Uploaded_variation"].duplicated().any(): 
        print("Presence of duplicates in loss-of-function class ....")
        break
    
    ###############################################################################################
    # Format into SAIGE-GENE+ annoation files 
    ###############################################################################################
    
    # Format into SAIGE-GENE+ annotation file for synonymous
    synonymous_annotation = annotation_file(synonymous_subclass, 
                                          Variant="#Uploaded_variation",
                                          Gene="Gene", 
                                          Class="Synonymous")
    # Format into SAIGE-GENE+ annotation file for missense
    missense_annotation = annotation_file(missense_subclass, 
                                        Variant="#Uploaded_variation",
                                        Gene="Gene", 
                                        Class="Missense")
    # Format into SAIGE-GENE+ annotation file for splice
    splice_annotation = annotation_file(splice_subclass, 
                                      Variant="#Uploaded_variation",
                                      Gene="Gene", 
                                      Class="Splice")
    # Format into SAIGE-GENE+ annotation file for loss-of-function
    lof_annotation = annotation_file(lof_subclass, 
                                     Variant="#Uploaded_variation",
                                     Gene="Gene", 
                                     Class="Loss-of-Function")
    # Save synonymous SAIGE-GENE+ annoation files 
    synonymous_annotation.to_csv(os.path.join(save, f"synonymous_annotation_chr{chrom}.txt"), 
                                                     sep='\t', 
                                                     index=False, 
                                                     header=False)
    # Save missense SAIGE-GENE+ annoation files 
    missense_annotation.to_csv(os.path.join(save, f"missense_annotation_chr{chrom}.txt"), 
                                                     sep='\t', 
                                                     index=False, 
                                                     header=False)
    # Save splice SAIGE-GENE+ annoation files 
    splice_annotation.to_csv(os.path.join(save, f"splice_annotation_chr{chrom}.txt"), 
                                                     sep='\t', 
                                                     index=False, 
                                                     header=False)
    # Save loss-of-function SAIGE-GENE+ annoation files 
    lof_annotation.to_csv(os.path.join(save, f"lof_annotation_chr{chrom}.txt"), 
                                                     sep='\t', 
                                                     index=False, 
                                                     header=False)
    
###################################################################################################
# FINISH OF SCRIPT  
###################################################################################################





