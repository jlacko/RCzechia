#' Vyskopis
#'
#' Terrain of the Czech Republic as a {terra} package object.
#'
#' The function returns a raster file of either actual terrain (values are meters above sea level) or rayshaded relief..
#'
#' The raster is created from EU DEM 1.1 file by Copernicus Land Monitoring service. The original file has pixel resolution 25×25 meters, which is too detailed for purposes of the package and was downsampled by factor of 4.
#'
#' The extent of the raster file is bouding box of the Czech Republic; this is a change to prior versions in order to better facilitate use of the raster in natural sciences context. To clip the raster to size consider applying `terra::crop()` as shown in the examples section.
#'
#' Due to package size constraints both versions are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to year 2011 (but it is not expected to materially change over time). Downloaded size of the rasters is 45 MB.
#'
#' @param format Should the function return actual terrain (meters above sea level) or shaded relief (rayshaded). Allowed values are "actual" and "rayshaded".
#'
#' @return \code{terra} package SpatRaster
#'
#' @source Copernicus Land Monitoring service, with funding by the European Union. \url{https://land.copernicus.eu/imagery-in-situ/eu-dem}
#'
#' @examples
#' \donttest{
#' library(terra)
#'
#' # original extent - bounding box over Czech Republic
#' original_extent <- vyskopis("rayshaded")
#'
#' plot(original_extent, col = gray.colors(16))
#' plot(RCzechia::republika(), col = "red", add = T)
#'
#' # cropped to size
#' cropped_extent <- crop(original_extent, vect(RCzechia::republika()), mask = T)
#'
#' plot(original_extent, col = gray.colors(16))
#'
#' }
#' @export


vyskopis <- function(format = "rayshaded") {
  if (!is.element(format, c("actual", "rayshaded"))) {
    stop(paste(format, "is not a valid format; recognized values are \"actual\" or \"rayshaded\"."))
  } # /if - valid resolution

  if (format == "rayshaded") {
    result <- .downloader("vyskopis-shaded-dem.tif")
  } else {
    result <- .downloader("vyskopis-dem.tif")
  } # /if - download of result

  result
} # /function
