#' Boundaries of the Czech Republic
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 949.7 KB.
#'
#'  republika() is a function taking no parameters and returning a data frame; remember to use (empty) brackets in your call.
#'
#' @format sf data frame with 1 row of 1 variable + geometry:
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' library(sf)
#' hranice <- republika()
#' plot(hranice, col = "white")
#'
#' @export
#' @importFrom httr http_error

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
