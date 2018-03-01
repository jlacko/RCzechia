#' Districts (mestske casti) of Prague and other major cities.
#'
#' \itemize{
#'   \item{KOD}{Code of the city part / kod mestske casti}
#'   \item{NAZEV}{Name of the city part / nazev mestske casti}
#'   \item{KOD_OBEC}{Code of the city}
#'   \item{NAZ_OBEC}{Name of the city}
#' }
#' @format sf data frame with 142 rows of 4 variables + geometry:
#'
#' @source ArcČR 500
#'
#' @examples  {
#' }
#'
#' @export

casti <- function() {
  remote_df <- 'http://rczechia.jla-data.net/casti.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
