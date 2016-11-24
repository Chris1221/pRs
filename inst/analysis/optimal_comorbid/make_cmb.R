library(pRs)

 bfile = "hapmap"
 assoc = c("cad_weights_hdl.assoc", 
	   "cad_weights_ldl.assoc",
	   "cad_weights_tg.assoc")
 p = seq(0, 0.5, by = 0.01)
 n_i = c(180000,
	 180000,
	 180000)
 r_i = c(-0.252,
	0.25,
	0.318)
 h_i = c(0.1572,
	0.1347,
	0.1161)
 h_1 = 0.30

cmb <- make_optimal_comborbid_prs(
				 bfile = bfile,
				 assoc = assoc,
				 p = p,
				 n_i = n_i,
				 r_i = r_i,
				 h_i =h_i,
				 h_1 =  h_1
				 )

save.image("cmb.Rdata")
