library(dplyr)
library(httr)

test_that("městské části", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(casti(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(casti()))

  expect_s3_class(casti(), "sf")

  expect_equal(nrow(casti()), 142)

  expect_equal(st_crs(casti())$input, "EPSG:4326")

  expect_true(all(st_is_valid(casti())))

  # sloupce se nerozbily...
  expect_equal(colnames(casti()), c("KOD", "NAZEV", "KOD_OBEC", "NAZ_OBEC", "geometry"))
})
