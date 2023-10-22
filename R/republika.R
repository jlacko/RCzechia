#' Republika
#'
#' Boundaries of the Czech Republic as `sf` polygon.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The dataset is based on RUIAN data by the Czech cadastral office. If necessary you can download the most up to date raw dataset in VFR format (a special case of XML which is understood by GDAL) on <https://vdp.cuzk.cz/vdp/ruian/vymennyformat> (in Czech only).
#'
#' The data is current to June 2021. Downloaded size of high resolution shapefile is <1 MB.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @return `sf` data frame with 1 row of 1 variable + geometry:
#'
#' @source © ČÚZK, 2021 <https://vdp.cuzk.cz/>
#'
#' @examples
#' library(sf)
#'
#' hranice <- republika("low")
#' plot(hranice, col = "white")
#'
#' @export


republika <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    return(republika_low_res)
  } else {
    result <- .downloader("Republika-R-2022-04.rds")
    result
  }
}
