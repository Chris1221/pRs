library(pRs)

cmb <- make_optimal_comorbid_prs(
				 bfile = "/scratch/hpc2862/OH/grs/plink/OHGS_A2_ALL_imp_b_s1",
				 assoc = c("cad_weights_hdl.assoc", 
					   "cad_weights_ldl.assoc",
					   "cad_weights_tg.assoc"),
				 p = seq(0, 0.5, by = 0.01),
				 n_i = c(180000,
					 180000,
					 180000),
				 r_i = c(-0.252,
					0.25,
					0.318),
				 h_i = (0.1572,
					0.1347,
					0.1161),
				 h_1 = 0.30
				 )

write.table(cmb, file = "cmb.txt")
