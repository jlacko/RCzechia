library(dplyr)
library(httr)


test_that("historie platí", {

  skip_on_cran()

  eras <- c("okresy_1921",
            "okresy_1930",
            "okresy_1947",
            "okresy_1950",
            "okresy_1961",
            "okresy_1970",
            "okresy_1980",
            "okresy_1991",
            "okresy_2001",
            "okresy_2011",
            "kraje_1950",
            "kraje_1961",
            "kraje_1970",
            "kraje_1980",
            "kraje_1991",
            "kraje_2001",
            "kraje_2011")

  entities <- c("okresy_1921" = 328,
                "okresy_1930" = 330,
                "okresy_1947" = 163,
                "okresy_1950" = 182,
                "okresy_1961" = 76,
                "okresy_1970" = 76,
                "okresy_1980" = 76,
                "okresy_1991" = 76,
                "okresy_2001" = 77,
                "okresy_2011" = 77,
                "kraje_1950" = 13,
                "kraje_1961" = 8,
                "kraje_1970" = 8,
                "kraje_1980" = 8,
                "kraje_1991" = 8,
                "kraje_2001" = 14,
                "kraje_2011" = 14)


  for (doba in eras) {

    Sys.setenv("NETWORK_UP" = FALSE)
    expect_message(historie(doba), "internet") # zpráva o chybějícím internetu
    Sys.setenv("NETWORK_UP" = TRUE)

    expect_true(is.data.frame(historie(doba)))

    expect_s3_class(historie(doba), "sf")

    expect_equal(nrow(historie(doba)), unname(entities[doba]))

    expect_equal(sum(duplicated(colnames(historie(doba)))), 0) # sloupce bez duplicit v názvech

    expect_equal(st_crs(historie(doba))$input, "EPSG:4326")

    expect_true(all(st_is_valid(historie(doba))))

    expect_true(all(st_geometry_type(historie(doba)) %in% c("POLYGON", "MULTIPOLYGON")))

    # sloupece obsahují geometrii (ne geom nebo x)
    expect_true("geometry" %in% colnames(historie(doba)))

    # území je pokryté
    expect_equal(sum(st_area(historie(doba))), st_area(republika("high")), tolerance = 5/100)

  }

})


test_that("chyby zadání", {

  expect_error(historie("bflm")) # neznámá úroveň
  expect_error(historie()) # povinný argument bez defaultu

})


