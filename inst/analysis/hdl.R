library(data.table)
library(dplyr)
library(magrittr)


hdl <- fread("/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_LDL.txt", h = T)

hdl <- hdl[hdl$P < 0.05,]

hdl %>% select(rsid, A2, beta) %>% mutate(A2 = toupper(A2)) %>% write.table(file = "~/repos/aprs/data-raw/hdl_0.05.raw", col.names = F, row.names = F, quote = F)
