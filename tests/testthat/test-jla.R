library(testthat)
library(httr)

context("republika")
  expect_that(is.data.frame(republika()), is_true())
  expect_equal(nrow(republika()), 1)

context("kraje")
  expect_that(is.data.frame(kraje()), is_true())
  expect_equal(nrow(kraje()), 14)


context("okresy")
  expect_that(is.data.frame(okresy()), is_true())
  expect_that(is.data.frame(okresy("low")), is_true())
  expect_that(is.data.frame(okresy("high")), is_true())

  expect_equal(nrow(okresy()), 77)
  expect_equal(nrow(okresy("low")), 77)
  expect_equal(nrow(okresy("high")), 77)

  expect_error(okresy("bflm")) # neznámé rozlišení - očekávám high(default) / low
  expect_that(object.size(okresy("low")) < object.size(okresy("high")), is_true()) # low res je menší než high res

context("ORP")
  expect_that(is.data.frame(orp_polygony()), is_true())
  expect_equal(nrow(orp_polygony()), 206)

context("obce body")
  expect_that(is.data.frame(obce_body()), is_true())
  expect_equal(nrow(obce_body()), 6258)

context("obce polygony")
  expect_that(is.data.frame(obce_polygony()), is_true())
  expect_equal(nrow(obce_polygony()), 6258)

context("městské části")
  expect_that(is.data.frame(casti()), is_true())
  expect_equal(nrow(casti()), 142)

context("vodní plochy")
  expect_that(is.data.frame(plochy()), is_true())
  expect_equal(nrow(plochy()), 480)

context("řeky")
  expect_that(is.data.frame(reky()), is_true())
  expect_equal(nrow(reky()), 6198)

