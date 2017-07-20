library(devtools)

#read data...
republika <- readRDS("~/GeoCzech/Republika.rds")
okresy <- readRDS("~/GeoCzech/Okresy.rds")
obce <- readRDS("~/GeoCzech/Obce.rds")
reky <- readRDS("~/GeoCzech/Reky.rds")
plochy <- readRDS("~/GeoCzech/Plochy.rds")

#save data...
devtools::use_data(republika)
devtools::use_data(okresy)
devtools::use_data(obce)
devtools::use_data(reky)
devtools::use_data(plochy)

build()
