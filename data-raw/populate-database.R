# naplní daty sqlite databázi

library(DBI)
library(sf)
library(dplyr)

# database connection init
con <- DBI::dbConnect(RSQLite::SQLite(), "./data-raw/rczechia.db")

# aktuální RUIAN export - gitignorován, páč velký jak cyp...
ruian_data <- "./data-raw/20200831_ST_UKSG.xml"

print(st_layers(ruian_data))

obce_poly <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_OBEC = Kod, ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

obce_body <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "DefinicniBod") %>%
  select(KOD_OBEC = Kod, ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)


# uložit obce do tabulky jako základní prostorový kámen
DBI::dbWriteTable(conn = con, name = "obce_poly", value = obce_poly, overwrite = T)
DBI::dbWriteTable(conn = con, name = "obce_body", value = obce_body, overwrite = T)

# uklidit po sobě je slušnost
DBI::dbDisconnect(con)
