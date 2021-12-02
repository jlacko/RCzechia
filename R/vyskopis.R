#' Vyskopis
#'
#' Terrain of the Czech Republic as a {raster} package object.
#'
#' The function returns a raster file of either actual relief (values are meters above sea level) or rayshaded relief (created via highly recommended {rayshader} package).
#'
#' The raster is 5084 by 3403 cells, meaning each pixel is about 90 × 90 meters. It works the best at level of country or regions, at the level of a city or lower it may be somewhat grainy.
#'
#' Due to package size constraints both versions are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to September 2016. Downloaded size of the rayshaded raster is 8.4 MB, actual raster is 31.4 MB.
#'
#' @param format Should the function return actual relief (meters above sea level) or shaded relief (rayshaded). Allowed values are "actual" and "rayshaded".
#'
#' @return \code{raster} package RasterLayer.
#'
#' @source © ArcČR, ARCDATA PRAHA, ZÚ, ČSÚ, 2016 \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-4-0}
#'
#' @examples
#' \donttest{
#' library(raster)
#'
#' relief <- vyskopis("rayshaded")
#'
#' plot(relief, col = gray.colors(16))
#' }
#' @export


vyskopis <- function(format = "rayshaded") {
  if (!is.element(format, c("actual", "rayshaded"))) {
    stop(paste(format, "is not a valid format; recognized values are \"actual\" or \"rayshaded\"."))
  } # /if - valid resolution

  if (format == "rayshaded") {
    result <- .downloader("Vyskopis-stiny.rds")
  } else {
    result <- .downloader("Vyskopis-vyska.rds")
  } # /if - download of result

  result
} # /function
