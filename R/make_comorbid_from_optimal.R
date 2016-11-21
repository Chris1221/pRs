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

make_comborbid_from_optimal <- function(		
					){

}
