#' Boundaries of the Czech Republic.
#'
#'
#' @format sf data frame with 1 row of 1 variable + geometry:
#'
#' @source ArcČR 500
#'
#' @example {
#'
#'
#' }
republika <- function() {
  remote_df <- url('http://rczechia.jla-data.net/Republika.rds')
  local_df <- readRDS(remote_df)
  local_df
}
