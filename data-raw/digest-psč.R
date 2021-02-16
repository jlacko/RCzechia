# načte mapu poštovních směrovacích čísel
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"

unzip("./data-raw/psc_010120.zip",
      exdir = "./data-raw")

zip_high_res <- st_read("./data-raw/psc_010120/psc_010120.shp", stringsAsFactors = F) %>%
  mutate(NAZ_POSTA = stringi::stri_encode(NAZ_POSTA, from = "windows1250", to = "UTF-8")) %>%
  st_transform("EPSG:4326") %>%
  st_make_valid() %>%
  st_buffer(0) %>%
  st_cast() %>%
  select(PSC, NAZ_POSTA)


zip_low_res <- zip_high_res %>%
  rmapshaper::ms_simplify(keep = 1/20,
                          keep_shapes = T) %>%
  st_make_valid() %>%
  st_buffer(0)

all(st_is_valid(zip_high_res))
all(st_is_valid(zip_low_res))

saveRDS(zip_high_res, paste0("./data-backup/zip-high-", rozhodne_datum, ".rds"))
saveRDS(zip_low_res, paste0("./data-backup/zip-low-", rozhodne_datum, ".rds"))

