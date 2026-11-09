#!/bin/bash


# Set environment path 
path=/mnt/c/Users/User/projects/vep

for pop in AFR AMR CSA EAS EUR MID OCE; do 
    for chrom in {1..22}; do

# Report message: "start annotating chromosome" 
echo "==============================================="
echo "Processing chromosome ${chrom} for ${pop} ancestry ...."
echo "==============================================="
 
awk -F':' 'BEGIN {
    OFS="\t"; 
    print "#CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO"
}
{
    print substr($1,4), $2, $1 ":" $2 ":" $3 ":" $4, $3, $4, ".", ".", "."
}' $path/exome/${pop}_exome_chr${chrom}_variant_qc.snplist > $path/input/${pop}_exome_chr${chrom}.vcf

# Report message: "finished annotating chromosome" 
echo "==============================================="
echo "Finished processing chromosome ${chrom} for ${pop} ancestry ...."
echo "==============================================="

    done 
done 

# Finish loop 
echo "==============================================="
echo "Finished processing all chromosomes ...."
echo "==============================================="
