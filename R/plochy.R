#' Water bodies (vodní plochy) of the Czech Republic
#'
#' @format 480 water bodies of the Czech Repubic, as a sf data frame:
#' \describe{
#'   \item{TYP}{Type of water body: 1 = dam, 2 = pond, 3 = lake}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{VYSKA}{water level, meters above sea level}
#'   \item{Major}{Boolean indicating the major water bodies}
#' }
#' @format sf data frame with 480 rows of 5 variables + geometry:
#'
#' @source ArcČR 500
#'
#' @examples {
#'
#'
#' }

plochy <- function() {
  remote_df <- 'http://rczechia.jla-data.net/Plochy.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
