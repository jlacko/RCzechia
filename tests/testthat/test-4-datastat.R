library(dplyr)
library(sf)

test_that("catalogue", {

  skip_on_cran()
#  skip_on_ci() # so far not stable enough...

  skip_if_not(.ok_to_proceed("https://data.csu.gov.cz/api/katalog/v1/swagger-ui/index.html#/"),
              message = "skipping tests - CZSO API seems down")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(datastat_catalogue(), "internet") # není síť
  expect_no_error(datastat_catalogue()) # fail, but graceful
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("CZSO_UP" = FALSE)
  expect_message(datastat_catalogue(), "API") # API down
  expect_no_error(datastat_catalogue()) # fail, but graceful
  Sys.setenv("CZSO_UP" = TRUE)

  expect_true(is.data.frame(datastat_catalogue())) # vrací dataframe ...
  expect_gt(nrow(datastat_catalogue()), 0) # ... s více než 1 řádkem

})


test_that("dataset", {

  skip_on_cran()
#  skip_on_ci() # so far not stable enough...

  skip_if_not(.ok_to_proceed("https://data.csu.gov.cz/api/katalog/v1/swagger-ui/index.html#/"),
              message = "skipping tests - CZSO API seems down")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(datastat_dataset("NEZ01"), "internet") # není síť
  expect_no_error(datastat_dataset("NEZ01")) # fail, but graceful
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("CZSO_UP" = FALSE)
  expect_message(datastat_dataset("NEZ01"), "API") # API down
  expect_no_error(datastat_dataset("NEZ01")) # fail, but graceful
  Sys.setenv("CZSO_UP" = TRUE)

  expect_true(is.data.frame(datastat_dataset("NEZ01"))) # vrací dataframe ...
  expect_gt(nrow(datastat_dataset("NEZ01")), 0) # ... s více než 1 řádkem

})

test_that("metrics", {

  skip_on_cran()
  #  skip_on_ci() # so far not stable enough...

  skip_if_not(.ok_to_proceed("https://data.csu.gov.cz/api/katalog/v1/swagger-ui/index.html#/"),
              message = "skipping tests - CZSO API seems down")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(datastat_metrics(), "internet") # není síť
  expect_no_error(datastat_metrics()) # fail, but graceful
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("CZSO_UP" = FALSE)
  expect_message(datastat_metrics(), "API") # API down
  expect_no_error(datastat_metrics()) # fail, but graceful
  Sys.setenv("CZSO_UP" = TRUE)

  expect_true(is.data.frame(datastat_metrics())) # vrací dataframe ...
  expect_gt(nrow(datastat_metrics()), 0) # ... s více než 1 řádkem

})


test_that("dimensions", {

  skip_on_cran()
  #  skip_on_ci() # so far not stable enough...

  skip_if_not(.ok_to_proceed("https://data.csu.gov.cz/api/katalog/v1/swagger-ui/index.html#/"),
              message = "skipping tests - CZSO API seems down")

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(datastat_dimensions(), "internet") # není síť
  expect_no_error(datastat_dimensions()) # fail, but graceful
  Sys.setenv("NETWORK_UP" = TRUE)

  Sys.setenv("CZSO_UP" = FALSE)
  expect_message(datastat_dimensions(), "API") # API down
  expect_no_error(datastat_dimensions()) # fail, but graceful
  Sys.setenv("CZSO_UP" = TRUE)

  expect_true(is.data.frame(datastat_dimensions())) # vrací dataframe ...
  expect_gt(nrow(datastat_dimensions()), 0) # ... s více než 1 řádkem

})

