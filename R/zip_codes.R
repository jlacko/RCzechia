#' ZIP Codes of the Czech Republic
#'
#' Function returning data frame of the 2 671 ZIP Code Areas for the Czech Republic as \code{sf} polygons. It takes a single parameter resolution - high res (default) or low res polygons.
#'
#' Note that there are a number of special ZIP Codes - e.g. 118 01 for Government of the Czech Republic (Strakova akademie / Nábřeží Edvarda Beneše 4). These are not listed here, as they do not relate to a specific delivery area but are in essence private.
#'
#' The geometry type is MULTIPOLYGON, as there are a number of non continuous areas of delivery.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to February 2021 (last update was in January 2020). Downloaded size of high resolution shapefile is 45 MB, size of the low res object is 2 MB.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @return \code{sf} data frame with 2 671 rows of 2 variables + geometry
#'
#' \describe{
#'   \item{PSC}{ZIP Code as string in format NNNNN.}
#'   \item{NAZ_POSTA}{Responsible Post Office}
#' }
#'
#' @source ČSÚ \url{https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu}
#'
#' @examples
#' \donttest{
#' library(sf)
#' library(dplyr)
#'
#' # residence of the Czech Prime Minister
#' kramarova_vila <- RCzechia::geocode("Gogolova 212, Praha 1")
#'
#' # ZIP code of the PM residence
#' kramarova_vila %>%
#'    st_join(RCzechia::zip_codes("low"), left = FALSE) %>%
#'    pull(PSC)
#' }
#' @export

zip_codes <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    result <- .downloader("zip-low-2021-02.rds")
  } else {
    result <- .downloader("zip-high-2021-02.rds")
  }
  result
}
