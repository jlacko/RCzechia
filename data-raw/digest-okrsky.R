# načte mapu obecných volebních okrsků
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"

okrsky_high_res <- st_read("./data-raw/20201003_ST_UVOH.xml", stringsAsFactors = F) %>%
  st_make_valid() %>%
  st_set_geometry("OriginalniHranice") %>%
  st_cast() %>%
  st_buffer(0) %>%
  st_transform("EPSG:4326") %>%
  select(Kod, Cislo, ObecKod, MomcKod, OriginalniHranice)

okrsky_low_res <- okrsky_high_res %>%
  rmapshaper::ms_simplify(keep = 1/20,
                          keep_shapes = T) %>%
  st_buffer(0)



saveRDS(okrsky_high_res, paste0("./data-backup/Okrsky-high-", rozhodne_datum, ".rds"))
saveRDS(okrsky_low_res, paste0("./data-backup/Okrsky-low-", rozhodne_datum, ".rds"))
