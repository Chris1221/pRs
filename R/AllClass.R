#' Polygenic Risk Score Object
#'
#' Contains various characteristics of the polygenic risk score. 
#' @exportClass PRS
#' @export
setClass("PRS",
	 representation(score = "list")
	 )

#' Optimal PRS representation
#'
#' Contains the score and various diagnostics.
#' @exportClass oPRS
#' @export
setClass("oPRS",
	 representation(
		all_scores = "matrix",
		p = "vector",
		optimal_score = "data.frame",
		optimal_p = "numeric",
		optimal_r2 = "numeric",
		nsnp = "numeric"
		)
	 )
