# digest řeky & plochy

library(sf)
library(dplyr)


raw_reky <- st_read("./data-raw/vodstvo/VodniTok.shp")

clean_reky <- raw_reky %>%
  st_transform(4326) %>%
  mutate(Major = JMENO %in% c("Vltava",
                              "Otava",
                              "Dyje",
                              "Sázava",
                              "Svratka",
                              "Morava",
                              "Odra",
                              "Jizera",
                              "Labe",
                              "Mže",
                              "Berounka",
                              "Ohře")) %>%
  select(TYP = DATA50_P, NAZEV = JMENO, Major) %>%
  group_by(TYP, NAZEV, Major) %>%
  summarise() %>%
  ungroup()

raw_plochy <- st_read("./data-raw/vodstvo/VodniPlocha.shp")

clean_plochy <- raw_plochy %>%
  st_buffer(0) %>%
  st_transform(4326) %>%
  select(TYP = DATA50_P, NAZEV = JMENO)

saveRDS(clean_reky, "./data-backup/Reky-D50-2021-07.rds")
saveRDS(clean_plochy, "./data-backup/Plochy-D50-2021-07.rds")
