#' City Parts
#'
#' Function taking no parameters and returning data frame of districts of Prague and other major cities as \code{sf} polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to January 2016. Downloaded size is <1 MB.
#'
#'
#' @format \code{sf} data frame with 142 rows of 4 variables + geometry
#'
#' \describe{
#'   \item{KOD}{Code of the city part / kod mestske casti}
#'   \item{NAZEV}{Name of the city part / nazev mestske casti}
#'   \item{KOD_OBEC}{Code of the city}
#'   \item{NAZ_OBEC}{Name of the city}
#' }
#'
#' @source © ArcČR, ARCDATA PRAHA, ZÚ, ČSÚ, 2016 \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

casti <- function() {
  result <- downloader("casti.rds")
  result
}
