
# Load pacakges 
import gwaslab as gl
import pandas as pd
import glob
import os

# Plot manhattan and QQ plots for summary statistics
# Path to your folder
folder_path = "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/Summary-Statistics"
# Path to save plots
save_path = "/Users/stephenvieno/Projects/Rare-Variant-Analysis-of-EHR-Derived-AML-in-the-AoU/Single-Variant-Analysis/Plots"
# Load each file into a list of DataFrames
mysumstats = gl.Sumstats(os.path.join(folder_path,"EUR_aml_phenotype_plink"), fmt="plink2")
# Perform basic checks
mysumstats.basic_check()
# Generate Manhattan and QQ plots
mysumstats.plot_mqq(skip=2, 
                    colors = ["#F5D000FF", "#172869FF"], 
                    cut=8, 
                    anno=True, 
                    mqqratio=2,
                    sig_level_lead=5e-8,
                    save=os.path.join(save_path,"aml-manhattan-qq-plots.png"), 
                    save_args={"dpi":400,"facecolor":"white"})


