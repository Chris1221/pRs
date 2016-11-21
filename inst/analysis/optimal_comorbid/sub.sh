#!/bin/bash
#$ -S /bin/bash
#$ -q abaqus.q
#$ -l qname=abaqus.q
#$ -cwd
#$ -V
#$ -l mf=192G
#$ -j y
#$ -o /home/hpc2862/repos/pRs/sub_log.txt
#!/bin/bash

cd /home/hpc2862/pRs/inst/analysis/optimal_comorbid

make cmb.txt

