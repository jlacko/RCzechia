#' Regions (kraje) of the Czech Republic
#'
#' Function returning data frame of NUTS3 administrative units for the Czech Republic as `sf` polygons. It takes a single parameter resolution - high res (default) or low res polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The dataset is based on RUIAN data by the Czech cadastral office. If necessary you can download the most up to date raw dataset in VFR format (a special case of XML which is understood by GDAL) on <https://vdp.cuzk.cz/vdp/ruian/vymennyformat> (in Czech only).
#'
#' The data is current to June 2021 (i.e changes introduced by act 51/2020 Sb. are reflected). Downloaded size of high resolution shapefile is <1 MB.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @return `sf` data frame with 14 rows of 3 variables + geometry
#'
#' \describe{
#'   \item{KOD_KRAJ}{Code of the region.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region as NUTS3 (kraj).}
#' }
#'
#' @source © ČÚZK, 2021 <https://vdp.cuzk.cz/>
#'
#' @examples
#' library(sf)
#'
#' colors <- rainbow(14) # legend colors
#'
#' hranice <- RCzechia::kraje("low")
#'
#' plot(hranice["KOD_CZNUTS3"],
#'      col = colors,
#'      main = "Czech Regions",
#'      xlim = st_bbox(hranice)[c(1, 3)] * c(1, 1.1))
#'
#' legend("right",
#'        hranice$KOD_CZNUTS3,
#'        fill = colors,
#'        bty = "n")
#'
#' @export

kraje <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    return(kraje_low_res)
  } else {
    result <- .downloader("Kraje-R-2021-06.rds")
    result
  }
}
