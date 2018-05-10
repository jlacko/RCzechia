#' Republika
#'
#' Boundaries of the Czech Republic as \code{sf} polygon.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size of high resolution shapefile is 949.7 KB.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @format \code{sf} data frame with 1 row of 1 variable + geometry:
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' \donttest{
#' library(sf)
#'
#' hranice <- republika()
#' plot(hranice, col = "white")
#' }
#' @export

republika <- function(resolution = "high") {

  if (!is.element(resolution, c("high", "low"))) stop("Unknown resolution!")

  if (resolution == "low") {

    return(republika_low_res)

  } else {

    remote_df <- 'http://rczechia.jla-data.net/Republika.rds'
    if (http_error(remote_df)) {

      stop('No internet connection or data source broken.')

    } else {

      local_df <- readRDS(url(remote_df))
      local_df

    }
  }
}
