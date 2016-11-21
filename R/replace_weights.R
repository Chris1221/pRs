#' Replace the effect sizes in an assoc file with those found in another assoc file.
#'
#' Useful for weighting according to the betas of a different trait while keeping the inclusion criteria given by the P values.
#' 
#' @param assoc1 Path to first assoc file.
#' @param assoc2 Path to the second assoc file.
#' @param file Path to write the resulting assoc file.
#'
#' @importFrom dplyr select select_ filter
#' @importFrom magrittr %<>%
#'
#' @export
#' 
#' @return Nothing, used for side effects.

replace_weights <- 
	
	function(
		assoc1,
		assoc2,
		file
	){

	assoc1 <- fread(assoc1, h = T)
	assoc2 <- fread(assoc2, h = T)

	# Get column names for assoc1

	# See what kind of effect size is present.	
	possible_beta_names <- c("Beta", "beta", "b", "B", "BETA", "OR", "or", "odds ratio")
	beta_name1 <- possible_beta_names[possible_beta_names %in% colnames(assoc1)]
		
	# See what kind of P value is present
	possible_p_names <- c("P", "p", "p-value", "p_value", "P-value")
	p_name1 <- possible_p_names[possible_p_names %in% colnames(assoc1)]

	possible_snp_names <- c("SNP", "rsid", "snp", "legendrs")
	snp_name1 <- possible_snp_names[possible_snp_names %in% colnames(assoc1)]

	# Change the P name to workaround the dash confusion
	colnames(assoc1)[colnames(assoc1) == p_name1] <- "P"
	colnames(assoc1)[colnames(assoc1) == beta_name1] <- "BETA"
	colnames(assoc1)[colnames(assoc1) == snp_name1] <- "RSID"


	## Get column names for assoc2

	# See what kind of effect size is present.	
	possible_beta_names <- c("Beta", "beta", "b", "B", "BETA", "OR", "or", "odds ratio")
	beta_name2 <- possible_beta_names[possible_beta_names %in% colnames(assoc2)]
		
	# See what kind of P value is present
	possible_p_names <- c("P", "p", "p-value", "p_value", "P-value", "p_dgc")
	p_name2 <- possible_p_names[possible_p_names %in% colnames(assoc2)]

	possible_snp_names <- c("SNP", "rsid", "snp", "legendrs")
	snp_name2 <- possible_snp_names[possible_snp_names %in% colnames(assoc2)]

	# Change the P name to workaround the dash confusion
	colnames(assoc2)[colnames(assoc2) == p_name2] <- "P"
	colnames(assoc2)[colnames(assoc2) == beta_name2] <- "BETA"
	colnames(assoc2)[colnames(assoc2) == snp_name2] <- "RSID"


	# ------------------------------------------------------ #


	assoc1 %<>% select_("RSID", "BETA", "P") 
	assoc2 %<>% select_("RSID", "BETA", "P") 

	# This gets sorted but I dont think thats a problem.
	output <- base::merge(assoc1, 
		    assoc2,
		    by = "RSID",
		    all.x = TRUE,
		    all.y = FALSE) %>% 
			    select(RSID,BETA.y, P.x) %>%
				    filter(RSID != ".")
			    
			    
	colnames(output) <- c("RSID", "BETA", "P")
	
	output$BETA[is.na(output$P)] <- NA
	output$P[is.na(output$BETA)] <- NA

	write.table(output,
		    file = file,
		    col.names = T,
		    row.names = F,
		    quote = F)
}
