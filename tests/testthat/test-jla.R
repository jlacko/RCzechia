library(testthat)
library(httr)

context("casti")
  expect_that(is.data.frame(casti()), is_true())
  expect_equal(nrow(casti()), 142)

context("kraje")
  expect_that(is.data.frame(kraje()), is_true())
  expect_equal(nrow(kraje()), 14)

context("obce body")
  expect_that(is.data.frame(obce_body()), is_true())
  expect_equal(nrow(obce_body()), 6258)

context("obce polygony")
  expect_that(is.data.frame(obce_polygony()), is_true())
  expect_equal(nrow(obce_polygony()), 6258)

context("okresy")
  expect_that(is.data.frame(okresy()), is_true())
  expect_equal(nrow(okresy()), 77)

context("ORP")
  expect_that(is.data.frame(orp_polygony()), is_true())
  expect_equal(nrow(orp_polygony()), 206)

context("vodní plochy")
  expect_that(is.data.frame(plochy()), is_true())
  expect_equal(nrow(plochy()), 480)

context("řeky")
  expect_that(is.data.frame(reky()), is_true())
  expect_equal(nrow(reky()), 6198)

context("republika")
  expect_that(is.data.frame(republika()), is_true())
  expect_equal(nrow(republika()), 1)
