#' Protected Natural Areas
#'
#' Function returning data frame of protected natural areas (Chráněná území) of the Czech Republic as \code{sf} polygons. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 114 KB.
#'
#'
#' @format \code{sf} data frame with 36 rows of 2 variables + geometry
#'
#' \describe{
#'   \item{TYP}{Type of protected area: Národní park, Chráněná krajinná oblast}
#'   \item{NAZEV}{Name, with Czech accents}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

chr_uzemi  <- function() {

  result <- downloader("ChrUzemi.rds")
  result
}
