#' Regions (kraje) of the Czech Republic
#'
#' Function returning data frame of NUTS3 administrative units for the Czech Republic as \code{sf} polygons. It takes a single parameter resolution - high res (default) or low res polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size of high resolution shapefile is 2.9 MB (so use with caution, and patience).
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @format \code{sf} data frame with 14 rows of 3 variables + geometry
#'
#' \describe{
#'   \item{KOD_KRAJ}{Code of the region, primary key. Use this as key to add other data items.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region as NUTS3 (kraj).}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' library(sf)
#'
#' hranice <- kraje()
#' plot(hranice, col = "white", max.plot = 1)
#' @export

kraje <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    return(kraje_low_res)
  } else {
    result <- downloader("Kraje.rds")
    result
  }
}
