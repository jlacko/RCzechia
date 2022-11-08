library(dplyr)
library(sf)


test_that("očekávané chyby", {

  skip_on_cran()

  expect_false(.ok_to_proceed("http://httpbin.org/status/404")) # rozbitý zcela
  expect_false(.ok_to_proceed("http://httpbin.org/status/503")) # server down

  expect_message(.ok_to_proceed("http://httpbin.org/status/404"), "broken") # rozbitý zcela
  expect_message(.ok_to_proceed("http://httpbin.org/status/503"), "broken") # server down

  expect_message(.downloader("asdf_wtf")) # objekt neexistuje - message
  expect_warning(.downloader("asdf_wtf"), regexp = NA) # CRAN policy - graceful fail na neexistujícím objektu

})
