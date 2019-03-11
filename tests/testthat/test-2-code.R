library(dplyr)
library(sf)

context("union_sf")

obec_praha <- obce_body() %>% # bod Praha (určitě správně)
  filter(KOD_LAU1 == "CZ0100")

wtf <- data.frame(col = c(1,2,3)) # data frame se sloupcem col - má se rozbít, proto wtf :)

expect_error(union_sf(wtf, "col")) # čekám chybu - není spatial
expect_error(union_sf(okresy("low"))) # čekám chybu - chybí key
expect_error(union_sf(key = "col")) # čekám chybu - chybí .data
expect_error(union_sf(okresy("low"), "bflm")) # čekám chybu - není sloupec z data frame

united_praha <- casti() %>% # Praha vzniklá spojením z městských částí
  union_sf("NAZ_OBEC") %>%
  filter(key == "Praha")

ofiko_praha <- kraje() %>% # Praha jako kraj
  filter(KOD_CZNUTS3 == "CZ010")

expect_equal(st_contains(republika("high"), united_praha)[[1]], 1) # Praha z částí je v republice
expect_equal(st_contains(united_praha, obec_praha)[[1]], 1)  # bod Praha je ve spojené Praze

expect_equal(st_crs(casti()), st_crs(united_praha)) # CRS na vstupu = CRS na výstupu

expect_equal(st_area(united_praha), st_area(ofiko_praha), tolerance = 1e-6)
 # Praha z částí a Praha jako kraj jsou stejně velké, plus mínus jedna miliontina


context("geocode")

dos_sochoros <- c("pplk. Sochora 4, Praha", # platná adresa
                  "pplk. Sochora 4, Čierná pri Čope") # neplatná adresa


expect_error(geocode()) # čekám chybu - není cíl

expect_s3_class(geocode("pplk. Sochora 4, Praha"), "sf") # vrací se class sf

expect_equal(st_crs(geocode("pplk. Sochora 4, Praha"))$epsg, 4326) # defaultní CRS = WGS84
expect_equal(st_crs(geocode("pplk. Sochora 4, Praha", 5514))$epsg, 5514) # Křovák = Křovák

expect_equal(geocode("pplk. Sochora 4, Čierna pri Čope"), NA) # adresa neexistuje, vrátí se NA
expect_lt(nrow(geocode(dos_sochoros)), length(dos_sochoros)) # jeden se najde, druhý ne

expect_gte(nrow(geocode("pplk. Sochora 4")), 1) # jedna v Praze, jedna v Brandýse

context("revgeo")

