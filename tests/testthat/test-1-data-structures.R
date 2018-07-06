library(dplyr)
library(httr)
library(sf)

context("republika")
  expect_that(is.data.frame(republika()), is_true())
  expect_that(is.data.frame(republika("low")), is_true())
  expect_that(is.data.frame(republika("high")), is_true())

  expect_that(inherits(republika(), "sf"), is_true())
  expect_that(inherits(republika("high"), "sf"), is_true())
  expect_that(inherits(republika("low"), "sf"), is_true())

  expect_equal(nrow(republika()), 1)
  expect_equal(nrow(republika("low")), 1)
  expect_equal(nrow(republika("high")), 1)

  expect_equal(st_crs(republika("low"))$epsg, 4326)
  expect_equal(st_crs(republika("high"))$epsg, 4326)


  expect_error(republika("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_that(object.size(republika("low")) < object.size(republika("high")), is_true())
    # low res je menší než high res


context("kraje")
  expect_that(is.data.frame(kraje()), is_true())
  expect_that(is.data.frame(kraje("low")), is_true())
  expect_that(is.data.frame(kraje("high")), is_true())

  expect_that(inherits(kraje(), "sf"), is_true())
  expect_that(inherits(kraje("high"), "sf"), is_true())
  expect_that(inherits(kraje("low"), "sf"), is_true())

  expect_equal(nrow(kraje()), 14)
  expect_equal(nrow(kraje("low")), 14)
  expect_equal(nrow(kraje("high")), 14)

  expect_equal(st_crs(kraje("low"))$epsg, 4326)
  expect_equal(st_crs(kraje("high"))$epsg, 4326)

  expect_error(kraje("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_that(object.size(kraje("low")) < object.size(kraje("high")), is_true())
    # low res je menší než high res



context("okresy")

  expect_that(is.data.frame(okresy()), is_true())
  expect_that(is.data.frame(okresy("low")), is_true())
  expect_that(is.data.frame(okresy("high")), is_true())

  expect_that(inherits(okresy(), "sf"), is_true())
  expect_that(inherits(okresy("high"), "sf"), is_true())
  expect_that(inherits(okresy("low"), "sf"), is_true())

  expect_equal(nrow(okresy()), 77)
  expect_equal(nrow(okresy("low")), 77)
  expect_equal(nrow(okresy("high")), 77)

  expect_equal(st_crs(okresy("low"))$epsg, 4326)
  expect_equal(st_crs(okresy("high"))$epsg, 4326)

  expect_error(okresy("bflm")) # neznámé rozlišení - očekávám high(default) / low

  expect_that(object.size(okresy("low")) < object.size(okresy("high")), is_true()) # low res je menší než high res

context("ORP")
  expect_that(is.data.frame(orp_polygony()), is_true())

  expect_that(inherits(orp_polygony(), "sf"), is_true())

  expect_equal(nrow(orp_polygony()), 206)

  expect_equal(st_crs(orp_polygony())$epsg, 4326)

context("obce body")
  expect_that(is.data.frame(obce_body()), is_true())
  expect_equal(nrow(obce_body()), 6258)

  expect_equal(st_crs(obce_body())$epsg, 4326)

context("obce polygony")

  expect_that(is.data.frame(obce_polygony()), is_true())

  expect_that(inherits(obce_polygony(), "sf"), is_true())

  expect_equal(nrow(obce_polygony()), 6258)

  expect_equal(st_crs(obce_polygony())$epsg, 4326)

context("městské části")
  expect_that(is.data.frame(casti()), is_true())

  expect_that(inherits(casti(), "sf"), is_true())

  expect_equal(nrow(casti()), 142)

  expect_equal(st_crs(casti())$epsg, 4326)

context("vodní plochy")
  expect_that(is.data.frame(plochy()), is_true())

  expect_that(inherits(plochy(), "sf"), is_true())

  expect_equal(nrow(plochy()), 480)

  expect_equal(st_crs(plochy())$epsg, 4326)

context("řeky")
  expect_that(is.data.frame(reky()), is_true())

  expect_that(inherits(reky(), "sf"), is_true())

  expect_equal(nrow(reky()), 6198)

  expect_equal(st_crs(reky())$epsg, 4326)

context("silnice")
  expect_that(is.data.frame(silnice()), is_true())

  expect_that(inherits(silnice(), "sf"), is_true())

  expect_equal(nrow(silnice()), 18979)

  expect_equal(st_crs(silnice())$epsg, 4326)

context("železnice")
  expect_that(is.data.frame(zeleznice()), is_true())

  expect_that(inherits(zeleznice(), "sf"), is_true())

  expect_equal(nrow(zeleznice()), 3525)

  expect_equal(st_crs(zeleznice())$epsg, 4326)

context("chráněná území")
  expect_that(is.data.frame(chr_uzemi()), is_true())

  expect_that(inherits(chr_uzemi(), "sf"), is_true())

  expect_equal(nrow(chr_uzemi()), 36)

  expect_equal(st_crs(chr_uzemi())$epsg, 4326)

context("lesy")
  expect_that(is.data.frame(lesy()), is_true())

  expect_that(inherits(lesy(), "sf"), is_true())

  expect_equal(nrow(lesy()), 2366)

  expect_equal(st_crs(lesy())$epsg, 4326)

context("integrace")

  obec_praha <- obce_body() %>% # bod Praha (určitě správně)
    filter(KOD_LAU1 == "CZ0100")

  okres_praha <- okresy("low") %>% # low res "okres" Praha (zjednodušovaný)
    filter(KOD_LAU1 == "CZ0100")

  expect_equal(st_contains(republika("high"), okres_praha)[[1]], 1) # okres Praha je v republice
  expect_equal(st_contains(okres_praha, obec_praha)[[1]], 1)  # bod Praha je v okresu Praha
