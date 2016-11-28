#' Take an assoc file and make the second param to q-score-range. 
#'
#' @param assoc The file path to the assoc file.
#'
#' @return Nothing.
#' @export

make_score_profile <- function(assoc, file){


	for(i in 1:length(assoc)){

	assertthat::assert_that(file.exists(assoc[i]))

	a <- as.data.frame(data.table::fread(assoc[i], h = T))

	possible_snp_names <- c("SNP", "rsid", "snp", "legendrs")
	snp_names <- possible_snp_names[possible_snp_names %in% colnames(a)]

	possible_a2_names <- c("A2", "a2", "alternate_allele", "other_allele")
	a2_names <- possible_a2_names[possible_a2_names %in% colnames(a)]

	possible_beta_names <- c("Beta", "beta", "b", "B", "BETA", "OR", "or", "odds ratio")
	beta_name <- possible_beta_names[possible_beta_names %in% colnames(a)]

	a[, a2_names] <- toupper(a[, a2_names])

	a %>%
		select_(snp_names, a2_names, beta_name) %>%
		write.table(file[i], col.names = F, row.names = F, quote = F)

	}
}
