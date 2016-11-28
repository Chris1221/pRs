#' Take an assoc file and make the second param to q-score-range. 
#'
#' @param assoc The file path to the assoc file.
#'
#' @return Nothing.
#' @export

make_score_p <- function(assoc, file){


	for(i in 1:length(assoc)){

		assertthat::assert_that(file.exists(assoc[i]))

		possible_snp_names <- c("SNP", "rsid", "snp", "legendrs")
		snp_names <- possible_snp_names[possible_snp_names %in% colnames(a)]

		a <- as.data.frame(data.table::fread(assoc[i], h = T))

		possible_p_names <- c("P", "p", "p-value", "p_value", "P-value", "p_dgc")
		p_name <- possible_p_names[possible_p_names %in% colnames(a)]

		a %>%
			select_(snp_names, p_name) %>%
			write.table(file[i], col.names = F, row.names = F, quote = F)

	}
}
