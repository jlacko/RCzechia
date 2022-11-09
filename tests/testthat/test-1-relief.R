library(dplyr)
library(httr)

test_that("reliéf", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(vyskopis(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_s4_class(vyskopis(), "RasterLayer")
  expect_s4_class(vyskopis("actual"), "RasterLayer")
  expect_s4_class(vyskopis("rayshaded"), "RasterLayer")

  # test velikosti
  expect_equal(vyskopis()@ncols, 5084) # sloupce jsou všechny
  expect_equal(vyskopis("actual")@ncols, 5084) # sloupce jsou všechny
  expect_equal(vyskopis("rayshaded")@ncols, 5084) # sloupce jsou všechny

  expect_equal(vyskopis()@nrows, 3403) # řádky jsou všechny
  expect_equal(vyskopis("actual")@nrows, 3403) # řádky jsou všechny
  expect_equal(vyskopis("rayshaded")@nrows, 3403) # řádky jsou všechny

  # test projekce - WGS84 pure & unadultered
  expect_equal(projection(crs(vyskopis())), "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
  expect_equal(projection(crs(vyskopis("actual"))), "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
  expect_equal(projection(crs(vyskopis("rayshaded"))), "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")

  # očekávaná chyba
  expect_error(vyskopis("bflm")) # neznámé rozlišení - očekávám actual / rayshaded
})

