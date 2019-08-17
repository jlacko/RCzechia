#' Grids (faunistické čtverce) of the Czech Republic
#'
#' Function returning grid covering the Czech Republic according to the Kartierung der Flora Mitteleuropas methodology.
#'
#'
#' @format \code{sf} data frame with 1092 rows
#'
#' \describe{
#'   \item{ctverec}{KFME code of the grid cell}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot() +
#'    geom_sf(data = republika("low")) +
#'    geom_sf(data = ctverce(), fill = NA)
#'
#' @export

ctverce <- function() {
  return(faunisticke_ctverce)
}


