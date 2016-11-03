#' @title Construct a PRS
#' 
#' @description Given input genetic files and association statistics, generate one of a number of polygenic risk scores. See \code{mode}. Tries to guess between plink input and Oxford format.
#'
#' @param file Basename for genetic files (i.e. ${file}.ped ${file}.map). These must be unzipped. If non-standard, please specify seperately.
#' @param mode One of c("weighted", "unweighted", "additive"). For more details see \code{details}.
#'
#' @importFrom assert_that
#' @import futile.logger
#'
#' @useDynLib aprs
#'
#' @return An S4 score object.

construct_score <- function(
			    file = NULL,
			    ped = NULL,
			    map = NULL,
			    assoc = NULL,
			    mode
			    ){
	
	flog.threshold(INFO)
	flog.info("Checking inputs for inconsistencies")

	# Make sure that either
	#	file is defined (i.e. a file base is provided)
	# or 
	#	both ped and map are provided
	# in order to have all information.
	assert_that(!is.null(file) || ( !is.null(ped) && !is.null(map) ) )

	# Make sure that some kind of weight is provided if 
	# 	mode == "weighted" || "comorbid"
	# Not neccessary if 
	#	mode == "unweighted"
	assert_that(!is.null(assoc) || mode == "unweighted")


	flog.info("Reading in and processing.")

	#include <Rcpp.h>



}
