library(dplyr)
library(httr)

test_that("republika", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(republika(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(republika()))
  expect_true(is.data.frame(republika("low")))
  expect_true(is.data.frame(republika("high")))

  expect_s3_class(republika(), "sf")
  expect_s3_class(republika("high"), "sf")
  expect_s3_class(republika("low"), "sf")

  expect_equal(nrow(republika()), 1)
  expect_equal(nrow(republika("low")), 1)
  expect_equal(nrow(republika("high")), 1)

  # republika je bez děr
  expect_equal(lengths(sf::st_geometry(republika())), 1)
  expect_equal(lengths(sf::st_geometry(republika("low"))), 1)
  expect_equal(lengths(sf::st_geometry(republika("high"))), 1)

  expect_equal(st_crs(republika("low"))$input, "EPSG:4326")
  expect_equal(st_crs(republika("high"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(republika("high"))))
  expect_true(all(st_is_valid(republika("low"))))

  expect_true(all(st_geometry_type(republika("low")) %in% c("POLYGON")))
  expect_true(all(st_geometry_type(republika("high")) %in% c("POLYGON")))

  # sloupce se nerozbily...
  expect_equal(colnames(republika()), c("NAZ_STAT", "geometry"))

  expect_equal(colnames(republika("low")),
               colnames(republika("high")))

  # názvy se nerozbily...
  expect_equal(republika("low")$NAZ_STAT,
               republika("high")$NAZ_STAT)

  expect_error(republika("bflm")) # neznámé rozlišení - očekávám high(default) / low

  # low res je menší než high res
  expect_true(object.size(republika("low")) < object.size(republika("high")))
})
