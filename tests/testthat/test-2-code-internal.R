library(dplyr)
library(sf)


test_that("očekávané chyby", {

  skip_on_cran()

  expect_false(.ok_to_proceed("http://httpbin.org/status/404")) # rozbitý zcela
  expect_false(.ok_to_proceed("http://httpbin.org/status/503")) # server down

  expect_message(.ok_to_proceed("http://httpbin.org/status/404"), "broken") # rozbitý zcela
  expect_message(.ok_to_proceed("http://httpbin.org/status/503"), "broken") # server down

  expect_no_error(.ok_to_proceed("http://httpbin.org/status/404")) # fail, but graceful
  expect_no_error(.ok_to_proceed("http://httpbin.org/status/503")) # fail, but graceful

  expect_message(.downloader("asdf_wtf")) # objekt neexistuje - message
  expect_no_error(.downloader("asdf_wtf")) # fail, but graceful
  expect_warning(.downloader("asdf_wtf"), regexp = NA) # CRAN policy - graceful fail na neexistujícím objektu

  expect_false(.ok_to_proceed("http://10.255.255.1")) # non-routable IP address - should timeout
  expect_false(.ok_to_proceed("http://10.255.255.1")) # non-routable IP address - should timeout

  expect_message(.ok_to_proceed("http://10.255.255.1")) # non-routable IP address - should timeout
  expect_no_error(.ok_to_proceed("http://10.255.255.1")) # timeout, but graceful
  expect_warning(.ok_to_proceed("http://10.255.255.1"), regexp = NA) # non-routable IP address - should timeout

  expect_true(.ok_to_proceed("http://rczechia.jla-data.net/Republika.rds")) # síť běží...

  Sys.setenv("NETWORK_UP" = FALSE)

  expect_false(.ok_to_proceed("http://rczechia.jla-data.net/Republika.rds")) # síť je "down"...
  expect_message(.ok_to_proceed("http://rczechia.jla-data.net/Republika.rds"), "internet") # není síť
  expect_no_error(.ok_to_proceed("http://rczechia.jla-data.net/Republika.rds")) # fail, ale graceful

  expect_message(.downloader("republika"), "internet") # není síť
  expect_no_error(.downloader("republika")) # fail, ale graceful


  expect_warning(.ok_to_proceed("http://rczechia.jla-data.net/Republika.rds"), regexp = NA) # není síť / ale je cran policy
  expect_warning(.downloader("republika"), regexp = NA) # není síť / ale je cran policy
  Sys.unsetenv("NETWORK_UP")

  expect_true(.ok_to_proceed("file:///~/Downloads/asdf_wtf")) # lokální objekt má pass..

})


test_that("envir variable", {

  skip_on_cran()

  envir_backup <- Sys.getenv("RCZECHIA_HOME") # uložit systémovou hodnotu do zálohy

  expect_true(set_home((tempdir()))) # nastavení na tempdir projde

  expect_warning(set_home("bflm"), regexp = "path") # neexistiující cesta

  expect_true(set_home((tempdir()))) # nastavení na tempdir projde

  set_home((tempdir()))

  expect_message(.rhome_state(), "Using local RCzechia cache at") # když je home nastaven, tak vyjde hláška

  expect_true(unset_home()) # vysazení projde

  if(envir_backup != "")  Sys.setenv("RCZECHIA_HOME" = envir_backup) # obnovit hodnotu ze zálohy, pokud dává smysl

})



