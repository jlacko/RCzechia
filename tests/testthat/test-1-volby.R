library(dplyr)
library(httr)

test_that("obvody senátu", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(senat_obvody(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(senat_obvody()))
  expect_true(is.data.frame(senat_obvody("low")))
  expect_true(is.data.frame(senat_obvody("high")))

  expect_s3_class(senat_obvody(), "sf")
  expect_s3_class(senat_obvody("high"), "sf")
  expect_s3_class(senat_obvody("low"), "sf")

  expect_equal(nrow(senat_obvody()), 81)
  expect_equal(nrow(senat_obvody("low")), 81)
  expect_equal(nrow(senat_obvody("high")), 81)

  expect_equal(st_crs(senat_obvody("low"))$input, "EPSG:4326")
  expect_equal(st_crs(senat_obvody("high"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(senat_obvody("high"))))
  expect_true(all(st_is_valid(senat_obvody("low"))))

  # sloupce se nerozbily...
  expect_equal(colnames(senat_obvody()), c("OBVOD", "SIDLO", "NAZEV_VO", "geometry"))
  expect_equal(colnames(senat_obvody("high")), c("OBVOD", "SIDLO", "NAZEV_VO", "geometry"))
  expect_equal(colnames(senat_obvody("low")), c("OBVOD", "SIDLO", "NAZEV_VO", "geometry"))

  expect_error(senat_obvody("bflm")) # neznámé rozlišení - očekávám high(default) / low

  # low res je menší než high res
  expect_true(object.size(senat_obvody("low")) < object.size(senat_obvody("high")))
})

test_that("volební okrsky", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(volebni_okrsky(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(volebni_okrsky()))
  expect_true(is.data.frame(volebni_okrsky("low")))
  expect_true(is.data.frame(volebni_okrsky("high")))

  expect_s3_class(volebni_okrsky(), "sf")
  expect_s3_class(volebni_okrsky("high"), "sf")
  expect_s3_class(volebni_okrsky("low"), "sf")

  expect_equal(nrow(volebni_okrsky()), 14761)
  expect_equal(nrow(volebni_okrsky("low")), 14761)
  expect_equal(nrow(volebni_okrsky("high")), 14761)

  expect_equal(st_crs(volebni_okrsky("low"))$input, "EPSG:4326")
  expect_equal(st_crs(volebni_okrsky("high"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(volebni_okrsky("high"))))
  expect_true(all(st_is_valid(volebni_okrsky("low"))))

  # sloupce se nerozbily...
  expect_equal(colnames(volebni_okrsky()), c("Kod", "Cislo", "ObecKod", "MomcKod", "KOD_LAU1", "KOD_CZNUTS3", "geometry"))
  expect_equal(colnames(volebni_okrsky("high")), c("Kod", "Cislo", "ObecKod", "MomcKod", "KOD_LAU1", "KOD_CZNUTS3", "geometry"))
  expect_equal(colnames(volebni_okrsky("low")), c("Kod", "Cislo", "ObecKod", "MomcKod", "KOD_LAU1", "KOD_CZNUTS3", "geometry"))

  expect_error(volebni_okrsky("bflm")) # neznámé rozlišení - očekávám high(default) / low

  # low res je menší než high res
  expect_true(object.size(volebni_okrsky("low")) < object.size(volebni_okrsky("high")))
})
