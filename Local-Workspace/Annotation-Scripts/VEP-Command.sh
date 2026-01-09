#!/bin/bash 

# Run loop for each chromosome 
for chrom in {1..22}; do 
# Report message: "start annotating chromosome" 
echo "==============================================="
echo "Processing chromosome ${chrom} ...."
echo "==============================================="
# Set number of CPUs 
cpus=4

# Run vep on docker image 
# Implement AlphaMissense, REVEL, SpliceAI, and LOFTEE
docker run -it --rm --cpus=$cpus \
    --mount type=bind,source=/Volumes/external_storage/loftee_cache,target=/opt/loftee_cache \
    --mount type=bind,source=/Volumes/external_storage/vep_cache,target=/opt/vep_cache \
    --mount type=bind,source=/Volumes/external_storage/vep_input,target=/opt/input \
    --mount type=bind,source=/Volumes/external_storage/vep_output,target=/opt/output \
    vep_115:loftee_grch38 \
    vep \
    -i /opt/input/EUR_exome_chr${chrom}.vcf \
    -o /opt/output/EUR_exome_chr${chrom}.txt \
    --offline \
    --dir_cache /opt/vep_cache \
    --dir_plugins /opt/vep/Plugins/ \
    --assembly GRCh38 \
    --plugin AlphaMissense,file=/opt/vep_cache/AlphaMissense_hg38.tsv.gz,cols=all \
    --plugin REVEL,file=/opt/vep_cache/new_tabbed_revel_grch38.tsv.gz \
    --plugin SpliceAI,snv=/opt/vep_cache/spliceai_scores.raw.snv.hg38.vcf.gz,indel=/opt/vep_cache/spliceai_scores.raw.indel.hg38.vcf.gz \
    --plugin LoF,loftee_path:/opt/vep/Plugins,gerp_bigwig:/opt/loftee_cache/gerp_conservation_scores.homo_sapiens.GRCh38.bw,human_ancestor_fa:/opt/loftee_cache/human_ancestor.fa.gz \
    --mane_select \
    --fork $cpus \
    --biotype \
    --tab \
    --force_overwrite

# Check that alll containers and netowrks are removed 
# Ensure that loop does not overload memory on local device 
docker container prune -f 
docker network prune -f
# Report message: "finsihed annotating chromosome" 
echo "==============================================="
echo "Finished processing chromosome ${chrom} ...."
echo "==============================================="
done 
# Finsih loop 
echo "==============================================="
echo "Finished processing all chromosomes ...."
echo "==============================================="
