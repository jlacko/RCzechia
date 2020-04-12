# načte data z ruian, přeloží do rczechia formátu sloupců a uloží do /data-backup

library(dplyr)
library(RCzechia)

# aktuální RUIAN export - gitignorován, páč velký jak cyp...
ruian_data <- "./data-raw/20200331_ST_UKSG.xml"

print(st_layers(ruian_data))

# obce polygony
sloupce_obce <- obce_polygony() %>%
  st_drop_geometry()

ruian <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_OBEC = Kod) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

trans <- ruian %>%
  inner_join(sloupce_obce)

saveRDS(trans, "./data-backup/ObceP-R.rds")

# obce body
sloupce_obce <- obce_body() %>%
  st_drop_geometry()

ruian <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "DefinicniBod") %>%
  select(KOD_OBEC = Kod) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

trans <- ruian %>%
  inner_join(sloupce_obce)

saveRDS(trans, "./data-backup/ObceB-R.rds")

# ORP polygony
sloupce_orp <- orp_polygony() %>%
  st_drop_geometry()

ruian <- st_read(ruian_data,
                 layer = "Orp",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_RUIAN = Kod) %>%
  mutate(KOD_RUIAN = as.character(KOD_RUIAN)) %>%
  st_transform(4326)

trans <- ruian %>%
  inner_join(sloupce_orp) %>%
  select(KOD_ORP, NAZ_ZKR_ORP, NAZ_ORP, KOD_RUIAN, everything())

saveRDS(trans, "./data-backup/ORP-R.rds")

# Okresy
sloupce_okresy <- okresy() %>%
  st_drop_geometry()

ruian <- st_read(ruian_data,
                 layer = "Okresy",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_LAU1 = NutsLau) %>%
  mutate(KOD_LAU1 = as.character(KOD_LAU1)) %>%
  st_transform(4326)

trans <- ruian %>%
  inner_join(sloupce_okresy) %>%
  select(KOD_OKRES, KOD_LAU1, everything())

saveRDS(trans, "./data-backup/Okresy-R.rds")

# Kraje
sloupce_kraje <- kraje() %>%
  st_drop_geometry()

ruian <- st_read(ruian_data,
                 layer = "Vusc",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_CZNUTS3 = NutsLau) %>%
  mutate(KOD_CZNUTS3 = as.character(KOD_CZNUTS3)) %>%
  st_transform(4326)

trans <- ruian %>%
  inner_join(sloupce_kraje) %>%
  select(KOD_KRAJ, KOD_CZNUTS3, everything())

saveRDS(trans, "./data-backup/Kraje-R.rds")

# Republika
ruian <- st_read(ruian_data,
                 layer = "Staty",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(NAZ_STAT = Nazev) %>%
  mutate(NAZ_STAT = as.character(NAZ_STAT)) %>%
  st_transform(4326)

saveRDS(ruian, "./data-backup/Republika-R.rds")

