#' Boundaries of the Czech Republic.
#'
#'
#' @format sf data frame with 1 row of 1 variable + geometry:
#'
#' @source ArcČR 500
#'
#' @examples {
#'
#'
#' }
#'
#' @export


republika <- function() {
  remote_df <- 'http://rczechia.jla-data.net/Republika.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
