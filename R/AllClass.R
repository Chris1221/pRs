#' Polygenic Risk Score Object
#'
#' Contains various characteristics of the polygenic risk score. 
#' @exportClass PRS
#' @export

setClass("PRS",
	 representation(score = "list")
	 )

