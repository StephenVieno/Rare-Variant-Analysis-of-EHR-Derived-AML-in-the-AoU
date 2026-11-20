# Load packages 
import pandas as pd 

# Filter for CHIP-associated variants and genes using pre-established list of CHIP-associated variatns and genes 
hotspots = pd.read_excel(r"C:\Users\User\Projects\aou\aml\input\41588_2022_1121_MOESM3_ESM.xlsx", 
                   sheet_name="ST2",
                   header=None)

hotspots.columns = hotspots.iloc[1]
hotspots = hotspots.iloc[2:].reset_index(drop=True)

gene_list = hotspots.drop_duplicates(subset=['Gene'])

# CHIP-associated gene list 
gene_list[['Gene']].to_csv(r"C:\Users\User\Projects\aou\aml\output\gene_remove.txt",
                    sep='\t',
                    header=None,
                    index=None)

gene = ['DNMT3A', 'TET2', 'IDH2', 'SRSF2']

hotspots = hotspots[hotspots['Gene'].isin(gene)]

# Reannotated variants 
df = pd.read_csv(r"C:\Users\User\Projects\aou\aml\output\top_genes_reannotated.tsv",
                 sep='\t')

df["id"] = (
    df.iloc[:, 0].astype(str) + ":" +
    df.iloc[:, 1].astype(str) + ":" +
    df.iloc[:, 2].astype(str) + ":" +
    df.iloc[:, 3].astype(str)
)

check = df["id"]

df = df[df["gene"].isin(gene)].copy()

print(f"Check all markers are present: {df['id'].isin(check).all()}")

# Load packages 
import re
import pandas as pd

aa_map = {
    "Ala": "A", "Arg": "R", "Asn": "N", "Asp": "D",
    "Cys": "C", "Glu": "E", "Gln": "Q", "Gly": "G",
    "His": "H", "Ile": "I", "Leu": "L", "Lys": "K",
    "Met": "M", "Phe": "F", "Pro": "P", "Ser": "S",
    "Thr": "T", "Trp": "W", "Tyr": "Y", "Val": "V",
    "Ter": "*", "Xaa": "X"
}

def convert_hgvsp(hgvsp):
    if pd.isna(hgvsp):
        return hgvsp

    # Remove transcript/protein accession and version
    protein = hgvsp.split(":")[-1]

    # Convert three-letter amino acid codes to one-letter codes
    return re.sub(
        r"[A-Z][a-z]{2}",
        lambda m: aa_map.get(m.group(), m.group()),
        protein
    )

df["HGVS"] = df["HGVSp"].apply(convert_hgvsp)

print(df[["HGVSp", "HGVS"]].head())

df["HGVS"] = (
    df["HGVS"]
    .str.replace(r"^p\.", "", regex=True)
    .str.replace(r"^([A-Z]\d+[A-Z]).*", r"\1", regex=True)
)

print(df[["HGVSp", "HGVS"]].head())

keep = df[~(df['HGVS'].isin(hotspots['Amino acid change']))]
keep = keep.drop_duplicates(subset="id", keep="first")

remove = df[(df['HGVS'].isin(hotspots['Amino acid change']))]
remove = remove.drop_duplicates(subset="id", keep="first")

print(f"Check for overlap in keep: {keep['id'].isin(remove['id']).any()}")
print(f"Check for overlap in remove: {remove['id'].isin(keep['id']).any()}")
print(f"Check all markers are present: {check.isin(pd.concat([keep, remove])['id']).all()}")

# List of snps to keep 
keep[['id']].to_csv(r"C:\Users\User\Projects\aou\aml\output\keep.txt",
                    sep='\t',
                    header=None,
                    index=None)

# List of snps to remove (CHIP-associated variants) 
remove[['id']].to_csv(r"C:\Users\User\Projects\aou\aml\output\remove.txt",
                    sep='\t',
                    header=None,
                    index=None)

# Reannotated variants with HGVS 
df.to_csv(r"C:\Users\User\Projects\aou\aml\output\top_genes_reannotated_hgvs.tsv",
                    sep='\t',
                    header=None,
                    index=None)

