EXOME BURDEN LOGISTIC REGRESSION
This script runs a logistic regression for unrelated individuals using the gene-set rare polygenic risk score, the exome burden polygenic risk score, principal components, age, and sex to identify gene sets that harbor rare variants significantly associated with acute myeloid leukaemia.
EXOME BURDEN LOGISTIC REGRESSION
This script runs a logistic regression using the gene-set rare polygenic risk score, the exome burden polygenic risk score, principal components, age, and sex to identify gene sets that harbor rare variants significantly associated with acute myeloid leukaemia.


AML BULK RNA-SEQ DIFFERENTIAL GENE EXPRESSION
This script calculates the rare variant polygenic risk score for gene sets derived from bulk RNA-seq differential expression analysis of acute myeloid leukemia. The gene-level polygenic risk score files are first downloaded from the workspace bucket. Each gene set is then processed in a loop. For each gene in a given set, the script identifies the corresponding gene-level polygenic risk score file and adds its value to a running total. The final sum represents the polygenic risk score for the entire gene set.
