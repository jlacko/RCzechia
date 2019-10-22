#' Vyskopis
#'
#' Relief of the Czech Republic as a {raster} package object.
#'
#' The function returns a raster file of either actual relief (values are meters above sea level) or rayshaded relief (created via highly recommended {rayshader} package).
#'
#' Due to package size constraints both versions are stored externally (and a working internet connection is required to use the package). Downloaded size of the rayshaded raster is 8.4 MB, actual raster is 31.4 MB.
#'
#' @param format Should the function return actual relief (meters above sea level) or shaded relief (rayshaded). Allowed values are "actual" and "rayshaded".
#'
#' @format \code{raster} package RasterLayer.
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' library(sf)
#'
#' hranice <- republika()
#' plot(hranice, col = "white")
#'
#' @export


vyskopis <- function(format = "rayshaded") {


  if (!is.element(format, c("actual", "rayshaded"))) {

    stop(paste(format, "is not a valid format; recognized values are \"actual\" or \"rayshaded\"."))

  } # /if - valid resolution

  if (format == "rayshaded") {

    result <- downloader("Vyskopis-stiny.rds")

  } else {

    result <- downloader("Vyskopis-vyska.rds")
  } # /if - download of result

  result
} # /function
