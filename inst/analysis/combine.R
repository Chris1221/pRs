library(data.table)
library(dplyr)
library(magrittr)

setwd("~/repos/aprs/data-raw")

ldl <- fread("ldl.profile", h = T)
hdl <- fread("hdl.profile", h = T)
tg <- fread("tg.profile", h = T)
cad <- fread("cad.profile", h = T)


phen <- fread("cad.phen", h =T)

phen <- ldl %>%
	mutate(ldl_score = SCORE) %>%
	select(IID, ldl_score) %>%
	merge(phen, by = "IID") 

phen <- hdl %>%
	mutate(hdl_score = SCORE) %>%
	select(IID, hdl_score) %>%
	merge(phen, by = "IID") 

phen <- tg %>%
	mutate(tg_score = SCORE) %>%
	select(IID, tg_score) %>%
	merge(phen, by = "IID") 

phen <- cad %>%
	mutate(cad_score = SCORE) %>%
	select(IID, cad_score) %>%
	merge(phen, by = "IID") 


phen %<>% mutate(simple = tg_score + hdl_score + ldl_score)



### Working on new score

# n_i are all the same
ldl_n_i = 188577
hdl_n_i = 188577 
tg_n_i = 188577 

ldl_rg = 0.25
tg_rg = 0.318
hdl_rg = -0.252

# Heritability between 0.4 and 0.6 so try both
h1 = 0.6
h12 = 0.4

h2_ldl = 0.1347
h2_hdl = 0.1572
h2_tg = 0.1161

# construct new score
phen %<>% mutate(new = (sqrt(ldl_n_i) * ldl_rg * sqrt(h2_ldl / h1) * ldl_score) +
		(sqrt(hdl_n_i) * hdl_rg * sqrt(h2_hdl / h1) * hdl_score) +
		(sqrt(tg_n_i) * tg_rg * sqrt(h2_tg / h1) * tg_score))

# Regression results

lm(cad ~ new, data = phen) %>% summary
lm(cad ~ simple, data = phen) %>% summary


