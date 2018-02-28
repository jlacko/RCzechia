#' Districts (okresy) of the Czech Republic.
#' LAU1 administrative unit for the Czech Republic.
#'
#' \itemize{
#'   \item{KOD_OKRES}{Code of the district (okres).}
#'   \item{KOD_LAU1}{Code of the district as LAU1 unit (okres), primary key. Use this as key to add other data items.}
#'   \item{NAZ_LAU1}{Name of the district as LAU1 unit (okres).}
#'   \item{KOD_KRAJ}{Code of the region.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region (kraj).}
#' }
#' @format sf data frame with 77 rows of 6 variables + geometry:
#'
#' @source ArcČR 500
#'
#' @examples {
#'
#' }

okresy <- function() {
  remote_df <- 'http://rczechia.jla-data.net/Okresy.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
