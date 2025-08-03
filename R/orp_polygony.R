#' Obce s rozsirenou pusobnosti
#'
#' Function returning data frame of municipalities with extended powers (obce s rozšířenou působností) as `sf` polygons. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The dataset is based on RUIAN data by the Czech cadastral office. If necessary you can download the most up to date raw dataset in VFR format (a special case of XML which is understood by GDAL) on <https://vdp.cuzk.cz/vdp/ruian/vymennyformat> (in Czech only).
#'
#' The data is current to July 2025. Downloaded size is 3.1 MB.
#'
#' @return `sf` data frame with 206 rows of 5 variables + geometry
#'
#' \describe{
#'   \item{KOD_ORP}{Code of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{NAZ_ORP}{Full name of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{KOD_KRAJ}{Code of the region (kraj).}
#'   \item{KOD_CZNUTS3}{Code of the NUTS3 unit (kraj)}
#'   \item{NAZ_CZNUTS3}{Name of the NUTS3 unit (kraj)}
#' }
#'
#' @source © ČÚZK, 2025 <https://vdp.cuzk.cz/>
#'
#' @export

orp_polygony <- function() {
  result <- .downloader("ORP-R-2025-07.rds")
  result
}
