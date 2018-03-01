#' Regions (kraje) of the Czech Republic
#'
#' NUTS3 administrative unit for the Czech Republic.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 2.9 MB (so use with caution, and patience).
#'
#' kraje() is a function taking no parameters and returning a data frame; remember to use (empty) brackets in your call.
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
#'
#' @export
#' @importFrom httr http_error

kraje <- function() {
  remote_df <- 'http://rczechia.jla-data.net/Kraje.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
