#' Construct and return the optimal comorbid PRS based on a list of fixed P value thresholds.  
#'
#' See our pre-print for an introduction to the method.
#'
#' All input takes the form of PLINK files. If your input is in a different format, please convert it beforehand. This program requires binary format input for performance reasons. We also recommend clumping SNPs or some other method for removing LD between markers. See the vignette for assistance on this.
#'
#' @param bfile Vector of base file names of the binary file set used for the analysis. See details for construction and instructions.
#' @param assoc Vector of file names and paths to the assoc files with the beta and P values used to construct the score. 
#' @param p A vector of P value thresholds to test each score at.
#' @param pheno Vector or file path to phenotype to use for association analysis. This defaults to using the phenotype in the .fam file provided, though you can optionally provide a PLINK style phenotype file.
#' @param n_i Vector of the sample sizes used to deduce the effect sizes presented in assoc.
#' @param r_i Vector of the genetic covariance of the comorbid trait with the overall phenotype given in pheno.
#' @param h_i Vector of the heritability of each of the comorbid traits.
#' @param h_1 The chip heritability.
#' @param mode See details. If mode is set to 1, then P value thresholds are estimated seperately for each of the different scores prior to their combination. If mode is set to 2, then P values thresholds are estimated *all together* to create the optimal score. Mode 2 is significantly slower than mode 1 for obvious reasons.
#' @param training The algorithm used to train the scores. Defaults to 10 times cross validation. 
#'
#' @import futile.logger
#' @importFrom dplyr %>% select select_
#' @importFrom data.table fread
#' @importFrom assertthat assert_that
#' @importFrom magrittr %<>% 
#' @return (Currently) A data frame with three columns: FID, IID, and the generated score. 
#'
#' @export

make_optimal_comborbid_prs <- function(bfile,
		     assoc,
		     p,
		     pheno = NULL,
		     n_i,
		     r_i,
		     h_i,
		     h1,
		     mode = 1,
		     training = "cv"
		){

	# Now we have the list of the binary files in bfile
	#	For example
	#		bfile <- c(	
	#			"trait1",
	#			"trait2",
	#			"trait3"
	#			)
	#
	#	So have to loop through the filines in order and
	#		- Align them
	#		- Construct the score
	#		- Store the Score
	#		- (later) iterate through regression models to find the optimal score
	#		- Returnt the S4.
	#		

	# 	Make sure that everythign is the same legnth otherwise 
	#		it doesn't make much sense.
	assert_that(length(n_i) == length(assoc))	
	assert_that(length(h_i) == length(assoc))	
	assert_that(length(r_i) == length(assoc))	

	#	Create an output list which will have each entry as an oPRS objectA
	output <- list()

	#	Loop through all the entries.
	for( i in 1:length(assoc)){


		# Read in SNPs and align against the .assoc file
		# 	to ensure that they are in the right order.
		#	
		#	This is really slow, I know.	
		#	In a perfect world I would do all this in rcpp 

		assoc <- fread(assoc[i], h = T)
		bim <- fread(paste0(bfile, ".bim"), h = F) %>%
			as.data.frame %>%
			select(V2)
		fam <- as.data.frame(fread(paste0(bfile, ".fam"), h = T))



		# See what kind of effect size is present.	
		possible_beta_names <- c("Beta", "beta", "b", "B", "BETA", "OR", "or", "odds ratio")
		beta_name <- possible_beta_names[possible_beta_names %in% colnames(assoc)]
			
		# See what kind of P value is present
		possible_p_names <- c("P", "p", "p-value", "p_value", "P-value")
		p_name <- possible_p_names[possible_p_names %in% colnames(assoc)]

		possible_snp_names <- c("SNP", "rsid", "snp")
		snp_name <- possible_snp_names[possible_snp_names %in% colnames(assoc)]

		# Change the P name to workaround the dash confusion
		colnames(assoc)[colnames(assoc) == p_name] <- "P"

		# NSE for select
		assoc %<>% select_(snp_name, beta_name, "P")

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

		weights <- matrix(nrow = length(ordered$BETA), ncol = length(p))

		# This is super friggen slow
		#	I'll change it soon. 
		for(i in 1:length(p)){
			copy <- ordered
			copy$BETA[ordered$P > p[i]] <- 0
			weights[,i] <- copy$BETA
		}
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

		bed <- paste0(bfile[i], ".bed")
		nsnp = nrow(weights)
		n = nrow(fam) 

		# Call cpp function to create prs
		# 
		#	see src/prs.cpp for full details
		#	or ?prs
		s <- prs(bed, F, n, weights) 

		#colnames(s) <- paste0("S_", p)
		#s <- as.data.frame(s)
		#s$FID = fam[, 1]
		#s$IID = fam[, 2]


		# If pheno is not set
		#	Assume the phenotype in the .fam file 
		#
		#	This is convenient because it ensures people are in the same order
		#	otherwise have to make sure this is the case.
		if(is.null(pheno)){
			
			phen <- fam[,6]	
			
		} else {
		
			flog.fatal("Other phen files not yet handled. Sorry!")
		
		}

		# Loop through all weighting schemes and find the P value and R2.
		#	Store the P values in a P vector
		#	
		#	Store the R2 in a vector
		#
		#	Later on will want to make this into a plot like PRSice.
		
		p_store <- vector()
		r2_store <- vector()

		for(i in 1:ncol(s)){
			
			sum <- summary(lm(phen ~ s[,i]))
			p_store[i] <- sum$coefficients[2,4]	
			r2_store[i] <- sum$"adj.r.squared"
				
		}

		# Not robust to same P values
		#	Change this later.
		optimal_s <- which(p_store == min(p_store))

		output[[i]] <- new("oPRS",
			      all_scores = s,
			      p = p,
			      optimal_score = data.frame(
						FID = fam[,1],
						IID = fam[,2],
						SCORE = s[,optimal_s]
						),
			      optimal_p = p_store[optimal_s],
			      optimal_r2 = r2_store[optimal_s],
			      nsnp = sum(weights[, optimal_s] != 0),
			      n_i = n_i[i],
			      h_i = h_i[i],
			      r_i = r_i[i]
			)
	}	

	# Rather than hard coding this, I'm going to make a seperate function to combine oPRS 

	output <- make_comorbid_from_optimal(output, h_1)

	return(output)		

}
