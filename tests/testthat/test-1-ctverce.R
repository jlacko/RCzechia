library(dplyr)
library(httr)

test_that("faunistické čtverce", {

  expect_true(is.data.frame(KFME_grid()))

  expect_s3_class(KFME_grid(), "sf")

  expect_equal(nrow(KFME_grid()), 26 * 42) # čtverce jsou všechny
  expect_equal(nrow(KFME_grid("low")), 26 * 42) # čtverce jsou všechny
  expect_equal(nrow(KFME_grid("high")), 4 * 26 * 42) # čtverce jsou všechny

  expect_equal(KFME_grid("low")$ctverec %>% unique() %>% length(), 26 * 42) # názvy jsou unikátní
  expect_equal(KFME_grid("high")$ctverec %>% unique() %>% length(), 4 * 26 * 42) # názvy jsou unikátní

  expect_equal(st_crs(KFME_grid())$input, "EPSG:4326")
  expect_equal(st_crs(KFME_grid("high"))$input, "EPSG:4326")
  expect_equal(st_crs(KFME_grid("low"))$input, "EPSG:4326")

  expect_true(all(st_is_valid(KFME_grid())))
  expect_true(all(st_is_valid(KFME_grid("high"))))
  expect_true(all(st_is_valid(KFME_grid("low"))))

  expect_error(KFME_grid("bflm")) # neznámé rozlišení - očekávám high(default) / low

})
