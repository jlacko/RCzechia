#' Woodland Areas
#'
#' Function returning data frame of woodland areas (lesy) of more than 30 hectares in are of the Czech Republic as \code{sf} polygons. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#' The data is current to January 2014. Downloaded size is 2.1 MB.
#'
#' @format \code{sf} data frame with 2.366 rows of geometry variable only
#'
#' @source © ArcČR, ARCDATA PRAHA, ZÚ, ČSÚ, 2016 \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-4-0}
#'
#' @export
lesy <- function() {
  result <- .downloader("Lesy.rds")
  result
}
