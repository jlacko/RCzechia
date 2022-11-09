library(dplyr)
library(httr)


test_that("ORP", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(orp_polygony(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(orp_polygony()))

  expect_s3_class(orp_polygony(), "sf")

  expect_equal(nrow(orp_polygony()), 206) # 205 "skutečných" ORP + Praha

  expect_equal(st_crs(orp_polygony())$input, "EPSG:4326")

  expect_true(all(st_is_valid(orp_polygony())))

  # sloupce se nerozbily...
  expect_equal(colnames(orp_polygony()), c("KOD_ORP", "NAZ_ORP", "KOD_KRAJ",
                                           "KOD_CZNUTS3", "NAZ_CZNUTS3", "geometry"))
})
