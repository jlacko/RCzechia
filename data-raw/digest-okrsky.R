# načte mapu obecných volebních okrsků
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"

okrsky_high_res <- st_read("./data-raw/20201003_ST_UVOH.xml", stringsAsFactors = F) %>%
  st_make_valid() %>%
  st_transform(4326) %>%
  st_set_geometry("OriginalniHranice") %>%
  st_cast() %>%
  select(Kod, Cislo, ObecKod, MomcKod, OriginalniHranice)

okrsky_low_res <- okrsky_high_res %>%
  rmapshaper::ms_simplify(keep = 1/20,
                          keep_shapes = T)

plot(st_geometry(okrsky_low_res))

saveRDS(okrsky_high_res, paste0("./data-backup/Okrsky-high-", rozhodne_datum, ".rds"))
saveRDS(okrsky_low_res, paste0("./data-backup/Okrsky-low-", rozhodne_datum, ".rds"))

