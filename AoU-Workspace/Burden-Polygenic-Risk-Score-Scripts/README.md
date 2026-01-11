







AML-Exome-Burden-Analysis.ipynb
This script calculates a rare-variant polygenic risk score based on exome burden. Each exome burden is processed iteratively. The script aggregates chromosome-level exome burden score files to compute the overall exome burden score, including both rare coding and non-coding variation. The resulting sum represents the exome burden polygenic risk score for the exome.

AML-Exome-Burden-Analysis-PRS-Exome.ipynb
This script calculates a rare-variant polygenic risk score based on exome burden. Each exome burden is processed iteratively. The script aggregates chromosome-level exome burden score files to compute the overall exome burden score, including both rare coding and non-coding variation. The resulting sum represents the exome burden polygenic risk score for the exome.



AML-Exome-Burden-Analysis-PRS-Bulk-DGE.ipynb
This script calculates the rare variant polygenic risk score for gene sets derived from bulk RNA-seq differential expression analysis of acute myeloid leukemia. The gene-level polygenic risk score files are first downloaded from the workspace bucket. Each gene set is then processed in a loop. For each gene in a given set, the script identifies the corresponding gene-level polygenic risk score file and adds its value to a running total. The final sum represents the polygenic risk score for the entire gene set.

AML-Exome-Burden-Analysis-PRS-Cox-Regression.ipynb
This script calculates the rare variant polygenic risk score for gene sets derived from bulk RNA-seq cox regression analysis of acute myeloid leukemia. The gene-level polygenic risk score files are first downloaded from the workspace bucket. Each gene set is then processed in a loop. For each gene in a given set, the script identifies the corresponding gene-level polygenic risk score file and adds its value to a running total. The final sum represents the polygenic risk score for the entire gene set.

AML-Exome-Burden-Analysis-PRS-Single-Cell-DGE.ipynb
This script calculates the rare variant polygenic risk score for gene sets derived from single cell RNA-seq differential expression analysis of acute myeloid leukemia. The gene-level polygenic risk score files are first downloaded from the workspace bucket. Each gene set is then processed in a loop. For each gene in a given set, the script identifies the corresponding gene-level polygenic risk score file and adds its value to a running total. The final sum represents the polygenic risk score for the entire gene set.

AML-Exome-Burden-Analysis-PRS-Somatic.ipynb
This script calculates the rare variant polygenic risk score for gene sets derived from GDC somatic mutations. The gene-level polygenic risk score files are first downloaded from the workspace bucket. Each gene set is then processed in a loop. For each gene in a given set, the script identifies the corresponding gene-level polygenic risk score file and adds its value to a running total. The final sum represents the polygenic risk score for the entire gene set.


AML-Exome-Burden-Analysis-Logistic-Regression-Unrelated.ipynb
This script runs a logistic regression for unrelated individuals using the gene-set rare polygenic risk score, the exome burden polygenic risk score, principal components, age, and sex to identify gene sets that harbor rare variants significantly associated with acute myeloid leukaemia.

AML-Exome-Burden-Analysis-Logistic-Regression.ipynb
This script runs a logistic regression using the gene-set rare polygenic risk score, the exome burden polygenic risk score, principal components, age, and sex to identify gene sets that harbor rare variants significantly associated with acute myeloid leukaemia.

AML-Exome-Burden-Analysis-Results.ipynb
