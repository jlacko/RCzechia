# digest chráněná územi
library(sf)
library(dplyr)

# data source = https://data.nature.cz- neboli AOPK
velkoplosna <- st_read("./data-raw/Velkoplošná_zvláště_chráněná_území.shp") %>%
  select(TYP = KAT, NAZEV) %>%
  mutate(PLOCHA = "velkoplošná") %>%
  st_make_valid() %>%
  st_transform(4326) # pro jistotu...

maloplosna <- st_read("./data-raw/Maloplošná_zvláště_chráněná_území.shp") %>%
  select(TYP = KAT, NAZEV) %>%
  mutate(PLOCHA = "maloplošná") %>%
  st_make_valid() %>%
  st_transform(4326) # pro jistotu...

chr_uzemi <- rbind(velkoplosna, maloplosna)

st_crs(chr_uzemi) <- "EPSG:4326" # sladění na testy; na funkci vliv nemá...

saveRDS(chr_uzemi, "./data-backup/ChrUzemiAOPK-2025-06.rds")
