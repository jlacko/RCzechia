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
#' @example {
#'
#'
#' }
kraje <- function() {
  remote_df <- url('http://rczechia.jla-data.net/Kraje.rds')
  local_df <- readRDS(remote_df)
  local_df
}
