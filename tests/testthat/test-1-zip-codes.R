library(dplyr)
library(httr)

test_that("PSČ", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(zip_codes(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(zip_codes()))
  expect_true(is.data.frame(zip_codes("low")))
  expect_true(is.data.frame(zip_codes("high")))

  expect_s3_class(zip_codes(), "sf")
  expect_s3_class(zip_codes("high"), "sf")
  expect_s3_class(zip_codes("low"), "sf")

  expect_equal(nrow(zip_codes()), 2671)
  expect_equal(nrow(zip_codes("low")), 2671)
  expect_equal(nrow(zip_codes("high")), 2671)

  expect_equal(st_crs(zip_codes("low"))$input, "EPSG:4326")
  expect_equal(st_crs(zip_codes("high"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(zip_codes("high"))))
  expect_true(all(st_is_valid(zip_codes("low"))))

  # sloupce se nerozbily...
  expect_equal(colnames(zip_codes()), c("PSC", "NAZ_POSTA", "geometry"))
  expect_equal(colnames(zip_codes("high")), c("PSC", "NAZ_POSTA", "geometry"))
  expect_equal(colnames(zip_codes("low")), c("PSC", "NAZ_POSTA", "geometry"))

  expect_error(zip_codes("bflm")) # neznámé rozlišení - očekávám high(default) / low

  # low res je menší než high res
  expect_true(object.size(zip_codes("low")) < object.size(zip_codes("high")))
})

