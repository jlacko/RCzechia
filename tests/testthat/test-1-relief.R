library(dplyr)
library(httr)
library(terra)

test_that("reliéf", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(vyskopis(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_s4_class(vyskopis(), "SpatRaster")
  expect_s4_class(vyskopis("actual"), "SpatRaster")
  expect_s4_class(vyskopis("rayshaded"), "SpatRaster")
  expect_s4_class(vyskopis("actual", FALSE), "SpatRaster")
  expect_s4_class(vyskopis("rayshaded", FALSE), "SpatRaster")

  # test rozsahu
  expect_equal(vyskopis(cropped = FALSE)@ptr$extent$vector, c(11.98464, 19.32897, 48.22101, 51.37479), tolerance = 1e-5)
  expect_equal(vyskopis("actual", FALSE)@ptr$extent$vector, c(11.98464, 19.32897, 48.22101, 51.37479), tolerance = 1e-5)
  expect_equal(vyskopis("rayshaded", FALSE)@ptr$extent$vector, c(11.98464, 19.32897, 48.22101, 51.37479), tolerance = 1e-5)

  # test projekce - WGS84 pure & unadultered
  expect_equal(st_crs(vyskopis())$input, "WGS 84")
  expect_equal(st_crs(vyskopis("actual"))$input, "WGS 84")
  expect_equal(st_crs(vyskopis("rayshaded"))$input, "WGS 84")
  expect_equal(st_crs(vyskopis("actual", FALSE))$input, "WGS 84")
  expect_equal(st_crs(vyskopis("rayshaded", FALSE))$input, "WGS 84")

  # očekávaná chyba
  expect_error(vyskopis("bflm")) # neznámé rozlišení - očekávám actual / rayshaded
  expect_error(vyskopis("actual", cropped = "bflm")) # cropped usí být boolean
  expect_error(vyskopis("actual", cropped = NA))

})

