library(devtools)

#read data...
republika <- readRDS("~/GeoCzech/Republika.rds")
okresy <- readRDS("~/GeoCzech/Okresy.rds")
obce_body <- readRDS("~/GeoCzech/ObceB.rds")
obce_polygony <- readRDS("~/GeoCzech/ObceP.rds")
reky <- readRDS("~/GeoCzech/Reky.rds")
plochy <- readRDS("~/GeoCzech/Plochy.rds")

#save data...
devtools::use_data(republika)
devtools::use_data(okresy)
devtools::use_data(obce_body)
devtools::use_data(obce_polygony)
devtools::use_data(reky)
devtools::use_data(plochy)
