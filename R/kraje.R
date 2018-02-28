#' Regions (kraje) of the Czech Republic. NUTS3 administrative unit for the Czech Republic.
#'
#' \itemize{
#'   \item{KOD_KRAJ}{Code of the region, primary key. Use this as key to add other data items.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region as NUTS3 (kraj).}
#' }
#' @format sf data frame with 14 rows of 3 variables + geometry:
#'
#' @source ArcČR 500
#'
#' @examples {
#'
#'
#' }

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
