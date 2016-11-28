#' Make a range file for plink
#' 
#' @param range Specify the range as a vector.
#' @param file The output location.
#'
#' @importFrom dplyr %>%
#' 
#' @return Nothing
#' @export

make_range_file <- function(range, file){

	data.frame( s = paste0("s", 1:length(range)), l = 0.00, u = range ) %>%
		write.table(file, col.names = F, row.names = F, quote = F)

}
