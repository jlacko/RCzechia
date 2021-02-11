# načte mapu senátních okrsků
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"

senat_high_res <- st_read("./data-raw/senat.gpkg", stringsAsFactors = F) %>%
  st_make_valid() %>%
  st_cast()

colnames(senat_high_res) <- c("OBVOD", "SIDLO", "NAZEV_VO", "geometry")
st_geometry(senat_high_res) <- "geometry"

senat_high_res <- senat_high_res %>%
  st_transform("EPSG:4326")

senat_low_res <- senat_high_res %>%
  rmapshaper::ms_simplify(keep = .005,
                          keep_shapes = T)


saveRDS(senat_high_res, paste0("./data-backup/Senat-high-", rozhodne_datum, ".rds"))
saveRDS(senat_low_res, paste0("./data-backup/Senat-low-", rozhodne_datum, ".rds"))

