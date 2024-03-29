#' Woodland Areas
#'
#' Function returning data frame of woodland areas (lesy) of more than 30 hectares in are of the Czech Republic as `sf` polygons. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#' The data is current to January 2014. Downloaded size is 2.1 MB.
#'
#' @return `sf` data frame with 2.366 rows of geometry variable only
#'
#' @source © ArcČR, ARCDATA PRAHA, ZÚ, ČSÚ, 2016 <https://www.arcdata.cz/cs-cz/produkty/data/arccr?rsource=https%3A%2F%2Fwww.arcdata.cz%2Fprodukty%2Fgeograficka-data%2Farccr-4>
#'
#' @export
lesy <- function() {
  result <- .downloader("Lesy.rds")
  result
}
