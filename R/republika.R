#' Republika
#'
#' Boundaries of the Czech Republic as \code{sf} polygon.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size of high resolution shapefile is <1 MB.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @format \code{sf} data frame with 1 row of 1 variable + geometry:
#'
#' @source \url{https://vdp.cuzk.cz/}
#'
#' @examples
#' library(sf)
#'
#' hranice <- republika()
#' plot(hranice, col = "white")
#' @export


republika <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    return(republika_low_res)
  } else {
    result <- downloader("Republika-R.rds")
    result
  }
}
