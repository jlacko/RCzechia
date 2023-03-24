library(dplyr)
library(sf)

dos_sochoros <- c(
  "pplk. Sochora 4, Praha", # platná adresa
  "pplk. Sochora 4, Čierna pri Čope" # neplatná adresa
)

test_that("geocode", {

  skip_on_cran()

  skip_if_not(.ok_to_proceed("http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/find"),
              message = "skipping tests - CUZK API seems down")


  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geocode(dos_sochoros[1]), "internet") # není síť
  expect_s3_class(geocode(dos_sochoros[1]), "sf") # vrací se class sf
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("CUZK_UP" = FALSE)
  expect_message(geocode(dos_sochoros[1]), "API") # API down
  expect_s3_class(geocode(dos_sochoros[1]), "sf") # vrací se class sf
  Sys.setenv("CUZK_UP" = TRUE)

  # špatné zadání...
  expect_warning(geocode(), "missing") # adresa musí byť
  expect_warning(geocode(NA), "NAs") # NA není legitimní vstup / konvertoval by se na "NA"

  expect_warning(expect_s3_class(geocode(), "sf")) # nekorektní zadání není omluva struktury
  expect_warning(expect_s3_class(geocode(NA), "sf")) #  dtto - sf musí byť

  # vrací se sf objekt
  expect_s3_class(geocode(dos_sochoros[1]), "sf") # vrací se class sf

  # správné hlavičky sloupců
  expect_equal(geocode(dos_sochoros) %>% colnames(), c("address", "type", "result", "geometry"))

  # CRS má očekávanou hodnotu
  expect_equal(st_crs(geocode(dos_sochoros[1]))$epsg, 4326) # defaultní CRS = WGS84
  expect_equal(st_crs(geocode(dos_sochoros[1], 5514))$epsg, 5514) # Křovák = Křovák

  # očekávaná hodnota souřadnic známého bodu
  expect_equal(unname(st_coordinates(geocode(dos_sochoros[1]))[, "X"]), 14.4365531) # default = vrací WGS84
  expect_equal(unname(st_coordinates(geocode(dos_sochoros[1]))[, "Y"]), 50.1000536, tolerance = 1/100) # dtto...

  # chybná adresa:
  expect_message(geocode(dos_sochoros[2]), "no match") # když nejde, tak nejde...
  expect_s3_class(geocode(dos_sochoros[2]), "sf") # ... ale pořád sf!
  expect_lt(nrow(geocode(dos_sochoros)), length(dos_sochoros)) # pokud neexistují všechny, tak se vrátí míň než hledáno

  # nejednoznačná adresa:
  expect_gt(nrow(geocode("pplk. Sochora 4")), 1) # jedna v Praze, jedna v Brandýse: ergo víc jak 1

  # v Českých Budějovicích by chtěl žít každý...
  expect_equal(unname(st_coordinates(geocode("Dr. Stejskala 426/15, České Budějovice 1, České Budějovice"))[, "X"]), 14.4749019) # podle mapy.cz na 5 desetinek
  expect_equal(unname(st_coordinates(geocode("Dr. Stejskala 426/15, České Budějovice 1, České Budějovice"))[, "Y"]), 48.9727519) # dtto...
})


test_that("revgeo", {

  skip_on_cran()

  skip_if_not(.ok_to_proceed("http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/find"),
              message = "skipping tests - CUZK API seems down")

  sochor_wgs <- geocode(dos_sochoros[1]) # podle WGS84
  sochor_krovak <- st_transform(sochor_wgs, 5514) # totéž, dle Křováka

  amerika <- data.frame(
      place = c("Statue of Liberty", "Golden Gate Bridge"), # zcela jasně out of scope pro ČÚZK
      x = c(-74.044444, -122.478611),
      y = c(40.689167, 37.819722)
    ) %>%
    st_as_sf(coords = c("x", "y"), crs = 4326)

  tres_sochoros <- geocode(rep(dos_sochoros[1], 3)) # tři stejné adresy

  # očekávané chyby - špatné zadání
  expect_warning(revgeo()) # čekám chybu - nejsou koordináty
  expect_warning(revgeo("bflm")) # čekám chybu - zadání není sf
  expect_warning(revgeo(kraje())) # čekám chybu - nejsou body ale polygony

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(revgeo(sochor_wgs), "internet") # není síť
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("CUZK_UP" = FALSE)
  expect_message(revgeo(sochor_wgs), "API") # API down
  Sys.setenv("CUZK_UP" = TRUE)
  # vrací se sf objekt
  expect_s3_class(revgeo(sochor_wgs), "sf") # vrací se class sf

  # koordináty v WGS84
  expect_equal(revgeo(sochor_wgs)$revgeocoded, "Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7")

  # koordináty ve Křovákovi
  expect_equal(revgeo(sochor_krovak)$revgeocoded, "Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7")

  # třikrát stejné koordináty = funguje vektorizace
  expect_equal(revgeo(tres_sochoros)$revgeocoded, rep("Pplk. Sochora 1391/4, Holešovice, 17000 Praha 7", 3))

  # platný sf objekt, ale out of scope českého katastru
  expect_equal(revgeo(amerika)$revgeocoded %>% is.na() %>% unique(), TRUE) # vrací se pouze NA ...
})


