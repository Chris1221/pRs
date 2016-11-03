library(data.table)
library(dplyr)
library(magrittr)


hdl <- fread("/scratch/hpc2862/lshtm/aprs/summary_data/jointGwasMc_LDL.txt", h = T)

hdl <- hdl[hdl$P < 0.05,]

cad <- fread("cad.add.fixrand.dgc.anno.160614.out.txt", h = T)

cad %<>% select(legendrs, beta) %>% mutate(rsid = legendrs) %>% select(-legendrs)
hdl %<>% select(rsid, A2)

hdl <- merge(hdl, cad, by = "rsid")

hdl %>% select(rsid, A2, beta) %>% mutate(A2 = toupper(A2)) %>% write.table(file = "~/repos/aprs/data-raw/hdl_0.05.raw", col.names = F, row.names = F, quote = F)
