#' Rivers of the Czech Republic
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 1 MB.
#'
#'  reky() is a function taking no parameters and returning a data frame; remember to use (empty) brackets in your call.
#'
#' \describe{
#'   \item{TYP}{Type of river: 1 =  natural, 2 = man-made, 3 = fictional}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{Major}{Boolean indicating one of the major rivers.}
#' }
#' @format sf data frame with 6.198 rows of 4 variables + geometry:
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @export
#' @importFrom httr http_error

reky <- function() {
  remote_df <- 'http://rczechia.jla-data.net/Reky.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
