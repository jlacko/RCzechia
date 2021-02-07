# Načte RUIAN soubor + obohatí ho o data z číselníku obcí
# data z CZSO staženy via {czso} package
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"

# aktuální RUIAN export - gitignorován, páč velký jak cyp...
ruian_data <- "./data-raw/20210131_ST_UKSG.xml"

print(st_layers(ruian_data))

# RUIAN polygony obcí
obce_poly <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_OBEC = Kod)  %>% # , ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

#RUIAN definiční body obcí
obce_body <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "DefinicniBod") %>%
  select(KOD_OBEC = Kod)  %>% # , ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

# CZSO číselník obcí - #043
cisob <- czso::czso_get_codelist("cis43") %>%
  mutate(CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_OBEC = CHODNOTA, NAZ_OBEC = TEXT)

# CZSO číselník okresů - #0101
cisokre <- czso::czso_get_codelist("cis101")  %>%
  mutate(CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_OKRES = CHODNOTA, KOD_LAU1 = OKRES_LAU, NAZ_LAU1 = TEXT)

# CZSO číselník krajů - #0100
ciskraj <- czso::czso_get_codelist("cis100") %>%
  mutate(CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_KRAJ = CHODNOTA, KOD_CZNUTS3 = CZNUTS, NAZ_CZNUTS3 = TEXT)

# vazba obec / okres
vazob <- czso::czso_get_codelist("cis101vaz43") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_OKRES = CHODNOTA1)

#  vazba okres / kraj
vazokr <- czso::czso_get_codelist("cis100vaz101") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OKRES = CHODNOTA2, KOD_KRAJ = CHODNOTA1)

# vazba obec / pou obec
vazpou <- czso::czso_get_codelist("cis61vaz43") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_POU = CHODNOTA1, NAZ_POU = TEXT1)

# vazba obec / orp obec
vazorp <- czso::czso_get_codelist("cis65vaz43") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_ORP = CHODNOTA1, NAZ_ORP = TEXT1)

# pospojování do zdroje všech zdrojů :)
obce <- cisob %>%
  inner_join(vazpou, by = "KOD_OBEC") %>%
  inner_join(vazorp, by = "KOD_OBEC") %>%
  inner_join(vazob, by = "KOD_OBEC") %>%
  inner_join(cisokre, by = "KOD_OKRES") %>%
  inner_join(vazokr, by = "KOD_OKRES") %>%
  inner_join(ciskraj, by = "KOD_KRAJ")

# očekávané rozdíly = geometry column
setdiff(colnames(RCzechia::obce_polygony()), colnames(obce))

# polygony obcí s číselníky
fin_obce_poly <- obce_poly %>%
  inner_join(obce)

saveRDS(fin_obce_poly, paste0("./data-backup/ObceP-R-", rozhodne_datum, ".rds"))


# body obcí s číselníky
fin_obce_body <- obce_body %>%
  inner_join(obce)

saveRDS(fin_obce_body, paste0("./data-backup/ObceB-R-", rozhodne_datum, ".rds"))

# polygony ORP s číselníky
fin_orp_poly <- fin_obce_poly %>%
  group_by(KOD_ORP, NAZ_ORP, KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes() %>%
  rename(GeneralizovaneHranice = geom)

saveRDS(fin_orp_poly, paste0("./data-backup/ORP-R-", rozhodne_datum, ".rds"))

# polygony okresů s číselníky
fin_okresy_poly <- fin_obce_poly %>%
  group_by(KOD_OKRES, KOD_LAU1, NAZ_LAU1, KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes() %>%
  rename(GeneralizovaneHranice = geom)

# z Brna venkova vyříznout Brno město
fin_okresy_poly[fin_okresy_poly$KOD_LAU1=="CZ0643",] <- st_difference(fin_okresy_poly[fin_okresy_poly$KOD_LAU1=="CZ0643",], st_geometry(fin_okresy_poly[fin_okresy_poly$KOD_LAU1=="CZ0642",]))

saveRDS(fin_okresy_poly, paste0("./data-backup/Okresy-R-", rozhodne_datum, ".rds"))

# polygony krajů s číselníky
fin_kraje_poly <- fin_obce_poly %>%
  group_by(KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes() %>%
  rename(GeneralizovaneHranice = geom)

# ze STČ vyříznout Prahu
fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3026",] <- st_difference(fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3026",], st_geometry(fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3018",]))

saveRDS(fin_kraje_poly, paste0("./data-backup/Kraje-R-", rozhodne_datum, ".rds"))

# RUIAN polygony MOMC
casti_poly <- st_read(ruian_data,
                     layer = "Momc",
                     geometry_column = "OriginalniHranice") %>%
  select(KOD = Kod, NAZEV = Nazev, KOD_OBEC = ObecKod)  %>%
  mutate(across(where(is.factor), as.character)) %>%
  mutate(across(where(is.numeric), as.character)) %>%
  left_join(cisob, by = "KOD_OBEC") %>%
  st_transform(4326)

saveRDS(casti_poly, paste0("./data-backup/casti-R-", rozhodne_datum, ".rds"))

