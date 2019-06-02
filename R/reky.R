#' Rivers
#'
#' Function returning data frame of rivers of the Czech Republic as \code{sf} lines. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 1 MB.
#'
#' @format \code{sf} data frame with 6.198 rows of 4 variables + geometry:
#'
#' \describe{
#'   \item{TYP}{Type of river: 1 =  natural, 2 = man-made, 3 = fictional}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{Major}{Boolean indicating one of the major rivers.}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @export

reky <- function() {

  result <- downloader("Reky.rds")
  result
}
