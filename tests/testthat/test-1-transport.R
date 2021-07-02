library(dplyr)
library(httr)


test_that("silnice", {

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(silnice(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("AWS_UP" = FALSE)
  expect_message(silnice(), "source") # zpráva o spadlém AWS
  Sys.setenv("AWS_UP" = TRUE)

  expect_true(is.data.frame(silnice()))

  expect_s3_class(silnice(), "sf")

  expect_equal(nrow(silnice()), 41028)

  expect_equal(st_crs(silnice())$input, "EPSG:4326")

  expect_true(all(st_is_valid(silnice())))

  # sloupce se nerozbily...
  expect_equal(colnames(silnice()), c("TRIDA", "CISLO_SILNICE", "geometry"))
})

test_that("železnice", {

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(zeleznice(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("AWS_UP" = FALSE)
  expect_message(zeleznice(), "source") # zpráva o spadlém AWS
  Sys.setenv("AWS_UP" = TRUE)

  expect_true(is.data.frame(zeleznice()))

  expect_s3_class(zeleznice(), "sf")

  expect_equal(nrow(zeleznice()), 1159)

  expect_equal(st_crs(zeleznice())$input, "EPSG:4326")

  expect_true(all(st_is_valid(zeleznice())))

  # sloupce se nerozbily...
  expect_equal(colnames(zeleznice()), c("ELEKTRIFIKACE", "KOLEJNOST",
                                        "ROZCHODNOST", "geometry"))
})
