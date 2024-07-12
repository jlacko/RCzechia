library(dplyr)
library(httr)

test_that("katastrální území", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(katastry(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(katastry()))

  expect_s3_class(katastry(), "sf")

  expect_equal(nrow(katastry()), 13076)

  expect_equal(st_crs(katastry())$input, "EPSG:4326")

  expect_true(all(st_is_valid(katastry())))

  expect_true(all(st_geometry_type(katastry()) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(katastry()), c("KOD", "NAZEV", "KOD_OBEC", "NAZ_OBEC", "digi", "geometry"))

  # území je pokryté
  expect_equal(sum(st_area(katastry())), st_area(republika("high")), tolerance = 5/100)


})
