#!/bin/bash 

path=/mnt/c/Users/User/projects/vep
# Maximum parallel jobs
max_jobs=5   
# Function to wait for free slots
function wait_for_slot {
    while [ "$(jobs -rp | wc -l)" -ge "$max_jobs" ]; do
        sleep 2
    done
}

for pop in AFR AMR CSA EAS EUR MID OCE; do
    for chrom in {1..22}; do
        wait_for_slot  # wait if too many parallel jobs

        echo "============================================================="
        echo "Launching chromosome ${chrom} for ${pop} ancestry ...."
        echo "============================================================="

        docker run --rm --cpus=3 \
            --mount type=bind,source=$path/loftee,target=/opt/loftee \
            --mount type=bind,source=$path/cache,target=/opt/cache \
            --mount type=bind,source=$path/input,target=/opt/input \
            --mount type=bind,source=$path/output,target=/opt/output \
            vep_115:loftee_grch38 \
            vep \
            -i /opt/input/${pop}_exome_chr${chrom}.vcf \
            -o /opt/output/${pop}_exome_chr${chrom}.txt \
            --offline \
            --dir_cache /opt/cache \
            --dir_plugins /opt/vep/Plugins/ \
            --assembly GRCh38 \
            --plugin AlphaMissense,file=/opt/cache/AlphaMissense_hg38.tsv.gz,cols=all \
            --plugin SpliceAI,snv=/opt/cache/spliceai_scores.raw.snv.hg38.vcf.gz,indel=/opt/cache/spliceai_scores.raw.indel.hg38.vcf.gz \
            --plugin LoF,loftee_path:/opt/vep/Plugins,gerp_bigwig:/opt/loftee/gerp_conservation_scores.homo_sapiens.GRCh38.bw,human_ancestor_fa:/opt/loftee/human_ancestor.fa.gz \
            --mane_select \
            --fork 3 \
            --biotype \
            --tab \
            --force_overwrite &

    done
done

# Wait for all background jobs to finish
wait

echo "============================================================="
echo "Finished processing all chromosomes ...."
echo "============================================================="
