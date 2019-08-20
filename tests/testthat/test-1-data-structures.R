library(dplyr)
library(httr)
library(sf)

context("republika")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(republika(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

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

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(kraje(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

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

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(okresy(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

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

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(orp_polygony(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(orp_polygony()))

  expect_s3_class(orp_polygony(), "sf")

  expect_equal(nrow(orp_polygony()), 206)

  expect_equal(st_crs(orp_polygony())$epsg, 4326)

context("obce body")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(obce_body(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(obce_body()))

  expect_s3_class(obce_body(), "sf")

  expect_equal(nrow(obce_body()), 6258)

  expect_equal(st_crs(obce_body())$epsg, 4326)

context("obce polygony")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(obce_polygony(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(obce_polygony()))

  expect_s3_class(obce_polygony(), "sf")

  expect_equal(nrow(obce_polygony()), 6258)

  expect_equal(st_crs(obce_polygony())$epsg, 4326)

context("městské části")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(casti(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(casti()))

  expect_s3_class(casti(), "sf")

  expect_equal(nrow(casti()), 142)

  expect_equal(st_crs(casti())$epsg, 4326)

context("vodní plochy")

Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(plochy(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(plochy()))

  expect_s3_class(plochy(), "sf")

  expect_equal(nrow(plochy()), 480)

  expect_equal(st_crs(plochy())$epsg, 4326)

context("řeky")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(reky(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(reky()))

  expect_s3_class(reky(), "sf")

  expect_equal(nrow(reky()), 6198)

  expect_equal(st_crs(reky())$epsg, 4326)

context("silnice")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(silnice(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(silnice()))

  expect_s3_class(silnice(), "sf")

  expect_equal(nrow(silnice()), 18979)

  expect_equal(st_crs(silnice())$epsg, 4326)

context("železnice")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(zeleznice(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(zeleznice()))

  expect_s3_class(zeleznice(), "sf")

  expect_equal(nrow(zeleznice()), 3525)

  expect_equal(st_crs(zeleznice())$epsg, 4326)

context("chráněná území")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(chr_uzemi(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(chr_uzemi()))

  expect_s3_class(chr_uzemi(), "sf")

  expect_equal(nrow(chr_uzemi()), 36)

  expect_equal(st_crs(chr_uzemi())$epsg, 4326)

context("lesy")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(lesy(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(lesy()))

  expect_s3_class(lesy(), "sf")

  expect_equal(nrow(lesy()), 2366)

  expect_equal(st_crs(lesy())$epsg, 4326)

context("faunistické čtverce")

  expect_true(is.data.frame(KFME_grid()))

  expect_s3_class(KFME_grid(), "sf")

  expect_equal(nrow(KFME_grid()), 26*42) # čtverce jsou všechny
  expect_equal(nrow(KFME_grid("low")), 26*42) # čtverce jsou všechny
  expect_equal(nrow(KFME_grid("high")), 4*26*42) # čtverce jsou všechny

  expect_equal(KFME_grid("low")$ctverec %>% unique() %>% length(), 26*42) # názvy jsou unikátní
  expect_equal(KFME_grid("high")$ctverec %>% unique() %>% length(), 4*26*42) # názvy jsou unikátní

  expect_equal(st_crs(KFME_grid())$epsg, 4326)
  expect_equal(st_crs(KFME_grid("high"))$epsg, 4326)
  expect_equal(st_crs(KFME_grid("low"))$epsg, 4326)

  expect_error(KFME_grid("bflm")) # neznámé rozlišení - očekávám high(default) / low

  telc <- geocode("Telč") %>% # známý bod Telč
    filter(typ == "Obec")


  hrcava <- geocode("Hrčava") %>% # známý bod Hrčava
    filter(typ == "Obec")


  cernousy <- geocode("Černousy") %>% # známý bod Černousy
    filter(typ == "Obec")


  expect_equal(sf::st_intersection(KFME_grid("low"), telc)$ctverec, 6858) # bod Telč je ve velkém čtverci 6858
  expect_equal(sf::st_intersection(KFME_grid("high"), telc)$ctverec, "6858b") # bod Telč je v malém čtverci 6858b

  expect_equal(sf::st_intersection(KFME_grid("low"), hrcava)$ctverec, 6479) # bod Hrčava je ve velkém čtverci 6479
  expect_equal(sf::st_intersection(KFME_grid("high"), hrcava)$ctverec, "6479c") # bod Hrčava je v malém čtverci 6479c

  expect_equal(sf::st_intersection(KFME_grid("low"), cernousy)$ctverec, 4956) # bod Černousy je ve velkém čtverci 6479
  expect_equal(sf::st_intersection(KFME_grid("high"), cernousy)$ctverec, "4956c") # bod Černousy je v malém čtverci 6479c

context("integrace")

  obec_praha <- obce_body() %>% # bod Praha (určitě správně)
    filter(KOD_LAU1 == "CZ0100")

  okres_praha <- okresy("low") %>% # low res "okres" Praha (zjednodušovaný)
    filter(KOD_LAU1 == "CZ0100")

  ctverec_praha <- KFME_grid() %>%
    filter(ctverec == 5952) # čtverec "střed Prahy"

  expect_equal(st_contains(republika("high"), okres_praha)[[1]], 1) # okres Praha je v republice
  expect_equal(st_contains(okres_praha, obec_praha)[[1]], 1)  # bod Praha je v okresu Praha

  expect_equal(st_contains(okres_praha, ctverec_praha)[[1]], 1)  # čtverec Praha je v okresu Praha

