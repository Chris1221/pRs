library(pRs)

hdl <- make_optimal_prs(bfile = "/scratch/hpc2862/OH/grs/plink/OHGS_C2_ALL_imp_b_s1.bed", 
			assoc = "cad_weights_hdl.assoc",
			p = seq(0, 0.5, by = 0.01)
			)

ldl <- make_optimal_prs(bfile = "/scratch/hpc2862/OH/grs/plink/OHGS_C2_ALL_imp_b_s1.bed", 
			assoc = "cad_weights_ldl.assoc",
			p = seq(0, 0.5, by = 0.01)
			)

tg <- make_optimal_prs(bfile = "/scratch/hpc2862/OH/grs/plink/OHGS_C2_ALL_imp_b_s1.bed", 
			assoc = "cad_weights_tg.assoc",
			p = seq(0, 0.5, by = 0.01)
			)

save.image(file = "oprs.Rdata")
