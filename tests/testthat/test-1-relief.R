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
  expect_equal(terra::expanse(vyskopis())$area, units::drop_units(st_area(republika("low"))), tolerance = 1/100)
  expect_equal(terra::expanse(vyskopis("actual"))$area, units::drop_units(st_area(republika("low"))), tolerance = 1/100)
  expect_equal(terra::expanse(vyskopis("rayshaded"))$area, units::drop_units(st_area(republika("low"))), tolerance = 1/100)

  # oříznutý raster je menší než surový
  expect_gt(terra::expanse(vyskopis(cropped = F))$area, terra::expanse(vyskopis(cropped = T))$area)
  expect_gt(terra::expanse(vyskopis("rayshaded", cropped = F))$area, terra::expanse(vyskopis("rayshaded", cropped = T))$area)
  expect_gt(terra::expanse(vyskopis("actual", cropped = F))$area, terra::expanse(vyskopis("actual", cropped = T))$area)

  # test projekce - WGS84 pure & unadultered
  expect_true(grepl("WGS 84", st_crs(vyskopis())$input))
  expect_true(grepl("WGS 84", st_crs(vyskopis("actual"))$input))
  expect_true(grepl("WGS 84", st_crs(vyskopis("rayshaded"))$input))
  expect_true(grepl("WGS 84", st_crs(vyskopis("actual", FALSE))$input))
  expect_true(grepl("WGS 84", st_crs(vyskopis("rayshaded", FALSE))$input))

  # očekávaná chyba
  expect_error(vyskopis("bflm")) # neznámé rozlišení - očekávám actual / rayshaded
  expect_error(vyskopis("actual", cropped = "bflm")) # cropped usí být boolean
  expect_error(vyskopis("actual", cropped = NA))

})

