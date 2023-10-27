#' Vyskopis
#'
#' Terrain of the Czech Republic as a `terra` package object.
#'
#' The function returns a raster file of either actual terrain (values are meters above sea level) or rayshaded relief.
#'
#' The raster is created from EU DEM 1.1 file by Copernicus Land Monitoring service. The original file has pixel resolution 25×25 meters, which is too detailed for purposes of the package and was downsampled by factor of 4.
#'
#' The extent of the raster file is bouding box of the Czech Republic; this is a change to prior versions in order to better facilitate use of the raster in natural sciences context. To preserve compatibility optional argument `cropped` has been created, defaulting to `TRUE` (i.e. behaviour before v1.10.0).
#'
#' Due to package size constraints both versions are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to year 2011 (but it is not expected to materially change over time). Downloaded size of the rasters is 70 MB, so proceed with caution.
#'
#' @param format Should the function return actual terrain (meters above sea level) or shaded relief (rayshaded). Allowed values are "actual" and "rayshaded".
#'
#' @param cropped Should the raster provide data over Czech Republic's bounding box (cropped = FALSE) or just actual borders (cropped = TRUE). Defaults to TRUE to preserve compatiblity with earlier versions.
#'
#' @return `terra` package SpatRaster
#'
#' @source Copernicus Land Monitoring service, with funding by the European Union. <https://land.copernicus.eu/imagery-in-situ/eu-dem>
#'
#' @examples
#' \donttest{
#' library(terra)
#'
#' # original extent - bounding box over Czech Republic
#' original_extent <- vyskopis("rayshaded", cropped = FALSE)
#'
#' plot(original_extent, col = gray.colors(16))
#'
#' # add plot of country borders, for context
#' plot(RCzechia::republika(),
#'      border = "red",
#'      col = NA,
#'      add = TRUE)
#'
#' # cropped to size - default behaviour
#' cropped_extent <- vyskopis("rayshaded")
#'
#' plot(cropped_extent, col = gray.colors(16))
#'
#' }
#' @export


vyskopis <- function(format = "rayshaded", cropped = TRUE) {
  if (!is.element(format, c("actual", "rayshaded"))) {
    stop(paste(format, "is not a valid format; recognized values are \"actual\" or \"rayshaded\"."))
  } # /if - valid format
  if (!is.element(cropped, c(TRUE, FALSE))) {
    stop(paste(cropped, "is not a valid value for cropped; recognized values are \"TRUE\" or \"FALSE\"."))
  } # /if - valid valid cropped

  if (format == "rayshaded") {
    result <- .downloader("vyskopis-shaded-dem.tif")
  } else {
    result <- .downloader("vyskopis-dem.tif")
  } # /if - download of result

  # need to handle CRAN policy
  if(cropped & !is.null(result)) result <- terra::crop(result, terra::vect(RCzechia::republika("low")), mask = TRUE)

  result
} # /function
