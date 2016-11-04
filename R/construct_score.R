#' @title Construct a PRS
#' 
#' @description Given input genetic files and association statistics, generate one of a number of polygenic risk scores. See \code{mode}. Tries to guess between plink input and Oxford format.
#'
#' @details This is helper code to construct a simple PRS in R. Note that it is currently unoptimized, meaning that it is currently implimented in R and not RcppArmadillo as it will be in the future. 
#' First it reads in.
#'
#' @param file Basename for genetic files (i.e. ${file}.ped ${file}.map). These must be unzipped. If non-standard, please specify seperately.
#' @param mode One of c("weighted", "unweighted", "additive"). For more details see \code{details}.
#'
#' @importFrom assertthat assert_that
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
	flog.trace("Using R to read for now, can't figure out the cpp")
	
	# Read in using R
	if(!is.null(file)) { # if base is specified

	# Specify map and ped paths through the base
		map <- paste0(file, ".map")
		ped <- paste0(file, ".ped")

	} # END map/ped.

	# if the file was null then map and ped are already specified.

	map <- fread(map, h = T)
	ped <- fread(ped, h = T)




}
