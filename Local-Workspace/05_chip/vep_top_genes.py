import pandas as pd 
import numpy as np 

# List of genes of interest
gene = ['ENSG00000119772',
        'ENSG00000168769',
        'ENSG00000182054',
        'ENSG00000161547']

# Functions
def extract(df, gene):
    '''
    Extracts variant information from saige-gene+ annotation table
    df : saige-gene+ annoation table
    gene : list of gene of interest
    '''
    df = df[df[0].str.contains("|".join(gene), na=False)]
    df = df[0].str.split(' ', expand=True)
    df = df.drop(columns=0).T
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)
    return df

# List of variant ids
ids, annotations = [], []

# Loop through each chromosome
for chrom in [2, 4, 15, 17]:
    
    # Local filename
    local_path = rf"C:\Users\User\Projects\aou\aml\input\EUR-HC-annotation-chr{chrom}.txt"

    # Load annotation file
    annotation = pd.read_csv(local_path,
                             sep='\t',
                             header=None)
    # Extract variant infomraiton
    annotation = extract(annotation, gene)
   
    # Append variatn information to list
    ids.append(annotation['var'])
    annotations.append(annotation)

# Concatenate variant information
ids = np.array(pd.concat(ids))
annotations = pd.concat(annotations)

string = annotations['var'].str.split(":", expand=True)

string["vep_input"] = (
    string[0].astype(str).str.replace("^chr", "", regex=True)
    + " "
    + string[1].astype(str)
    + " . "
    + string[2].astype(str)
    + " "
    + string[3].astype(str)
    + " . . ."
)

server = "https://rest.ensembl.org"
endpoint = "/vep/human/region"

headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
}

results = []
loop = 0

import time
import requests
import pandas as pd

# Submit batches of up to 10 variants
for start in range(0, len(string), 10):
    batch = string.iloc[start:start + 10]
    loop += 1

    print(f"Loop {loop} ...")

    payload = {"variants": batch["vep_input"].tolist()}
    url = "https://rest.ensembl.org/vep/human/region"

    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }

    data = None

    # Retry failed requests
    for attempt in range(4):
        try:
            response = requests.post(
                url,
                headers=headers,
                params={
                    "hgvs": 1,
                    "canonical": 1,
                    "mane": 1
                },
                json=payload,
                timeout=120
            )

            print("Status:", response.status_code)

            if response.ok:
                try:
                    data = response.json()
                    break
                except requests.exceptions.JSONDecodeError:
                    print("Invalid JSON response:")
                    print(repr(response.text[:2000]))
            else:
                print("Response body:")
                print(repr(response.text[:2000]))

        except requests.exceptions.RequestException as e:
            print(f"Request error: {e}")

        if attempt < 3:
            wait = 2 ** attempt
            print(f"Retrying in {wait} seconds...")
            time.sleep(wait)

    # Preserve records if all attempts fail
    if data is None:
        print(f"WARNING: Batch {loop} failed after 4 attempts.")

        for variant in batch.to_dict("records"):
            results.append({
                **variant,
                "gene": None,
                "gene_id": None,
                "transcript": None,
                "mane_select": None,
                "biotype": None,
                "HGVSc": None,
                "HGVSp": None,
                "consequence": None
            })

        continue

    # Check response structure and batch alignment
    if not isinstance(data, list) or len(data) != len(batch):
        print(
            f"WARNING: Expected {len(batch)} annotations, "
            f"received {len(data) if isinstance(data, list) else 'non-list data'}."
        )
        print("Response:", repr(data)[:2000])

        # Avoid incorrectly matching annotations to variants
        for variant in batch.to_dict("records"):
            results.append({
                **variant,
                "gene": None,
                "gene_id": None,
                "transcript": None,
                "mane_select": None,
                "biotype": None,
                "HGVSc": None,
                "HGVSp": None,
                "consequence": None
            })

        continue

    for variant, annotation in zip(
        batch.to_dict("records"), data
    ):
        transcript_consequences = annotation.get(
            "transcript_consequences", []
        )

        # Prefer MANE Select, otherwise canonical transcript
        preferred = [
            t for t in transcript_consequences
            if t.get("mane_select")
        ]

        if not preferred:
            preferred = [
                t for t in transcript_consequences
                if t.get("canonical") == 1
            ]

        if not preferred:
            preferred = transcript_consequences

        if not preferred:
            results.append({
                **variant,
                "gene": None,
                "gene_id": None,
                "transcript": None,
                "mane_select": None,
                "biotype": None,
                "HGVSc": None,
                "HGVSp": None,
                "consequence": None
            })
            continue

        for t in preferred:
            results.append({
                **variant,
                "gene": t.get("gene_symbol"),
                "gene_id": t.get("gene_id"),
                "transcript": t.get("transcript_id"),
                "mane_select": t.get("mane_select"),
                "biotype": t.get("biotype"),
                "HGVSc": t.get("hgvsc"),
                "HGVSp": t.get("hgvsp"),
                "consequence": ",".join(
                    t.get("consequence_terms", [])
                )
            })

    time.sleep(0.5)

out = pd.DataFrame(results)

out.to_csv(
    r"C:\Users\User\Projects\aou\aml\output\top_genes_reannotated.tsv",
    sep="\t",
    index=False
)

print(out.head())
