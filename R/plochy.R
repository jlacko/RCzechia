#' Water Bodies
#'
#' Water bodies of the Czech Republic as polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 118.6 KB.
#'
#'  plochy() is a function taking no parameters and returning a data frame; remember to use (empty) brackets in your call.
#'
#' @format sf data frame with 480 rows of 5 variables + geometry
#'
#' \describe{
#'   \item{TYP}{Type of water body: 1 = dam, 2 = pond, 3 = lake}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{VYSKA}{water level, meters above sea level}
#'   \item{Major}{Boolean indicating the major water bodies}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

plochy <- function() {
  remote_df <- 'http://rczechia.jla-data.net/Plochy.rds'
  if (http_error(remote_df)) {
    stop('No internet connection or data source broken.')
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
