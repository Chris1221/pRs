library(data.table)
library(dplyr)
library(magrittr)


tg <- fread("/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_LDL.txt", h = T)

tg <- tg[tg$P < 0.05,]

tg %>% select(rsid, A2, beta) %>% mutate(A2 = toupper(A2)) %>% write.table(file = "~/repos/aprs/data-raw/tg_0.05.raw", col.names = F, row.names = F, quote = F)
