push: 
	git add -A
	git commit -am "update" 
	git push

ps:
	git pull 
	Rscript -e 'install.packages(".", repos = NULL, type = "source")'
	Rscript -e 'library(pRs)'
	cd inst/analysis/optimal_comorbid && $(MAKE) sub	

inst: 
	Rscript -e 'install.packages(".", repos = NULL, type = "source")'
	Rscript -e 'library(pRs)'
