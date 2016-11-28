#!/bin/bash
#$ -S /bin/bash
#$ -q abaqus.q
#$ -l qname=abaqus.q
#$ -cwd
#$ -V
#$ -l mf=192G
#$ -j y
#$ -o /home/hpc2862/repos/pRs/inst/analysis/plink_analysis/sub_log.txt
#!/bin/bash

cd /home/hpc2862/repos/pRs/inst/analysis/plink_analysis

make make_scores 

