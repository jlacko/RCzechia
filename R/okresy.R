#' Districts (okresy)
#'
#' Function returning data frame of LAU1 administrative units for the Czech Republic as `sf` polygons. It takes a single parameter resolution - high res (default) or low res polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The dataset is based on RUIAN data by the Czech cadastral office. If necessary you can download the most up to date raw dataset in VFR format (a special case of XML which is understood by GDAL) on <https://vdp.cuzk.cz/vdp/ruian/vymennyformat> (in Czech only).
#'
#' The data is current to June 2021 (i.e changes introduced by act 51/2020 Sb. are reflected). Downloaded size of high resolution shapefile 2.1 MB.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @return `sf` data frame with 77 rows of 6 variables + geometry
#'
#' \describe{
#'   \item{KOD_OKRES}{Code of the district (okres).}
#'   \item{KOD_LAU1}{Code of the district as LAU1 unit (okres).}
#'   \item{NAZ_LAU1}{Name of the district as LAU1 unit (okres).}
#'   \item{KOD_KRAJ}{Code of the region.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region (kraj).}
#' }
#'
#' @source © ČÚZK, 2021 <https://vdp.cuzk.cz/>
#'
#' @examples
#' library(sf)
#'
#' hranice <- okresy()
#' plot(st_geometry(hranice), col = "white")
#'
#' object.size(okresy("low"))
#' object.size(okresy("high"))
#'
#' @export

okresy <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    return(okresy_low_res)
  } else {
    result <- .downloader("Okresy-R-2021-06.rds")
    result
  }
}
