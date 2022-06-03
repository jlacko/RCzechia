# digest řeky & plochy
# naprosto, ale naprosto klíčové pouštět v dockeru ozymandias

library(sf)
library(dplyr)


raw_reky <- st_read("~/data-raw/HYDRO/WatrcrsL.shp")

clean_reky <- raw_reky %>%
  mutate(NAMN1 = case_when(HYDROID == "N.CZ.WATRCRS.124270000100" ~ "Lužnice - přítok Mastníku",
                           T ~ NAMN1)) %>%
  st_transform(4326) %>%
  # výčet major řek
  mutate(Major = NAMN1 %in% c("Vltava",
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
                              "Ohře"),
         # přírodní či umělý
         TYP = case_when(HOC == 5 ~ "natural",
                         HOC == 4 ~ "artificial",
                         T ~ NA_character_),
         # splavný či nesplavný
         Navigable = case_when(NVS == 3 ~ T,
                               NVS == 5 ~ F,
                               T ~ NA),
         # UNK = neznámý název; jinak cajk...
         NAZEV = case_when(NAMN1 == "UNK" ~ NA_character_,
                           T ~ NAMN1)) %>%
  group_by(TYP, NAZEV, Navigable, Major) %>%
  summarise() %>%
  ungroup()

small_reky <- clean_reky %>%
  rmapshaper::ms_simplify(keep = 1/200,
                          keep_shapes = T)

raw_plochy <- st_read("~/data-raw/HYDRO/LakeresA.shp")

clean_plochy <- raw_plochy %>%
  st_buffer(0) %>%
  st_transform(4326) %>%
  select(NAZEV = NAMN1, VYSKA = ZV2)

saveRDS(clean_reky, "~/data-backup/Reky-D200-high-2022-06.rds")
saveRDS(small_reky, "~/data-backup/Reky-D200-low-2022-06.rds")
saveRDS(clean_plochy, "~/data-backup/Plochy-D200-2021-07.rds")
