#!/bin/bash

# Set environment path 
stats=/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/Summary-Statistics
# Set path to MAGMA files directory
files=/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/MAGMA
# Set path to MAGMA installation
magma=/Users/stephenvieno/MAGMA
# Make magma executable
chmod +x $magma/magma

# Remove existing snploc and pval files if they exist
rm -rf $files/snploc.txt
rm -rf $files/pval.txt

# Loop through chromosomes to create snploc and pval files
for chrom in {1..22}; do
awk -F '\t' '$14 != "" && NR>1 {print $14, $2, $3}' \
      $stats/EUR_aml_phenotype_rsid_assigned_chr${chrom}_deprivation_index >> $files/snploc.txt
done 
# Loop through chromosomes to create pval file
for chrom in {1..22}; do
awk -F '\t' '$14 != "" && NR>1 {print $14, $9}' \
      $stats/EUR_aml_phenotype_rsid_assigned_chr${chrom}_deprivation_index >> $files/pval.txt
done 

for iteration in {0..10}; do
      echo "Running iteration with upstream=${upstream} and downstream=${downstream}"
      # Set upstream and downstream window sizes
      upstream=$((0 + 10 * iteration))
      downstream=$((0 + 5 * iteration))
      # Annotate genes using snploc file
      $magma/magma \
            --annotate window=${upstream},${downstream} \
            --snp-loc $files/snploc.txt \
            --gene-loc $magma/NCBI38.gene.loc \
            --out $files/aml_upstream${upstream}_downstream${downstream}_deprivation_index
      # Run gene analysis
      $magma/magma \
      --bfile $magma/g1000_eur \
      --pval $files/pval.txt N=169970 \
      --gene-annot $files/aml_upstream${upstream}_downstream${downstream}_deprivation_index.genes.annot \
      --out $files/aml_upstream${upstream}_downstream${downstream}_deprivation_index
      # Run gene set analysis with msigdb
      $magma/magma \
      --gene-results $files/aml_upstream${upstream}_downstream${downstream}_deprivation_index.genes.raw \
      --set-annot $magma/msigdb.v2025.1.Hs.entrez.gmt \
      --out $files/aml_msigdb_upstream${upstream}_downstream${downstream}_deprivation_index

done 

