push: 
	git add -A
	git commit -am "update" 
	git push

ps:
	git pull 
	Rscript -e 'install.packages(".", repos = NULL, type = "source")'
	Rscirpt -e 'library(pRs)'
	cd inst/analysis/optimal_comorbid && $(MAKE) sub	
