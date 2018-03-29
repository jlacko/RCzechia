#' Regions (kraje) of the Czech Republic
#'
#' NUTS3 administrative unit for the Czech Republic.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size of high resolution shapefile is 2.9 MB (so use with caution, and patience).
#'
#' kraje() is a function returning a data frame; remember to use (possibly empty) brackets in your call.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#'
#' @format sf data frame with 14 rows of 3 variables + geometry
#'
#' \describe{
#'   \item{KOD_KRAJ}{Code of the region, primary key. Use this as key to add other data items.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region as NUTS3 (kraj).}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'#' @examples
#' library(sf)
#'
#' hranice <- kraje()
#' plot(hranice, col = "white", max.plot = 1)
#'
#'
#' @export

kraje <- function(resolution = "high") {

  if (!is.element(resolution, c("high", "low"))) stop("Unknown resolution!")

  if (resolution == "low") {

    return(kraje_low_res)

  } else {

    remote_df <- 'http://rczechia.jla-data.net/Kraje.rds'
    if (http_error(remote_df)) {

      stop('No internet connection or data source broken.')

    } else {

      local_df <- readRDS(url(remote_df))
      local_df

    }
  }
}
