library(dplyr)
library(httr)

test_that("obce body", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(obce_body(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(obce_body()))

  expect_s3_class(obce_body(), "sf")

  expect_equal(nrow(obce_body()), 6258)

  expect_equal(st_crs(obce_body())$input, "EPSG:4326")

  expect_true(all(st_is_valid(obce_body())))

  # sloupce se nerozbily...
  expect_equal(colnames(obce_body()), c("KOD_OBEC", "NAZ_OBEC", "KOD_POU", "NAZ_POU",
                                           "KOD_ORP", "NAZ_ORP", "KOD_OKRES", "KOD_LAU1", "NAZ_LAU1",
                                           "KOD_KRAJ", "KOD_CZNUTS3", "NAZ_CZNUTS3", "geometry"))
})


test_that("obce polygony", {

  skip_on_cran() # protože velký jak cyp...

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(obce_polygony(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(obce_polygony()))

  expect_s3_class(obce_polygony(), "sf")

  expect_equal(nrow(obce_polygony()), 6258)

  expect_equal(st_crs(obce_polygony())$input, "EPSG:4326")

  expect_true(all(st_is_valid(obce_polygony())))

  # sloupce se nerozbily...
  expect_equal(colnames(obce_polygony()), c("KOD_OBEC", "NAZ_OBEC", "KOD_POU", "NAZ_POU",
                                        "KOD_ORP", "NAZ_ORP", "KOD_OKRES", "KOD_LAU1", "NAZ_LAU1",
                                        "KOD_KRAJ", "KOD_CZNUTS3", "NAZ_CZNUTS3", "geometry"))

})
