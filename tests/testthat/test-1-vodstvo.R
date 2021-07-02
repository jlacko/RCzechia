library(dplyr)
library(httr)

test_that("vodní plochy", {

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(plochy(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("AWS_UP" = FALSE)
  expect_message(plochy(), "source") # zpráva o spadlém AWS
  Sys.setenv("AWS_UP" = TRUE)

  expect_true(is.data.frame(plochy()))

  expect_s3_class(plochy(), "sf")

  expect_equal(nrow(plochy()), 28011)

  expect_equal(st_crs(plochy())$input, "EPSG:4326")

  expect_true(all(st_is_valid(plochy())))

  # sloupce se nerozbily...
  expect_equal(colnames(plochy()), c("TYP", "NAZEV", "geometry"))
})

test_that("řeky", {

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(reky(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("AWS_UP" = FALSE)
  expect_message(reky(), "source") # zpráva o spadlém AWS
  Sys.setenv("AWS_UP" = TRUE)

  expect_error(reky(NA)) # parametr je povinný
  expect_error(reky("bflm")) # neznámý scope
  expect_error(reky(c("Praha", "Brno"))) # moc řek...

  expect_true(is.data.frame(reky()))
  expect_true(is.data.frame(reky("global")))
  expect_true(is.data.frame(reky("Praha")))
  expect_true(is.data.frame(reky("Brno")))

  expect_s3_class(reky(), "sf")
  expect_s3_class(reky("global"), "sf")
  expect_s3_class(reky("Praha"), "sf")
  expect_s3_class(reky("Brno"), "sf")

  expect_equal(nrow(reky()), 156657)
  expect_equal(nrow(reky("global")), 156657)
  expect_equal(nrow(reky("Praha")), 1)
  expect_equal(nrow(reky("Brno")), 2)

  expect_equal(st_crs(reky())$input, "EPSG:4326")
  expect_equal(st_crs(reky("global"))$input, "EPSG:4326")
  expect_equal(st_crs(reky("Praha"))$input, "EPSG:4326")
  expect_equal(st_crs(reky("Brno"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(reky())))
  expect_true(all(st_is_valid(reky("Praha"))))
  expect_true(all(st_is_valid(reky("Brno"))))

  # sloupce se nerozbily...
  expect_equal(colnames(reky()), c("TYP", "NAZEV", "Major" , "geometry"))
})
