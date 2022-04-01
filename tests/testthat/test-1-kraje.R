library(dplyr)
library(httr)

test_that("kraje", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(kraje(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("AWS_UP" = FALSE)
  expect_message(kraje(), "source") # zpráva o spadlém AWS
  Sys.setenv("AWS_UP" = TRUE)

  expect_true(is.data.frame(kraje()))
  expect_true(is.data.frame(kraje("low")))
  expect_true(is.data.frame(kraje("high")))

  expect_s3_class(kraje(), "sf")
  expect_s3_class(kraje("high"), "sf")
  expect_s3_class(kraje("low"), "sf")

  expect_equal(nrow(kraje()), 14)
  expect_equal(nrow(kraje("low")), 14)
  expect_equal(nrow(kraje("high")), 14)

  expect_equal(st_crs(kraje("low"))$input, "EPSG:4326")
  expect_equal(st_crs(kraje("high"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(kraje("high"))))
  expect_true(all(st_is_valid(kraje("low"))))

  # sloupce se nerozbily...
  expect_equal(colnames(kraje()), c("KOD_KRAJ", "KOD_CZNUTS3", "NAZ_CZNUTS3", "geometry"))

  expect_equal(colnames(kraje("low")),
               colnames(kraje("high")))

  # názvy se nerozbily...
  expect_equal(kraje("low")$NAZ_CZNUTS3,
               kraje("high")$NAZ_CZNUTS3)


  expect_error(kraje("bflm")) # neznámé rozlišení - očekávám high(default) / low

  # low res je menší než high res
  expect_true(object.size(kraje("low")) < object.size(kraje("high")))

  # Středočeský kraj má v sobě díru jménem Praha - plocha je plus mínus 1%
  stc_low <- kraje("low") %>%
    subset(KOD_CZNUTS3 == "CZ020")

  stc_high <- kraje("high") %>%
    subset(KOD_CZNUTS3 == "CZ020")

  expect_equal(st_area(stc_low), st_area(stc_high), tolerance = 1/100)

  # Jihočeský kraj je jeden polygon
  expect_equal(length(st_geometry(kraje("low")[kraje("low")$KOD_CZNUTS3 == "CZ031", ])), 1)
  expect_equal(length(st_geometry(kraje("high")[kraje("low")$KOD_CZNUTS3 == "CZ031", ])), 1)
  expect_equal(length(st_geometry(kraje()[kraje("low")$KOD_CZNUTS3 == "CZ031", ])), 1)
})
