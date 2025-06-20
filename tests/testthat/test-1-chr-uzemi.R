library(dplyr)
library(httr)


test_that("chráněná území", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(chr_uzemi(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(chr_uzemi()))

  expect_s3_class(chr_uzemi(), "sf")

  expect_equal(nrow(chr_uzemi()), 2712)

  expect_equal(st_crs(chr_uzemi())$input, "EPSG:4326")

  expect_true(all(st_is_valid(chr_uzemi())))

  expect_true(all(st_geometry_type(chr_uzemi()) %in% c("MULTIPOLYGON", "POLYGON")))

  # sloupce se nerozbily...
  expect_equal(colnames(chr_uzemi()), c("TYP", "NAZEV", "PLOCHA", "geometry"))

})

