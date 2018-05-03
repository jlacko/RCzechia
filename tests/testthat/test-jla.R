library(dplyr)
library(httr)
library(sf)

context("republika")
  expect_that(is.data.frame(republika()), is_true())
  expect_that(is.data.frame(republika("low")), is_true())
  expect_that(is.data.frame(republika("high")), is_true())

  expect_equal(nrow(republika()), 1)
  expect_equal(nrow(republika("low")), 1)
  expect_equal(nrow(republika("high")), 1)

  expect_equal(st_crs(republika("low"))$epsg, 4326)
  expect_equal(st_crs(republika("high"))$epsg, 4326)


  expect_error(republika("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_that(object.size(republika("low")) < object.size(republika("high")), is_true()) # low res je menší než high res


context("kraje")
  expect_that(is.data.frame(kraje()), is_true())
  expect_that(is.data.frame(kraje("low")), is_true())
  expect_that(is.data.frame(kraje("high")), is_true())


  expect_equal(nrow(kraje()), 14)
  expect_equal(nrow(kraje("low")), 14)
  expect_equal(nrow(kraje("high")), 14)

  expect_equal(st_crs(kraje("low"))$epsg, 4326)
  expect_equal(st_crs(kraje("high"))$epsg, 4326)

  expect_error(kraje("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_that(object.size(kraje("low")) < object.size(kraje("high")), is_true()) # low res je menší než high res



context("okresy")
  expect_that(is.data.frame(okresy()), is_true())
  expect_that(is.data.frame(okresy("low")), is_true())
  expect_that(is.data.frame(okresy("high")), is_true())

  expect_equal(nrow(okresy()), 77)
  expect_equal(nrow(okresy("low")), 77)
  expect_equal(nrow(okresy("high")), 77)

  expect_equal(st_crs(okresy("low"))$epsg, 4326)
  expect_equal(st_crs(okresy("high"))$epsg, 4326)

  expect_error(okresy("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_that(object.size(okresy("low")) < object.size(okresy("high")), is_true()) # low res je menší než high res

context("ORP")
  expect_that(is.data.frame(orp_polygony()), is_true())
  expect_equal(nrow(orp_polygony()), 206)

  expect_equal(st_crs(orp_polygony())$epsg, 4326)

context("obce body")
  expect_that(is.data.frame(obce_body()), is_true())
  expect_equal(nrow(obce_body()), 6258)

  expect_equal(st_crs(obce_body())$epsg, 4326)

context("obce polygony")

  obce_poly_loc <- obce_polygony() # jedno stažení místo tří...

  expect_that(is.data.frame(obce_poly_loc), is_true())
  expect_equal(nrow(obce_poly_loc), 6258)

  expect_equal(st_crs(obce_poly_loc)$epsg, 4326)

context("městské části")
  expect_that(is.data.frame(casti()), is_true())
  expect_equal(nrow(casti()), 142)

  expect_equal(st_crs(casti())$epsg, 4326)

context("vodní plochy")
  expect_that(is.data.frame(plochy()), is_true())
  expect_equal(nrow(plochy()), 480)

  expect_equal(st_crs(plochy())$epsg, 4326)

context("řeky")
  expect_that(is.data.frame(reky()), is_true())
  expect_equal(nrow(reky()), 6198)

  expect_equal(st_crs(reky())$epsg, 4326)

context("integrace")

  obec_praha <- obce_body() %>% # bod Praha (určitě správně)
    filter(KOD_LAU1 == "CZ0100")

  okres_praha <- okresy("low") %>% # low res "okres" Praha (zjednodušovaný)
    filter(KOD_LAU1 == "CZ0100")

  expect_equal(st_contains(republika("high"), okres_praha)[[1]], 1) # okres Praha je v republice
  expect_equal(st_contains(okres_praha, obec_praha)[[1]], 1)  # bod Praha je v okresu Praha

context("unionSF")

  wtf <- data.frame(col = c(1,2,3)) # data frame se sloupcem col

  expect_error(unionSF(wtf, "col")) # čekám chybu - není spatial
  expect_error(unionSF(okresy("low"))) # čekám chybu - chybí key
  expect_error(unionSF(key = "col")) # čekám chybu - chybí .data
  expect_error(unionSF(okresy("low"), "bflm")) # čekám chybu - není sloupec z data frame

  united_praha <- okresy("low") %>% # kraj Praha vzniklý spojením z okresů
    unionSF("KOD_CZNUTS3") %>%
    filter(key == 'CZ010')

  expect_equal(st_contains(republika("high"), united_praha)[[1]], 1) # spojený kraj Praha je v republice
  expect_equal(st_contains(united_praha, obec_praha)[[1]], 1)  # bod Praha je ve spojeném kraji Praha
  expect_equal(st_crs(okresy("low")), st_crs(united_praha)) # CRS vstupu = CRS výstupu



