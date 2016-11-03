plink=~/repos/aprs/inst/bin/plink 

.all: ldl

ldl:
	# Subset and produce the .raw file
	Rscript ldl.R		
	
	# Use plink to create the profile file.
	$(plink) --bfile /scratch/hpc2862/OH/grs/plink/OHGS_A2_ALL_imp_b_s1 \
		--score ~/repos/aprs/data-raw/ldl_0.05.raw \
		--out ~/repos/aprs/data-raw/ldl
