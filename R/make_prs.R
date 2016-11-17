#' Construct a simple PRS and optionally return the association with a phenotype.
#'
#' To construct an optimal PRS see \code{make_optimal_prs()} and to make a comorbid PRS see \code{make_comorbid_prs()}.
#'
#' All input takes the form of PLINK files. If your input is in a different format, please convert it beforehand. This program requires binary format input for performance reasons. We also recommend clumping SNPs or some other method for removing LD between markers. See the vignette for assistance on this.
#'
#' @param bfile Base file name of the binary file set used for the analysis. See details for construction and instructions.
#' @param assoc File name and path to the assoc file with the beta and P values used to construct the score. 
#' @param p P value threshold to cut off the score.
#' @param pheno (optional) Vector or file path to phenotype to use for association analysis. This is required by other functions but this function by default just returns the score so you can do the association yourself.
#'
#' @import futile.logger
#' @importFrom dplyr %>% select select_
#' @importFrom data.table fread
#' @importFrom assertthat assert_that
#' 
#' @return (Currently) A data frame with three columns: FID, IID, and the generated score. 
#'
#' @export

make_prs <- function(bfile,
		     assoc,
		     p,
		     pheno
		){
	
	# Checking to make sure that files exist and everything is in order
	assert_that(file.exists(paste0(bfile, ".bed")))
	assert_that(file.exists(paste0(bfile, ".bim")))
	assert_that(file.exists(paste0(bfile, ".fam")))
	assert_that(file.exists(assoc))
	assert_that(is.numeric(p))
	assert_that(file.exists(pheno))

	# Read in SNPs and align against the .assoc file
	# 	to ensure that they are in the right order.
	#	
	#	This is really slow, I know.	
	#	In a perfect world I would do all this in rcpp 
	
	assoc <- fread(assoc, h = T)
	bim <- fread(paste0(bfile, ".bim"), h = T)[,2]
	fam <- fread(paste0(bfile, ".fam"), h = T)[,2]



	# See what kind of effect size is present.	
	possible_beta_names <- c("Beta", "beta", "b", "B", "BETA", "OR", "or", "odds ratio")
	beta_name <- possible_beta_names[possible_beta_names %in% colnames(assoc)]
		
	# See what kind of P value is present
	possible_p_names <- c("P", "p", "p-value", "p_value", "P-value")
	p_name <- possible_p_names[possible_p_names %in% colnames(assoc)]

	# NSE for select
	assoc %<>% select_("SNP", beta_name, p_name)

	# Make common names
	colnames(assoc) <- c("SNP", "BETA", "P")
	colnames(bim) <- c("SNP")

	# Merge together on basis of SNPs and keep the right order
	ordered <- merge(bim, assoc, all.x = T, all.y = F, sort = F)		

	# Now since this is in the correct order and has the right SNPs
	# 	First replace all the NAs (SNPs not in the assoc)
	#	with 0. This effectively eliminates them from the score
	#	since they will not contribute to the output. 
	#
	#	Save the number and return it in the output object.
	n_na <- sum(is.na(ordered$P))

	#	replace all the NA with 0
	ordered$P[is.na(ordered$P)] <- 0
	ordered$BETA[is.na(ordered$BETA)] <- 0

	# At this point we have the ordered object. 
	# 	Now we want to assign all betas with a P value 
	#	greater than or equal to input p to 0
	#
	#	At later stages this will be a loop that goes through 
	#	each state and gives a different score.
	#
	#	but I think that I can still use the same base function.

	ordered$BETA[ordered$P > p] <- 0

	# This will be different later on.
	#
	#	This produces the following matrix
	#
	#		Weights 
	#	    |---------------	
	#	    |
	#	SNPs|
	#	    |
	#	    |
	weights <- as.matrix(ordered$BETA)

	bed <- paste0(bfile, ".bed")
	nsnp = nrow(weights)
	n = nrow(fam) 

	# Call cpp function to create prs
	# 
	#	see src/prs.cpp for full details
	#	or ?prs
	s <- prs(bed, F, n, weights) 

	# Create score output with FID and IID from fam
	score <- cbind(fam[, 1:2], as.vector(s))

	# Return the straight score (no assoc).
	#	Later make this into an S4 object
	#	with more details. 
	#
	#	i.e. the n_na above and others such as
	#		- the P value of assoc
	#		- the R2 of the score
	return(score)

}
