### Set up the targets for the analysis
# 
# 	Targets:
# 		estimate_weights_seperately: 	This target produces the optimal score with weights 
# 						derived seperately for all different traits
#
# 		estimate_weights_together: 	This target derives the seperate weights but
# 						finds the optimal *combination* of them 
# 						to predict the phenotype.
#
# 		real_values:			This target performs the analysis with
# 						real values for the covariates in order to
# 						compare against the predicted genetic values.
#
# 		plot:				This takes all three of the above targets and creates a plot
# 						and diagnostic report.

.PHONY: estimate_weights_seperately estimate_weights_together real_values plot

### These are the main overarching targets
#	
#	These get split into sub targets further down.

estimate_weights_sepertely: 

estimate_weights_together:
	
real_values:

plot: 

### These are the subtargets that make up the pieces for the above.
#
#	
WEIGHTS=/scratch/hpc2862/OH/grs/assoc
plink=/home/hpc2862/Programs/binary_executables/plink2
bfile=/scratch/hpc2862/OH/grs/plink/OHGS_A2_ALL_imp_b_s1


cad_weights.txt hdl_weights.txt ldl_weights.txt tg_weights.txt bmi_weights.txt: 
	Rscript -e 'library(pRs); make_score_profile(assoc = c("$(WEIGHTS)/jointGwasMc_hdl.txt","$(WEIGHTS)/jointGwasMc_ldl.txt","$(WEIGHTS)/jointGwasMc_tg.txt","$(WEIGHTS)/jointGwasMc_bmi.txt","$(WEIGHTS)/cad.add.fixrand.dgc.anno.160614.out.txt"), file = c("hdl_weights.txt", "ldl_weights.txt", "tg_weights.txt", "bmi_weights.txt", "cad_weights.txt"))'

range.txt: 
	Rscript -e 'library(pRs); make_range_file(range = seq(0.01, 0.5, by = 0.01), file = "range.txt")'

cad_p.txt hdl_p.txt ldl_p.txt tg_p.txt bmi_p.txt:
	Rscript -e 'library(pRs); make_score_p(assoc = c("$(WEIGHTS)/jointGwasMc_hdl.txt","$(WEIGHTS)/jointGwasMc_ldl.txt","$(WEIGHTS)/jointGwasMc_tg.txt","$(WEIGHTS)/jointGwasMc_bmi.txt","$(WEIGHTS)/cad.add.fixrand.dgc.anno.160614.out.txt"), file = c("hdl_p.txt", "ldl_p.txt", "tg_p.txt", "bmi_p.txt", "cad_p.txt"))'

done.txt: cad_weights.txt hdl_weights.txt ldl_weights.txt tg_weights.txt bmi_weights.txt range.txt cad_p.txt hdl_p.txt ldl_p.txt tg_p.txt bmi_p.txt
	mkdir cad hdl ldl tg bmi
		
	$(plink) 	--bfile $(bfile) \
			--score cad_weights.txt \
			--q-score-range range.txt cad_p.txt \
			--out cad/cad
	$(plink) 	--bfile $(bfile) \
			--score hdl_weights.txt \
			--q-score-range range.txt hdl_p.txt \
			--out hdl/hdl
	$(plink) 	--bfile $(bfile) \
			--score ldl_weights.txt \
			--q-score-range range.txt ldl_p.txt \
			--out ldl/ldl
	$(plink) 	--bfile $(bfile) \
			--score tg_weights.txt \
			--q-score-range range.txt tg_p.txt \
			--out tg/tg
	$(plink) 	--bfile $(bfile) \
			--score bmi_weights.txt \
			--q-score-range range.txt bmi_p.txt \
			--out bmi/bmi

	touch done.txt
	
estimate_weights_seperately:
	Rscript -e 'library(pRs); estimate_o_seperately(dirs = c("cad", "bmi", "hdl", "ldl", "tg"), n_i = c(130000, 339000, 180000,180000,180000), r_i = c(1, 0.18, -0.252, 0.25, 0.318), h_i = c(0.07, 0.2, 0.1572, 0.1347, 0.1161), h_1 = 0.3)'           


estimate_weights_seperately:
	Rscript -e 'library(pRs); estimate_o_together(dirs = c("cad", "bmi", "hdl", "ldl", "tg"), n_i = c(130000, 339000, 180000,180000,180000), r_i = c(1, 0.18, -0.252, 0.25, 0.318), h_i = c(0.07, 0.2, 0.1572, 0.1347, 0.1161), h_1 = 0.3)'           



### This is the clean target
#	
#	It gets rid of all produced files to start the whole analysis over again.
#
#	Be careful.

clean:
	rm -f *_weights.txt
	rm range.txt
	rm -rf cad hdl ldl tg bmi
	rm *_p.txt
sub:
	qsub -N "plink_analysis" sub.sh
