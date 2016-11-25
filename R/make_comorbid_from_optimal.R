#' Construct a comorbid PRS from a list of oPRS objects. 
#'
#' @param bfile Vector of base file names of the binary file set used for the analysis. See details for construction and instructions.
#' @param assoc Vector of file names and paths to the assoc files with the beta and P values used to construct the score. 
#' @param p A vector of P value thresholds to test each score at.
#' @param pheno Vector or file path to phenotype to use for association analysis. This defaults to using the phenotype in the .fam file provided, though you can optionally provide a PLINK style phenotype file.
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

make_comorbid_from_optimal <- 
	function(
		oPRS,
		h_1,
		phen
	){

	# To make the comorbid score (I know latex doesnt render):
	# 	
	#	$$ \hat{S}_{acm} = \sum^c_{i=1} \sqrt{n_i} r_i \sqrt{\frac{h_i}{h_1}} \hat{S}_i $A
	# 
	# 	We just take the vectors of the scores (assuming that the IDs are in the correct order). 
	#		multiply them by their respective parameters
	#		and sum them up into the comorbid score.

	# Make sure that the legnth is more than 1, otherwise it doesnt make much sense.
	assert_that(length(oPRS) > 1)

	SCORE <- numeric(nrow(oPRS[[1]]@optimal_score))


	for(i in length(oPRS)) {

		# Just to make it easier to type.
		s <- oPRS[[i]] 

		SCORE <- SCORE +
			( 
			 sqrt(s@n_i) * 
			 s@r_i *
			 sqrt( s@h_i / h_1 ) *
			 s@optimal_score$SCORE
		 	)

	}

	output <- data.frame(
			FID = oPRS[[1]]@optimal_score$FID,
			IID = oPRS[[1]]@optimal_score$IID,
			SCORE = SCORE,
			PHEN = phen
			)
	
	return(output)


}
