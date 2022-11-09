library(dplyr)
library(httr)

test_that("okresy", {

  skip_on_cran()

  Sys.setenv("NETWORK_UP" = FALSE)
  expect_message(okresy(), "internet") # zpráva o chybějícím internetu
  Sys.setenv("NETWORK_UP" = TRUE)

  expect_true(is.data.frame(okresy()))
  expect_true(is.data.frame(okresy("low")))
  expect_true(is.data.frame(okresy("high")))

  expect_s3_class(okresy(), "sf")
  expect_s3_class(okresy("high"), "sf")
  expect_s3_class(okresy("low"), "sf")

  expect_equal(nrow(okresy()), 77)
  expect_equal(nrow(okresy("low")), 77)
  expect_equal(nrow(okresy("high")), 77)

  expect_equal(st_crs(okresy("low"))$input, "EPSG:4326")
  expect_equal(st_crs(okresy("high"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(okresy("high"))))
  expect_true(all(st_is_valid(okresy("low"))))

  # sloupce se nerozbily...
  expect_equal(colnames(okresy()), c("KOD_OKRES", "KOD_LAU1", "NAZ_LAU1", "KOD_KRAJ",
                                     "KOD_CZNUTS3", "NAZ_CZNUTS3", "geometry"))

  # názvy se nerozbily...
  expect_equal(okresy("low")$NAZ_CZNUTS3,
               okresy("high")$NAZ_CZNUTS3)

  expect_equal(okresy("low")$NAZ_LAU1,
               okresy("high")$NAZ_LAU1)

  expect_equal(colnames(okresy("low")),
               colnames(okresy("high")))

  expect_error(okresy("bflm")) # neznámé rozlišení - očekávám high(default) / low

  # low res je menší než high res
  expect_true(object.size(okresy("low")) < object.size(okresy("high")))
})
