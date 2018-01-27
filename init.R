library(devtools)

#read data...
republika <- readRDS("~/GeoCzech/Republika.rds")
kraje <- readRDS("~/GeoCzech/Kraje.rds")
okresy <- readRDS("~/GeoCzech/Okresy.rds")
obce_body <- readRDS("~/GeoCzech/ObceB.rds")
obce_polygony <- readRDS("~/GeoCzech/ObceP.rds")
orp_polygony <- readRDS("~/GeoCzech/ORP.rds")
reky <- readRDS("~/GeoCzech/Reky.rds")
plochy <- readRDS("~/GeoCzech/Plochy.rds")
Praha <- readRDS("~/GeoCzech/Praha.rds")

#save data...
devtools::use_data(republika, overwrite = T)
devtools::use_data(kraje, overwrite = T)
devtools::use_data(okresy, overwrite = T)
devtools::use_data(obce_body, overwrite = T)
devtools::use_data(obce_polygony, overwrite = T)
devtools::use_data(orp_polygony, overwrite = T)
devtools::use_data(reky, overwrite = T)
devtools::use_data(plochy, overwrite = T)
devtools::use_data(Praha, overwrite = T)
