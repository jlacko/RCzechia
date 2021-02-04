# digest chráněná územi
library(sf)
library(dplyr)

# data source = https://data.nature.cz- neboli AOPK
velkoplosna <- st_read("./data-raw/Velkoplo%C5%A1n%C3%A1_zvl%C3%A1%C5%A1t%C4%9B_chr%C3%A1n%C4%9Bn%C3%A1_%C3%BAzem%C3%AD.shp") %>%
  select(TYP = KAT, NAZEV) %>%
  mutate(PLOCHA = "velkoplošná") %>%
  st_make_valid() %>%
  st_transform(4326) # pro jistotu...

maloplosna <- st_read("./data-raw/Maloplo%C5%A1n%C3%A1_zvl%C3%A1%C5%A1t%C4%9B_chr%C3%A1n%C4%9Bn%C3%A1_%C3%BAzem%C3%AD.shp") %>%
  select(TYP = KAT, NAZEV) %>%
  mutate(PLOCHA = "maloplošná") %>%
  st_make_valid() %>%
  st_transform(4326) # pro jistotu...

chr_uzemi <- rbind(velkoplosna, maloplosna)

st_crs(chr_uzemi) <- "EPSG:4326" # sladění na testy; na funkci vliv nemá...

saveRDS(chr_uzemi, "./data-backup/ChrUzemiAOPK-2021-02.rds")
