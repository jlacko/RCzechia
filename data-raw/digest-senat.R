# načte mapu senátních okrsků
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"

okrsky_senat <- st_read("./data-raw/vo_senat_010616.shp") %>%
  mutate(NAZEV_VO = iconv(NAZEV_VO, from = "UTF-8", to = "UTF-8"))


