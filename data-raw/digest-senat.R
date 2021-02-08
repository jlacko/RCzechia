# načte mapu senátních okrsků
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"

senat_high_res <- st_read("./data-raw/senat.gpkg")

senat_low_res <- senat_high_res %>%
  rmapshaper::ms_simplify(keep = .005,
                          keep_shapes = T)

plot(st_geometry(senat_low_res))

saveRDS(senat_high_res, paste0("./data-backup/Senat-high-", rozhodne_datum, ".rds"))
saveRDS(senat_low_res, paste0("./data-backup/Senat-low-", rozhodne_datum, ".rds"))

