#' Senate Districts (Volební obvod pro volby do Senátu) of the Czech Republic
#'
#' Function returning data frame of the 81 Senate Districts for the Czech Republic as \code{sf} polygons. It takes a single parameter resolution - high res (default) or low res polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to February 2021 (last update was in 2016). Downloaded size of high resolution shapefile is 10 MB, size of the low res object is negligible (but a working internet is still required, as the object is not internal).
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @return \code{sf} data frame with 81 rows of 3 variables + geometry
#'
#' \describe{
#'   \item{OBVOD}{Code of the district; left padded with zero in case of districts one to nine.}
#'   \item{SIDLO}{Seat of the senator.}
#'   \item{NAZEV_VO}{Formal name of the district.}
#' }
#'
#' @source ČSÚ \url{https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu}
#'
#' @examples
#' \donttest{
#' library(sf)
#'
#' senat <- senat_obvody("low")
#' plot(st_geometry(senat), col = "white")
#' nrow(senat) # 81, because the Constitution says so...
#' }
#' @export

senat_obvody <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    result <- .downloader("Senat-low-2021-02.rds")
  } else {
    result <- .downloader("Senat-high-2021-02.rds")
  }
  result
}
