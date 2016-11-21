library(pRs)

cad <- "~/cad.add.fixrand.dgc.anno.160614.out.txt"
hdl <- "/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_HDL.txt"
ldl <- "/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_LDL.txt"
tg <- "/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_TG.txt"

replace_weights(assoc1 = hdl, 
	       assoc2 = cad,
	       file = "/home/hpc2862/repos/pRs/inst/analysis/optimal_comorbid/cad_weights_hdl.assoc")

replace_weights(assoc1 = ldl, 
	       assoc2 = cad,
	       file = "/home/hpc2862/repos/pRs/inst/analysis/optimal_comorbid/cad_weights_ldl.assoc")

replace_weights(assoc1 = tg, 
	       assoc2 = cad,
	       file = "/home/hpc2862/repos/pRs/inst/analysis/optimal_comorbid/cad_weights_tg.assoc")
