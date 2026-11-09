#!/usr/bin/env Rscript

### This script works in conjunction with the Docker-based
### split_annotate_submission and FAVOR annotation scripts.

##########################################################################
# INPUT
##########################################################################

args <- commandArgs(trailingOnly = TRUE)

##############################################
# file_DBsplit : Path to the split genome files
# database     : Directory containing the database files
# input_dir    : Directory containing the input files
# output_dir   : Directory for the output files
# chr          : Chromosome to be processed
# tmp_dir      : Temporary directory for intermediate files
##############################################

# Script paths 
file_DBsplit <- args[1]
database     <- args[2]
input_dir    <- args[3]
output_dir   <- args[4]
chr          <- as.integer(args[5])
tmp_dir      <- args[6]

# Path within the untarred annotation directory (do not change)
DB_path <- "/n/holystore01/LABS/xlin/Lab/xihao_zilin/FAVORDB"

cat("CHROMOSOME:", chr, "\n")
cat("INPUT:", input_dir, "\n")
cat("DATABASE SPLIT INFORMATION:", file_DBsplit, "\n")
cat("FAVOR DATABASE:", database, "\n")
cat("OUTPUT:", output_dir, "\n")

###########################################################################
# MAIN FUNCTION
###########################################################################


### Annotation channel (subset)
anno_colnum <- c(1,8:12,15,16,19,23,25:36)

### Chromosome number
## Annotate (seperate)
DB_info <- read.csv(file_DBsplit,header=TRUE)
chr_splitnum <- sum(DB_info$Chr==chr)

### Modified from the original script
### Allows processing of individual chunks
for(kk in 1:chr_splitnum)
{

    print(paste("PROCESSING CHUNK", kk))

    archive_file <- paste0(
        "n/holystore01/LABS/xlin/Lab/xihao_zilin/FAVORDB/chr",
        chr, "_", kk, ".csv"
    )

    extracted_file <- paste0(
        tmp_dir, "/chr", chr, "_", kk, ".csv"
    )

    cmd <- paste0(
        "tar -xzf ", shQuote(database),
        " --strip-components=7",
        " -C ", shQuote(tmp_dir),
        " ", shQuote(archive_file)
    )

    print(cmd)
    status <- system(cmd)

    if(status != 0) {
        stop("ERROR extracting: ", archive_file)
    }

    if(!file.exists(extracted_file)) {
        stop("Extracted file not found: ", extracted_file)
    }

    join_cmd <- paste0(
        "xsv join --left VarInfo ",
        shQuote(paste0(
            input_dir,
            "/variant_info_chr", chr,
            "_block", kk, ".csv"
        )),
        " variant_vcf ",
        shQuote(extracted_file),
        " > ",
        shQuote(paste0(
            output_dir,
            "/anno_chr", chr,
            "_block", kk, ".csv"
        ))
    )

    print(join_cmd)
    status <- system(join_cmd)

    if(status != 0) {
        stop("ERROR during xsv join for chunk ", kk)
    }

    system(paste0("rm -rf ", extracted_file))

}

## Merge information together
Anno <- paste0(output_dir,"/anno_chr",chr,"_block",seq(1:chr_splitnum),".csv ")
merge_command <- paste0("xsv cat rows ",Anno[1])

for(kk in 2:chr_splitnum)
{
merge_command <- paste0(merge_command,Anno[kk])
}

merge_command <- paste0(merge_command,"> ",output_dir,"/anno_chr",chr,".csv")

system(merge_command)

## Subset annotation information
anno_colnum_xsv <- c()
for(kk in 1:(length(anno_colnum)-1))
{
anno_colnum_xsv <- paste0(anno_colnum_xsv,anno_colnum[kk],",")
}
anno_colnum_xsv <- paste0(anno_colnum_xsv,anno_colnum[length(anno_colnum)])
system(paste0("xsv select ",anno_colnum_xsv," ",output_dir,"/anno_chr",chr,".csv > ",output_dir,"/anno_chr",chr,"_STAARpipeline.csv"))

##########################################################################
# END OF SCRIPT 
##########################################################################
