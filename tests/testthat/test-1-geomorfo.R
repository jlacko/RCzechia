library(dplyr)
library(httr)


test_that("systém", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("system"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("system")))

  expect_s3_class(geomorfo("system"), "sf")

  expect_equal(nrow(geomorfo("system")), 2)

  expect_equal(st_crs(geomorfo("system"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("system"))))

  expect_true(all(st_geometry_type(geomorfo("system")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("system")), c("system", "geometry"))

})

test_that("subsystem", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("subsystem"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("subsystem")))

  expect_s3_class(geomorfo("subsystem"), "sf")

  expect_equal(nrow(geomorfo("subsystem")), 4)

  expect_equal(st_crs(geomorfo("subsystem"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("subsystem"))))

  expect_true(all(st_geometry_type(geomorfo("subsystem")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("subsystem")), c("system", "subsystem", "kod", "geometry"))

})

test_that("provincie", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("provincie"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("provincie")))

  expect_s3_class(geomorfo("provincie"), "sf")

  expect_equal(nrow(geomorfo("provincie")), 4)

  expect_equal(st_crs(geomorfo("provincie"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("provincie"))))

  expect_true(all(st_geometry_type(geomorfo("provincie")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("provincie")), c("provincie", "geometry"))

})

test_that("subprovincie", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("subprovincie"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("subprovincie")))

  expect_s3_class(geomorfo("subprovincie"), "sf")

  expect_equal(nrow(geomorfo("subprovincie")), 10)

  expect_equal(st_crs(geomorfo("subprovincie"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("subprovincie"))))

  expect_true(all(st_geometry_type(geomorfo("subprovincie")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("subprovincie")), c("subprovincie", "kod", "geometry"))

})

test_that("oblast", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("oblast"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("oblast")))

  expect_s3_class(geomorfo("oblast"), "sf")

  expect_equal(nrow(geomorfo("oblast")), 27)

  expect_equal(st_crs(geomorfo("oblast"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("oblast"))))

  expect_true(all(st_geometry_type(geomorfo("oblast")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("oblast")), c("subprovincie", "oblast", "kod", "geometry"))

})

test_that("celek", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("celek"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("celek")))

  expect_s3_class(geomorfo("celek"), "sf")

  expect_equal(nrow(geomorfo("celek")), 93)

  expect_equal(st_crs(geomorfo("celek"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("celek"))))

  expect_true(all(st_geometry_type(geomorfo("celek")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("celek")), c("subprovincie", "oblast", "celek", "kod", "geometry"))

})

test_that("podcelek", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("podcelek"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("podcelek")))

  expect_s3_class(geomorfo("podcelek"), "sf")

  expect_equal(nrow(geomorfo("podcelek")), 254)

  expect_equal(st_crs(geomorfo("podcelek"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("podcelek"))))

  expect_true(all(st_geometry_type(geomorfo("podcelek")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("podcelek")), c("subprovincie", "oblast", "celek", "podcelek", "kod", "geometry"))

})

test_that("okrsek", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(geomorfo("okrsek"), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(geomorfo("okrsek")))

  expect_s3_class(geomorfo("okrsek"), "sf")

  expect_equal(nrow(geomorfo("okrsek")), 933)

  expect_equal(st_crs(geomorfo("okrsek"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(geomorfo("okrsek"))))

  expect_true(all(st_geometry_type(geomorfo("okrsek")) == "MULTIPOLYGON"))

  # sloupce se nerozbily...
  expect_equal(colnames(geomorfo("okrsek")), c("subprovincie", "oblast", "celek", "podcelek", "okrsek", "kod", "geometry"))

})

test_that("chyby zadání", {

  expect_error(geomorfo("bflm")) # neznámá úroveň
  expect_error(geomorfo()) # povinný argument bez defaultu

})


