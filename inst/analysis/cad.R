library(data.table)
library(dplyr)
library(magrittr)

cad <- fread("~/cad.add.fixrand.dgc.anno.160614.out.txt", h = T)

cad %>% filter(q_pvalue < 0.05) %>% select(legendrs, other_allele, beta) %>% write.table(file = "~/repos/aprs/data-raw/cad_q0.05.raw", h = F)
