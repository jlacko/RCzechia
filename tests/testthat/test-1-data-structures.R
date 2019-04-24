library(dplyr)
library(httr)
library(sf)

context("republika")
  expect_true(is.data.frame(republika()))
  expect_true(is.data.frame(republika("low")))
  expect_true(is.data.frame(republika("high")))

  expect_s3_class(republika(), "sf")
  expect_s3_class(republika("high"), "sf")
  expect_s3_class(republika("low"), "sf")

  expect_equal(nrow(republika()), 1)
  expect_equal(nrow(republika("low")), 1)
  expect_equal(nrow(republika("high")), 1)

  expect_equal(st_crs(republika("low"))$epsg, 4326)
  expect_equal(st_crs(republika("high"))$epsg, 4326)


  expect_error(republika("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_true(object.size(republika("low")) < object.size(republika("high")))
    # low res je menší než high res


context("kraje")
  expect_true(is.data.frame(kraje()))
  expect_true(is.data.frame(kraje("low")))
  expect_true(is.data.frame(kraje("high")))

  expect_s3_class(kraje(), "sf")
  expect_s3_class(kraje("high"), "sf")
  expect_s3_class(kraje("low"), "sf")

  expect_equal(nrow(kraje()), 14)
  expect_equal(nrow(kraje("low")), 14)
  expect_equal(nrow(kraje("high")), 14)

  expect_equal(st_crs(kraje("low"))$epsg, 4326)
  expect_equal(st_crs(kraje("high"))$epsg, 4326)

  expect_error(kraje("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_true(object.size(kraje("low")) < object.size(kraje("high")))
    # low res je menší než high res



context("okresy")

  expect_true(is.data.frame(okresy()))
  expect_true(is.data.frame(okresy("low")))
  expect_true(is.data.frame(okresy("high")))

  expect_s3_class(okresy(), "sf")
  expect_s3_class(okresy("high"), "sf")
  expect_s3_class(okresy("low"), "sf")

  expect_equal(nrow(okresy()), 77)
  expect_equal(nrow(okresy("low")), 77)
  expect_equal(nrow(okresy("high")), 77)

  expect_equal(st_crs(okresy("low"))$epsg, 4326)
  expect_equal(st_crs(okresy("high"))$epsg, 4326)

  expect_error(okresy("bflm")) # neznámé rozlišení - očekávám high(default) / low

  expect_true(object.size(okresy("low")) < object.size(okresy("high"))) # low res je menší než high res

context("ORP")
  expect_true(is.data.frame(orp_polygony()))

  expect_s3_class(orp_polygony(), "sf")

  expect_equal(nrow(orp_polygony()), 206)

  expect_equal(st_crs(orp_polygony())$epsg, 4326)

context("obce body")
  expect_true(is.data.frame(obce_body()))
  expect_equal(nrow(obce_body()), 6258)

  expect_equal(st_crs(obce_body())$epsg, 4326)

context("obce polygony")

  expect_true(is.data.frame(obce_polygony()))

  expect_s3_class(obce_polygony(), "sf")

  expect_equal(nrow(obce_polygony()), 6258)

  expect_equal(st_crs(obce_polygony())$epsg, 4326)

context("městské části")
  expect_true(is.data.frame(casti()))

  expect_s3_class(casti(), "sf")

  expect_equal(nrow(casti()), 142)

  expect_equal(st_crs(casti())$epsg, 4326)

context("vodní plochy")
  expect_true(is.data.frame(plochy()))

  expect_s3_class(plochy(), "sf")

  expect_equal(nrow(plochy()), 480)

  expect_equal(st_crs(plochy())$epsg, 4326)

context("řeky")
  expect_true(is.data.frame(reky()))

  expect_s3_class(reky(), "sf")

  expect_equal(nrow(reky()), 6198)

  expect_equal(st_crs(reky())$epsg, 4326)

context("silnice")
  expect_true(is.data.frame(silnice()))

  expect_s3_class(silnice(), "sf")

  expect_equal(nrow(silnice()), 18979)

  expect_equal(st_crs(silnice())$epsg, 4326)

context("železnice")
  expect_true(is.data.frame(zeleznice()))

  expect_s3_class(zeleznice(), "sf")

  expect_equal(nrow(zeleznice()), 3525)

  expect_equal(st_crs(zeleznice())$epsg, 4326)

context("chráněná území")
  expect_true(is.data.frame(chr_uzemi()))

  expect_s3_class(chr_uzemi(), "sf")

  expect_equal(nrow(chr_uzemi()), 36)

  expect_equal(st_crs(chr_uzemi())$epsg, 4326)

context("lesy")
  expect_true(is.data.frame(lesy()))

  expect_s3_class(lesy(), "sf")

  expect_equal(nrow(lesy()), 2366)

  expect_equal(st_crs(lesy())$epsg, 4326)

context("integrace")

  obec_praha <- obce_body() %>% # bod Praha (určitě správně)
    filter(KOD_LAU1 == "CZ0100")

  okres_praha <- okresy("low") %>% # low res "okres" Praha (zjednodušovaný)
    filter(KOD_LAU1 == "CZ0100")

  expect_equal(st_contains(republika("high"), okres_praha)[[1]], 1) # okres Praha je v republice
  expect_equal(st_contains(okres_praha, obec_praha)[[1]], 1)  # bod Praha je v okresu Praha
