library(data.table)
library(dplyr)
library(magrittr)


ldl <- fread("/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_LDL.txt", h = T)

ldl <- ldl[ldl$P < 0.05,]

ldl %>% select(rsid, A2, beta) %>% mutate(A2 = toupper(A2)) %>% write.table(file = "~/repos/aprs/assets/ldl_0.05.raw", col.names = F, row.names = F, quote = F)
