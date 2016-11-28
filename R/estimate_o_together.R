#' Estimate the optimal score and return it
#'
#' @return Nothing
#'
#' @importFrom dplyr %>% select slice starts_with
#' @importFrom data.table fread
#' @export
estimate_o_together <- function(
					dirs,
					n_i,
					r_i,
					h_i,
					h_1
				){

	score <- list()

	n = length(dirs)

	for(one in 1:50){
		for(two in 1:50){
			for(three in 1:50){
				for(four in 1:50){
					for(five in 1:50){

			profiles1 <- list.files(dirs[1], pattern = "*.profile")
			profiles2 <- list.files(dirs[2], pattern = "*.profile")
			profiles3 <- list.files(dirs[3], pattern = "*.profile")
			profiles4 <- list.files(dirs[4], pattern = "*.profile")
			profiles5 <- list.files(dirs[5], pattern = "*.profile")

			s[[1]] <- fread(paste0(dirs[1], "/", profiles1[one]), na.strings = "-9", h = T)
			s[[2]] <- fread(paste0(dirs[2], "/", profiles2[two]), na.strings = "-9", h = T)
			s[[3]] <- fread(paste0(dirs[3], "/", profiles3[three]), na.strings = "-9", h = T)
			s[[4]] <- fread(paste0(dirs[4], "/", profiles4[four]), na.strings = "-9", h = T)
			s[[5]] <- fread(paste0(dirs[5], "/", profiles5[five]), na.strings = "-9", h = T)

			combined_score <- numeric(length(s[[1]]$IID))

			for(i in 1:length(dirs)){

				combined_score <- combined_score + 			
					( 
					 sqrt(n_i[i]) * 
					 r_i[i] *
					 sqrt( h_i[i] / h_1 ) *
					 s[[i]]$SCORE
					)
			}

			p <- data.frame(one = numeric(), two = numeric(), three = numeric(), four = numeric(), five = numeric(), p = numeric())

			p$p <- lm(score[[1]]$PHENO ~ comorbid_score) %>%
				summary %>%
				coef %>%
				as.data.frame %>%
				slice(2) %>%
				select(starts_with("Pr")) %>%
				as.double

			p$one <- one
			p$two <- two
			p$three <- three
			p$four <- four
			p$five <- five


	}}}}}


	write.table(p[which.min(p$p), ],
		    "results/together.txt",
		    col.names = T,
		    row.names = F,
		    quote = F)
}
