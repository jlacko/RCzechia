library(dplyr)
library(httr)

test_that("vodní plochy", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(plochy(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(plochy()))

  expect_s3_class(plochy(), "sf")

  expect_equal(nrow(plochy()), 1769)

  expect_equal(st_crs(plochy())$input, "EPSG:4326")

  expect_true(all(st_is_valid(plochy())))

  expect_true(all(st_geometry_type(plochy()) %in% c("MULTIPOLYGON", "POLYGON")))

  # sloupce se nerozbily...
  expect_equal(colnames(plochy()), c("NAZEV", "VYSKA", "geometry"))

  # plocha sedí
  expect_lte(abs(sum(st_area(plochy())) - units::set_units(582905148, "m^2")), units::set_units(100, "m^2"))
})

test_that("řeky", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(reky(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_error(reky(NA)) # parametr je povinný
  expect_error(reky(resolution = "bflm")) # nezámé rozlišení
  expect_error(reky(resolution = 42)) # nezámé rozlišení
  expect_error(reky(resolution = NA)) # nezámé rozlišení
  expect_error(reky("bflm")) # neznámý scope
  expect_error(reky(c("Praha", "Brno"))) # moc řek...

  expect_true(is.data.frame(reky()))
  expect_true(is.data.frame(reky(resolution = "high")))
  expect_true(is.data.frame(reky(resolution = "low")))
  expect_true(is.data.frame(reky("global")))
  expect_true(is.data.frame(reky("Praha")))
  expect_true(is.data.frame(reky("Brno")))

  expect_s3_class(reky(), "sf")
  expect_s3_class(reky(resolution = "high"), "sf")
  expect_s3_class(reky(resolution = "low"), "sf")
  expect_s3_class(reky("global"), "sf")
  expect_s3_class(reky("Praha"), "sf")
  expect_s3_class(reky("Brno"), "sf")

  expect_equal(nrow(reky()), 3617)
  expect_equal(nrow(reky(resolution = "high")), 3617)
  expect_equal(nrow(reky(resolution = "low")), 3617)
  expect_equal(nrow(reky("global")), 3617)
  expect_equal(nrow(reky("Praha")), 1)
  expect_equal(nrow(reky("Brno")), 2)

  expect_equal(st_crs(reky())$input, "EPSG:4326")
  expect_equal(st_crs(reky("global"))$input, "EPSG:4326")
  expect_equal(st_crs(reky("Praha"))$input, "EPSG:4326")
  expect_equal(st_crs(reky("Brno"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(reky())))
  expect_true(all(st_is_valid(reky(resolution = "high"))))
  expect_true(all(st_is_valid(reky(resolution = "low"))))
  expect_true(all(st_is_valid(reky("Praha"))))
  expect_true(all(st_is_valid(reky("Brno"))))

  expect_true(all(st_geometry_type(reky()) %in% c("MULTILINESTRING", "LINESTRING")))
  expect_true(all(st_geometry_type(reky(resolution = "high")) %in% c("MULTILINESTRING", "LINESTRING")))
  expect_true(all(st_geometry_type(reky(resolution = "low")) %in% c("MULTILINESTRING", "LINESTRING")))
  expect_true(all(st_geometry_type(reky("Praha")) %in% c("MULTILINESTRING", "LINESTRING")))
  expect_true(all(st_geometry_type(reky("Brno")) %in% c("MULTILINESTRING", "LINESTRING")))

  # sloupce se nerozbily...
  expect_equal(colnames(reky()), c("TYP", "NAZEV", "Navigable", "Major" , "geometry"))
  expect_equal(colnames(reky(resolution = "high")), c("TYP", "NAZEV", "Navigable", "Major" , "geometry"))
  expect_equal(colnames(reky(resolution = "low")), c("TYP", "NAZEV", "Navigable", "Major" , "geometry"))

  # low res je menší než high res
  expect_true(object.size(reky(resolution = "low")) < object.size(reky(resolution = "high")))

  # délka sedí
  expect_lte(abs(sum(st_length(reky())) - units::set_units(42703820, "m")), units::set_units(1, "m"))
})
