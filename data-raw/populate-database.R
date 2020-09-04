# naplní daty sqlite databázi

library(DBI)
library(sf)
library(dplyr)

# database connection init
con <- DBI::dbConnect(RSQLite::SQLite(), "./data-raw/rczechia.db")

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

# CZSO číselník obcí
cisob <- readr::read_csv2("./data-raw/CIS0043_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8")) %>%
  select(KOD_OBEC = CHODNOTA, NAZ_OBEC = TEXT)

# CZSO číselník okresů
cisokre <- readr::read_csv2("./data-raw/CIS0101_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8")) %>%
  select(KOD_OKRES = CHODNOTA, NAZ_LAU1 = TEXT, KOD_LAU1 = OKRES_LAU)

# CZSo číselník krajů
ciskraj <- readr::read_csv2("./data-raw/CIS0100_CS.csv") %>%
  mutate(TEXT = stringi::stri_conv(TEXT, from = "windows-1250", to = "UTF-8")) %>%
  select(KOD_KRAJ = CHODNOTA, NAZ_CZNUTS3 = TEXT, KOD_CZNUTS3 = CZNUTS)

# vazba obec / okres
vazob <- readr::read_csv2("./data-raw/VAZ0043_0101_CS.csv") %>%
  select(KOD_OBEC = CHODNOTA1, KOD_OKRES = CHODNOTA2)

#  vazba okres / kraj
vazokr <- readr::read_csv2("./data-raw/VAZ0100_0101_CS.csv") %>%
  select(KOD_OKRES = CHODNOTA1, KOD_KRAJ = CHODNOTA2)

# vazba obec / pou obec
vazpou <- readr::read_csv2("./data-raw/VAZ0043_0061_CS.csv") %>%
  select(KOD_OBEC = CHODNOTA1, KOD_POU = CHODNOTA2)

# vazba obec / orp opbe
vazorp <- readr::read_csv2("./data-raw/VAZ0043_0065_CS.csv") %>%
  select(KOD_OBEC = CHODNOTA1, KOD_ORP = CHODNOTA2)

# uložit obce do tabulky jako základní prostorový kámen
DBI::dbWriteTable(conn = con, name = "obce_poly", value = obce_poly, overwrite = T)
DBI::dbWriteTable(conn = con, name = "obce_body", value = obce_body, overwrite = T)
DBI::dbWriteTable(conn = con, name = "cisob", value = cisob, overwrite = T)
DBI::dbWriteTable(conn = con, name = "cisokre", value = cisokre, overwrite = T)
DBI::dbWriteTable(conn = con, name = "ciskraj", value = ciskraj, overwrite = T)
DBI::dbWriteTable(conn = con, name = "vazob", value = vazob, overwrite = T)
DBI::dbWriteTable(conn = con, name = "vazokr", value = vazokr, overwrite = T)
DBI::dbWriteTable(conn = con, name = "vazpou", value = vazpou, overwrite = T)
DBI::dbWriteTable(conn = con, name = "vazorp", value = vazorp, overwrite = T)

# uklidit po sobě je slušnost
DBI::dbDisconnect(con)
