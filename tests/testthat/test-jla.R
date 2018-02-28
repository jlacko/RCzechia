library(testthat)
asdf <- casti()
expect_that(is.data.frame(asdf), is_true())

asdf <- kraje()
expect_that(is.data.frame(asdf), is_true())

asdf <- obce_body()
expect_that(is.data.frame(asdf), is_true())

asdf <- obce_polygony()
expect_that(is.data.frame(asdf), is_true())

asdf <- okresy()
expect_that(is.data.frame(asdf), is_true())

asdf <- orp_polygony()
expect_that(is.data.frame(asdf), is_true())

asdf <- plochy()
expect_that(is.data.frame(asdf), is_true())

asdf <- reky()
expect_that(is.data.frame(asdf), is_true())

asdf <- republika()
expect_that(is.data.frame(asdf), is_true())
