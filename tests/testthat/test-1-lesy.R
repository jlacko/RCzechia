library(dplyr)
library(httr)

test_that("lesy", {

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(lesy(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("AWS_UP" = FALSE)
  expect_message(lesy(), "source") # zpráva o spadlém AWS
  Sys.setenv("AWS_UP" = TRUE)

  expect_true(is.data.frame(lesy()))

  expect_s3_class(lesy(), "sf")

  expect_equal(nrow(lesy()), 2366)

  expect_equal(st_crs(lesy())$input, "EPSG:4326")

  expect_true(all(st_is_valid(lesy())))

  # sloupce se nerozbily...
  expect_equal(colnames(lesy()), c("geometry"))
})
