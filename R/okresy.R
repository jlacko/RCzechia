#' Districts (okresy)
#'
#' LAU1 administrative unit for the Czech Republic.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size of high resolution shapefile is 6.1 MB (so use with caution, and patience).
#'
#' okresy() is a function returning a data frame; remember to use (possibly empty) brackets in your call.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @format sf data frame with 77 rows of 6 variables + geometry
#'
#' \describe{
#'   \item{KOD_OKRES}{Code of the district (okres).}
#'   \item{KOD_LAU1}{Code of the district as LAU1 unit (okres), primary key. Use this as key to add other data items.}
#'   \item{NAZ_LAU1}{Name of the district as LAU1 unit (okres).}
#'   \item{KOD_KRAJ}{Code of the region.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region (kraj).}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' library(sf)
#'
#' hranice <- okresy()
#' plot(hranice, col = "white", max.plot = 1)
#'
#' @export
#' @importFrom httr http_error

okresy <- function(resolution = "high") {

  if (!is.element(resolution, c("high", "low"))) stop("Unknown resolution!")

  if (resolution == "low") {

    return(okresy_low_res)

        } else {

    remote_df <- 'http://rczechia.jla-data.net/Okresy.rds'
    if (http_error(remote_df)) {

      stop('No internet connection or data source broken.')

    } else {

      local_df <- readRDS(url(remote_df))
      local_df

    }
  }
}
