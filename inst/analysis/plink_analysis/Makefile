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

make_scores: cad_weights.txt hdl_weights.txt ldl_weights.txt tg_weights.txt bmi_weights.txt range.txt cad_p.txt hdl_p.txt ldl_p.txt tg_p.txt bmi_p.txt
	$(plink) 	--bfile $(bfile) \
			--score cad_weights.txt \
			--q-score-range range.txt cad_p.txt \
			--out cad/cad


### This is the clean target
#	
#	It gets rid of all produced files to start the whole analysis over again.
#
#	Be careful.

clean:
	rm -f *_weights.txt
	rm range.txt
