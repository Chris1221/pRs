library(data.table)
library(dplyr)
library(magrittr)


ldl <- fread("/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_LDL.txt", h = T)

ldl <- ldl[ldl$P < 0.05,]

cad <- fread("~/cad.add.fixrand.dgc.anno.160614.out.txt", h = T)

cad %<>% select(legendrs, beta) %>% mutate(rsid = legendrs) %>% select(-legendrs)
ldl %<>% select(rsid, A2)

ldl <- merge(ldl, cad, by = "rsid")

ldl %>% select(rsid, A2, beta) %>% mutate(A2 = toupper(A2)) %>% write.table(file = "~/repos/aprs/data-raw/ldl_0.05.raw", col.names = F, row.names = F, quote = F)
