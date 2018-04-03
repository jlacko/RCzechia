#' City Parts
#'
#' Function taking no parameters and returning data frame of districts of Prague and other major cities as sf polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 593.6 KB.
#'
#' @format sf data frame with 142 rows of 4 variables + geometry
#'
#' \describe{
#'   \item{KOD}{Code of the city part / kod mestske casti}
#'   \item{NAZEV}{Name of the city part / nazev mestske casti}
#'   \item{KOD_OBEC}{Code of the city}
#'   \item{NAZ_OBEC}{Name of the city}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

casti <- function() {
  remote_df <- 'http://rczechia.jla-data.net/casti.rds'
  if (http_error(remote_df)) {
    stop('No internet connection or data source broken.')
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
