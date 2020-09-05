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
  select(KOD_OBEC = Kod, ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

#RUIAN definiční body obcí
obce_body <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "DefinicniBod") %>%
  select(KOD_OBEC = Kod, ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

# CZSO číselník obcí - #043
cisob <- readr::read_csv2("./data-raw/CIS0043_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8")) %>%
  select(KOD_OBEC = CHODNOTA, NAZ_OBEC = TEXT)

# CZSO číselník okresů - #0101
cisokre <- readr::read_csv2("./data-raw/CIS0101_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8")) %>%
  select(KOD_OKRES = CHODNOTA, NAZ_LAU2 = TEXT, KOD_LAU2 = OKRES_LAU)

# CZSO číselník krajů - #0100
ciskraj <- readr::read_csv2("./data-raw/CIS0100_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8")) %>%
  select(KOD_KRAJ = CHODNOTA, NAZ_CZNUTS3 = TEXT, KOD_CZNUTS3 = CZNUTS)

# vazba obec / okres
vazob <- readr::read_csv2("./data-raw/VAZ0043_0101_CS.csv") %>%
  select(KOD_OBEC = CHODNOTA1, KOD_OKRES = CHODNOTA2)

#  vazba okres / kraj
vazokr <- readr::read_csv2("./data-raw/VAZ0100_0101_CS.csv") %>%
  select(KOD_OKRES = CHODNOTA2, KOD_KRAJ = CHODNOTA1)

# vazba obec / pou obec
vazpou <- readr::read_csv2("./data-raw/VAZ0043_0061_CS.csv") %>%
  select(KOD_OBEC = CHODNOTA1, KOD_POU = CHODNOTA2)

# vazba obec / orp obec
vazorp <- readr::read_csv2("./data-raw/VAZ0043_0065_CS.csv") %>%
  select(KOD_OBEC = CHODNOTA1, KOD_ORP = CHODNOTA2)

# pospojování do zdroje všech zdrojů :)
obce <- cisob %>%
  inner_join(vazpou, by = "KOD_OBEC") %>%
  inner_join(vazorp, by = "KOD_OBEC") %>%
  inner_join(vazob, by = "KOD_OBEC") %>%
  inner_join(cisokre, by = "KOD_OKRES") %>%
  inner_join(vazokr, by = "KOD_OKRES") %>%
  inner_join(ciskraj, by = "KOD_KRAJ")

