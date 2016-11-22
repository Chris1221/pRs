.ALL: analsyis

cad_weights_hdl.assoc cad_weights_ldl.assoc cad_weights_tg.assoc: replace_weights.R
	Rscript $<

cmb.txt: make_cmb.R
	Rscript $<

clean: 
	rm cad_weights_*.assoc

sub:
	qsub -N "sub" sub.sh 

oprs: 
	Rscript optimal_scores.R
