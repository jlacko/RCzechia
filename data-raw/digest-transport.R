# digest silnice & železnice
# naprosto, ale naprosto klíčové pouštět v dockeru ozymandias

library(sf)
library(dplyr)

raw_silnice <- st_read("~/data-raw/TRANS/RoadL.shp")

clean_silnice <- raw_silnice %>%
  st_transform(4326) %>%
  # lokální kategorie
  mutate(Name = case_when(NAMN1 %in% c("UNK", "N_A") ~ NA_character_,
                          T ~ NAMN1),
         TRIDA = case_when(NA3 == 16 ~ "Dálnice I. tř.",
                           NA3 == 18 ~ "Dálnice II. tř.",
                           NA3 == 14 ~ "Silnice I. tř.",
                           NA3 == 15 ~ "Silnice II. tř.",
                           NA3 == 20 ~ "Silnice III. tř.",
                           T ~ "neevidovaná silnice"),
         # lokální název
         CISLO_SILNICE = case_when(RTN %in% c("UNK", "N_A") ~ NA_character_,
                                   T ~ RTN),
         # mezinárodní název
         MEZINARODNI_OZNACENI = case_when(RTE %in% c("UNK", "N_A") ~ NA_character_,
                                   T ~ RTE)) %>%
  select(Name, TRIDA, CISLO_SILNICE, MEZINARODNI_OZNACENI)

clean_silnice$geometry <- clean_silnice$geometry %>%
  s2::s2_rebuild() %>%
  sf::st_as_sfc()

raw_zeleznice <- st_read("~/data-raw/TRANS/RailrdL.shp")

clean_zeleznice <- raw_zeleznice %>%
  st_transform(4326) %>%
  # lokální kategorie
  mutate(Name = case_when(NAMN1 %in% c("UNK", "N_A") ~ NA_character_,
                                   T ~ NAMN1),
         ELEKTRIFIKACE = case_when(RRA %in% c(1, 3) ~ T,
                                   RRA == 4 ~ F,
                                   T ~ NA),
         # lokální název
         KOLEJNOST = case_when(FCO == 2 ~ "3 and more",
                               FCO == 3 ~ "single",
                               FCO == 11 ~ "double",
                               T ~ NA_character_),
         # mezinárodní název
         ROZCHODNOST = case_when(GAW == 144 ~ "standard",
                                 GAW == 76 ~ "narrow",
                                 T ~ NA_character_)) %>%
  select(Name, ELEKTRIFIKACE, KOLEJNOST, ROZCHODNOST)

clean_zeleznice$geometry <- clean_zeleznice$geometry %>%
  s2::s2_rebuild() %>%
  sf::st_as_sfc()

saveRDS(clean_silnice, "~/data-backup/Silnice-D200-2021-07.rds")
saveRDS(clean_zeleznice, "~/data-backup/Zeleznice-D200-2021-07.rds")
