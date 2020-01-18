library(dplyr)
library(sf)

context("union_sf")

obec_praha <- obce_body() %>% # bod Praha (určitě správně)
  filter(KOD_LAU1 == "CZ0100")

wtf <- data.frame(col = c(1, 2, 3)) # data frame se sloupcem col - má se rozbít, proto wtf :)


# očekávané chyby - špatné zadání

expect_error(union_sf(wtf, "col")) # čekám chybu - není spatial
expect_error(union_sf(okresy("low"))) # čekám chybu - chybí key
expect_error(union_sf(key = "col")) # čekám chybu - chybí data
expect_error(union_sf(okresy("low"), "bflm")) # čekám chybu - není sloupec z data frame
expect_error(union_sf(okresy("low"), c("KOD_LAU1", "NAZ_LAU1"))) # čekám chybu - klíč má být jeden

united_casti <- casti() %>% # všechny obce vzniklé spojením z městských částí
  union_sf("NAZ_OBEC")

# cyklus se nezastaví na jedničce
expect_gt(nrow(united_casti), 1)

# praha z částí
united_praha <- united_casti %>%
  filter(NAZ_OBEC == "Praha")

# praha je jedna
expect_equal(nrow(united_praha), 1)

# sloupce odpovídají zadání
expect_equal(colnames(united_praha), c("NAZ_OBEC", "geometry"))

ofiko_praha <- kraje() %>% # Praha jako kraj
  filter(KOD_CZNUTS3 == "CZ010")

# Praha z částí je sf
expect_s3_class(united_praha, "sf")

# Praha z částí je v republice
expect_equal(st_contains(republika("high"), united_praha)[[1]], 1)

# bod Praha je v Praze z částí
expect_equal(st_contains(united_praha, obec_praha)[[1]], 1)

# spojením se nezměnil CRS
expect_equal(st_crs(casti()), st_crs(united_praha))

# Praha z částí a Praha jako kraj jsou stejně velké, plus mínus jedna miliontina
expect_equal(st_area(united_praha), st_area(ofiko_praha), tolerance = 1e-6)


context("geocode")

dos_sochoros <- c(
  "pplk. Sochora 4, Praha", # platná adresa
  "pplk. Sochora 4, Čierna pri Čope"
) # neplatná adresa

# očekávané chyby - špatné zadání
expect_error(geocode()) # čekám chybu - není cíl

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(geocode(dos_sochoros[1]), "error in connection") # není síť
Sys.setenv("NETWORK_UP" = TRUE)

# vrací se sf objekt
expect_s3_class(geocode(dos_sochoros[1]), "sf") # vrací se class sf

# správné hlavičky sloupců
expect_equal(geocode(dos_sochoros) %>% colnames(), c("target", "typ", "address", "geometry"))

# CRS má očekávanou hodnotu
expect_equal(st_crs(geocode(dos_sochoros[1]))$epsg, 4326) # defaultní CRS = WGS84
expect_equal(st_crs(geocode(dos_sochoros[1], 5514))$epsg, 5514) # Křovák = Křovák

# očekávaná hodnota souřadnic známého bodu
expect_equal(st_coordinates(geocode(dos_sochoros[1]))[, "X"], 14.4365531) # default = vrací WGS84
expect_equal(st_coordinates(geocode(dos_sochoros[1]))[, "Y"], 50.1000536) # dtto...

# chybná adresa:
expect_equal(geocode(dos_sochoros[2]), NA) # pokud neexistuje žádná adresa, tak NA
expect_lt(nrow(geocode(dos_sochoros)), length(dos_sochoros)) # pokud neexistují všechny, tak se vrátí míň než hledáno

# nejednoznačná adresa:
expect_gte(nrow(geocode("pplk. Sochora 4")), 1) # jedna v Praze, jedna v Brandýse: ergo víc jak 1

context("revgeo")

sochor_wgs <- geocode(dos_sochoros[1]) # podle WGS84
sochor_krovak <- st_transform(sochor_wgs, 5514) # totéž, dle Křováka

amerika <- data.frame(
  place = c("Statue of Liberty", "Golden Gate Bridge"), # zcela jasně out of scope pro ČÚZK
  x = c(-74.044444, -122.478611),
  y = c(40.689167, 37.819722)
) %>%
  st_as_sf(coords = c("x", "y")) %>%
  st_set_crs(4326)

tres_sochoros <- geocode(rep(dos_sochoros[1], 3)) # tři stejné adresy

# očekávané chyby - špatné zadání
expect_error(revgeo()) # čekám chybu - nejsou koordináty
expect_error(revgeo("bflm")) # čekám chybu - zadání není sf
expect_error(revgeo(kraje())) # čekám chybu - nejsou body ale polygony

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(revgeo(sochor_wgs), "error in connection") # není síť
Sys.setenv("NETWORK_UP" = TRUE)

# vrací se sf objekt
expect_s3_class(revgeo(sochor_wgs), "sf") # vrací se class sf

# koordináty v WGS84
expect_equal(revgeo(sochor_wgs)$revgeocoded, "Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7")

# koordináty ve Křovákovi
expect_equal(revgeo(sochor_krovak)$revgeocoded, "Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7")

# třikrát stejné koordináty = funguje vektorizace
expect_equal(revgeo(tres_sochoros)$revgeocoded, rep("Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7", 3))

# platný sf objekt, ale out of scope českého katastru
expect_equal(revgeo(amerika)$revgeocoded %>% is.na() %>% unique(), T) # vrací se pouze NA ...
