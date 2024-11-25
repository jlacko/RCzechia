library(dplyr)
library(httr)


test_that("silnice", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(silnice(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(silnice()))

  expect_s3_class(silnice(), "sf")

  expect_equal(nrow(silnice()), 59594)

  expect_equal(st_crs(silnice())$input, "EPSG:4326")

  expect_true(all(st_is_valid(silnice())))

  expect_true(all(st_geometry_type(silnice()) %in% c("MULTILINESTRING", "LINESTRING")))


  # dálnic je méně jak silnic
  expect_gt(sum(st_length(subset(silnice(), grepl("Silnice", silnice()$TRIDA)))),
            sum(st_length(subset(silnice(), grepl("Dálnice",silnice()$TRIDA)))))

  # sloupce se nerozbily...
  expect_equal(colnames(silnice()), c("TRIDA", "CISLO_SILNICE", "MEZINARODNI_OZNACENI", "geometry"))
})

test_that("železnice", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(zeleznice(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(zeleznice()))

  expect_s3_class(zeleznice(), "sf")

  expect_equal(nrow(zeleznice()), 9957)

  expect_equal(st_crs(zeleznice())$input, "EPSG:4326")

  expect_true(all(st_is_valid(zeleznice())))

  expect_true(all(st_geometry_type(zeleznice()) %in% c("MULTILINESTRING", "LINESTRING")))

  # normálních železnic je víc jak úzkokolejek
  expect_gt(sum(st_length(subset(zeleznice(), ROZCHODNOST == "standard"))),
            sum(st_length(subset(zeleznice(), ROZCHODNOST == "narrow"))))


  # sloupce se nerozbily...
  expect_equal(colnames(zeleznice()), c("ELEKTRIFIKACE", "KOLEJNOST",
                                        "ROZCHODNOST", "geometry"))
})
