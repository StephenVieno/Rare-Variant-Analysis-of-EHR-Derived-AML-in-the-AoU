#!/bin/bash


# Set environment path 
path=/Volumes/external_storage/vep_input

for chrom in {1..22}; do

# Report message: "start annotating chromosome" 
echo "==============================================="
echo "Processing chromosome ${chrom} ...."
echo "==============================================="
 
awk -F':' 'BEGIN {
    OFS="\t"; 
    print "#CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO"
}
{
    print substr($1,4), $2, $1 ":" $2 ":" $3 ":" $4, $3, $4, ".", ".", "."
}' $path/exome/EUR_exome_chr${chrom}_variant_qc.snplist > $path/EUR_exome_chr${chrom}.vcf

# Report message: "finsihed annotating chromosome" 
echo "==============================================="
echo "Finished processing chromosome ${chrom} ...."
echo "==============================================="

done 

# Finsih loop 
echo "==============================================="
echo "Finished processing all chromosomes ...."
echo "==============================================="
