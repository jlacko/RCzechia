# načte data z ruian, přeloží do rczechia formátu sloupců a uloží do /data-backup

library(dplyr)
library(RCzechia)

# aktuální RUIAN export - gitignorován, páč velký jak cyp...
ruian_data <- "./data-raw/20200331_ST_UKSG.xml"

print(st_layers(ruian_data))

# obce polygony
sloupce_obce <- obce_polygony() %>%
  st_drop_geometry()

ruian_obce <- st_read(ruian_data,
                      layer = "Obce",
                      geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_OBEC = Kod) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

obce <- ruian_obce %>%
  inner_join(sloupce_obce)

saveRDS(obce, "./data-backup/ObceP-R.rds")


