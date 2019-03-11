library(dplyr)
library(sf)

context("union_sf")

obec_praha <- obce_body() %>% # bod Praha (určitě správně)
  filter(KOD_LAU1 == "CZ0100")

wtf <- data.frame(col = c(1,2,3)) # data frame se sloupcem col - má se rozbít, proto wtf :)

# očekávané chyby - špatné zadání
expect_error(union_sf(wtf, "col")) # čekám chybu - není spatial
expect_error(union_sf(okresy("low"))) # čekám chybu - chybí key
expect_error(union_sf(key = "col")) # čekám chybu - chybí .data
expect_error(union_sf(okresy("low"), "bflm")) # čekám chybu - není sloupec z data frame

united_praha <- casti() %>% # Praha vzniklá spojením z městských částí
  union_sf("NAZ_OBEC") %>%
  filter(key == "Praha")

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

dos_sochoros <- c("pplk. Sochora 4, Praha", # platná adresa
                  "pplk. Sochora 4, Čierná pri Čope") # neplatná adresa

# očekávané chyby - špatné zadání
expect_error(geocode()) # čekám chybu - není cíl
expect_error(geocode(rep(dos_sochoros[1], 648))) # čekám chybu - 648 > 500

# vrací se sf objekt
expect_s3_class(geocode(dos_sochoros[1]), "sf") # vrací se class sf

# CRS má očekávanou hodnotu
expect_equal(st_crs(geocode(dos_sochoros[1]))$epsg, 4326) # defaultní CRS = WGS84
expect_equal(st_crs(geocode(dos_sochoros[1], 5514))$epsg, 5514) # Křovák = Křovák

# chybná adresa:
expect_equal(geocode(dos_sochoros[2]), NA) # pokud neexistuje žádná adresa, tak NA
expect_lt(nrow(geocode(dos_sochoros)), length(dos_sochoros)) # pokud neexistují všechny, tak se vrátí míň než hledáno

# nejednoznačná adresa:
expect_gte(nrow(geocode("pplk. Sochora 4")), 1) # jedna v Praze, jedna v Brandýse: ergo víc jak 1

context("revgeo")

sochor_wgs <- geocode(dos_sochoros[1]) # podle WGS84
sochor_krovak <- geocode(dos_sochoros[1], 5514) # totéž, podle Křováka

tres_sochoros <- geocode(rep(dos_sochoros[1], 3)) # tři stejné adresy

# očekávané chyby - špatné zadání
expect_error(revgeo()) # čekám chybu - nejsou koordináty
expect_error(revgeo("bflm")) # čekám chybu - zadání není sf
expect_error(revgeo(kraje())) # čekám chybu - nejsou body ale polygony

# vrací se sf objekt
expect_equal(class(revgeo(sochor_wgs)), "character") # vrací se vektor charů

# koordináty v WGS84
expect_equal(revgeo(sochor_wgs), "Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7")

# koordináty ve Křovákovi
expect_equal(revgeo(sochor_krovak), "Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7")

# třikrát stejné koordináty = funguje vektorizace
expect_equal(unique(revgeo(tres_sochoros)), "Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7")




