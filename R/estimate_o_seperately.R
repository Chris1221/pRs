#' Estimate the optimal score and return it
#'
#' @return Nothing
#'
#' @export
estimate_o_seperately <- function(
					dirs,
					n_i,
					r_i,
					h_i,
					h_1
				){


	for(j in 1:length(dirs)){

		dir <- dirs[j]
		
		profiles <- list.files(dir, pattern = "*.profile")
		p <- vector()
		

		for(i in 1:length(profiles)){

			p[i] <- 
			fread(paste0(dir, "/", profiles[i]), na.strings = "-9", h = T) %>%
			lm(PHENO ~ SCORE, .) %>%
			summary %>%
			coef %>%
			as.data.frame %>%
			slice(2) %>%
			select(starts_with("Pr")) %>% 
			as.double
		}

		minp <- p[base::which.min(p)] 
		min_profile <- profiles[which.min(p)]

		min_profile <- fread(paste0(dir, "/", min_profile), na.strings = "-9", h = T)
		
		score[[j]] <- data.frame(IID = min_profile$IID, SCORE = min_profile$SCORE)

	}	

	combined_score <- numeric(length(score[[1]]$IID))

	for(i in 1:length(dirs)){

		combined_score <- combined_score + 			
			( 
			 sqrt(n_i[i]) * 
			 r_i[i] *
			 sqrt( h_i[i] / h_1 ) *
			 score[[i]]$SCORE
		 	)
	}

	iid <- score[[1]]$IID
	phen <- min_profile$PHENO

	lm(phen ~ combined_score) %>%
	summary %>%
	coef %>%
	write.table("results/together.txt", col.names = T, row.names = F, quote = F)
	


} 
