# Načte RUIAN soubor + obohatí ho o data z číselníku obcí
# data z CZSO = http://apl.czso.cz/iSMS/cisdata.jsp?kodcis=43
# očekávaná struktura = csv s rozlišovašem středník (tj. read_csv2)


library(sf)
library(dplyr)

# aktuální RUIAN export - gitignorován, páč velký jak cyp...
ruian_data <- "./data-raw/20200831_ST_UKSG.xml"

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
cisob <- readr::read_csv2("./data-raw/CIS0043_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8"),
         CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_OBEC = CHODNOTA, NAZ_OBEC = TEXT)

# CZSO číselník okresů - #0101
cisokre <- readr::read_csv2("./data-raw/CIS0101_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8"),
         CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_OKRES = CHODNOTA, KOD_LAU1 = OKRES_LAU, NAZ_LAU1 = TEXT)

# CZSO číselník krajů - #0100
ciskraj <- readr::read_csv2("./data-raw/CIS0100_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8"),
         CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_KRAJ = CHODNOTA, KOD_CZNUTS3 = CZNUTS, NAZ_CZNUTS3 = TEXT)

# vazba obec / okres
vazob <- readr::read_csv2("./data-raw/VAZ0043_0101_CS.csv") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA1, KOD_OKRES = CHODNOTA2)

#  vazba okres / kraj
vazokr <- readr::read_csv2("./data-raw/VAZ0100_0101_CS.csv") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OKRES = CHODNOTA2, KOD_KRAJ = CHODNOTA1)

# vazba obec / pou obec
vazpou <- readr::read_csv2("./data-raw/VAZ0043_0061_CS.csv") %>%
  mutate(TEXT2 = stringi::stri_conv(TEXT2, from = "windows-1250", to = "UTF-8"),
         CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA1, KOD_POU = CHODNOTA2, NAZ_POU = TEXT2)

# vazba obec / orp obec
vazorp <- readr::read_csv2("./data-raw/VAZ0043_0065_CS.csv") %>%
  mutate(TEXT2 = stringi::stri_conv(TEXT2, from = "windows-1250", to = "UTF-8"),
         CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA1, KOD_ORP = CHODNOTA2, NAZ_ORP = TEXT2)

# pospojování do zdroje všech zdrojů :)
obce <- cisob %>%
  inner_join(vazpou, by = "KOD_OBEC") %>%
  inner_join(vazorp, by = "KOD_OBEC") %>%
  inner_join(vazob, by = "KOD_OBEC") %>%
  inner_join(cisokre, by = "KOD_OKRES") %>%
  inner_join(vazokr, by = "KOD_OKRES") %>%
  inner_join(ciskraj, by = "KOD_KRAJ")

# očekávané rozdíly = ZUJ + geometry column
setdiff(colnames(RCzechia::obce_polygony()), colnames(obce))

# polygony obcí s číselníky
fin_obce_poly <- obce_poly %>%
  inner_join(obce)

saveRDS(fin_obce_poly, "./data-backup/ObceP-R-2020-09.rds")


# body obcí s číselníky
fin_obce_body <- obce_body %>%
  inner_join(obce)

saveRDS(fin_obce_body, "./data-backup/ObceB-R-2020-09.rds")

# polygony ORP s číselníky
fin_orp_poly <- fin_obce_poly %>%
  group_by(KOD_ORP, NAZ_ORP, KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes() %>%
  rename(GeneralizovaneHranice = geom) %>%
  rmapshaper::ms_simplify(keep = 1/2, keep_shapes = TRUE)

saveRDS(fin_orp_poly, "./data-backup/ORP-R-2020-09.rds")

# polygony okresů s číselníky
fin_okresy_poly <- fin_obce_poly %>%
  group_by(KOD_OKRES, KOD_LAU1, NAZ_LAU1, KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes() %>%
  rename(GeneralizovaneHranice = geom) %>%
  rmapshaper::ms_simplify(keep = 1/2, keep_shapes = TRUE)

saveRDS(fin_okresy_poly, "./data-backup/Okresy-R-2020-09.rds")

# polygony krajů s číselníky
fin_kraje_poly <- fin_obce_poly %>%
  group_by(KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes() %>%
  rename(GeneralizovaneHranice = geom) %>%
  rmapshaper::ms_simplify(keep = 1/2, keep_shapes = TRUE)

# ze STČ vyříznout Prahu
fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3026",] <- st_sym_difference(fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3026",], st_geometry(fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3018",]))

saveRDS(fin_kraje_poly, "./data-backup/Kraje-R-2020-09.rds")

