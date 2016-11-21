.ALL: analsyis

cad_weights_hdl.assoc cad_weights_ldl.assoc cad_weights_tg.assoc: replace_weights.R
	Rscript $<

clean: 
	rm cad_weights_*.assoc
