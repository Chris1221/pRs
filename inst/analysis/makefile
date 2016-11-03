plink=~/repos/aprs/inst/bin/plink 

.all: ldl

ldl:
	# Subset and produce the .raw file
	Rscript ldl.R		
	
	# Use plink to create the profile file.
	$(plink) --bfile /scratch/hpc2862/OH/grs/plink/OHGS_A2_ALL_imp_b_s1 \
		--score ~/repos/aprs/data-raw/ldl_0.05.raw \
		--out ~/repos/aprs/data-raw/ldl

hdl:
	# Subset and produce the .raw file
	Rscript hdl.R		
	
	# Use plink to create the profile file.
	$(plink) --bfile /scratch/hpc2862/OH/grs/plink/OHGS_A2_ALL_imp_b_s1 \
		--score ~/repos/aprs/data-raw/hdl_0.05.raw \
		--out ~/repos/aprs/data-raw/hdl

tg:
	# Subset and produce the .raw file
	Rscript tg.R		
	
	# Use plink to create the profile file.
	$(plink) --bfile /scratch/hpc2862/OH/grs/plink/OHGS_A2_ALL_imp_b_s1 \
		--score ~/repos/aprs/data-raw/tg_0.05.raw \
		--out ~/repos/aprs/data-raw/tg



