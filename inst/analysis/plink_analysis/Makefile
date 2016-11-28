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

cad_weights.txt hdl_weights.txt ldl_weights.txt tg_weights.txt bmi_weights.txt: 
	Rscript -e 'library(pRs); make_score_profile(assoc = c("$(WEIGHTS)/jointGwasMc_hdl.txt","$(WEIGHTS)/jointGwasMc_ldl.txt","$(WEIGHTS)/jointGwasMc_tg.txt","$(WEIGHTS)/jointGwasMc_bmi.txt","$(WEIGHTS)/cad.add.fixrand.dgc.anno.160614.out.txt"), file = c("hdl_weights.txt", "ldl_weights.txt", "tg_weights.txt", "bmi_weights.txt", "cad_weights.txt"))'





### This is the clean target
#	
#	It gets rid of all produced files to start the whole analysis over again.
#
#	Be careful.

clean:
	rm -f *_weights.txt
