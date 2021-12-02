#' Water Bodies
#'
#' Function returning data frame of water bodies of the Czech Republic as \code{sf} polygons. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to December 2020. Downloaded size is 1.5 MB.
#'
#' @return \code{sf} data frame with 1.769 rows of 2 variables + geometry
#'
#' \describe{
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{VYSKA}{water level, meters above sea level}
#' }
#'
#' @source Mapový podklad – Data200, 2021 © Český úřad zeměměřický a katastrální. \url{https://www.cuzk.cz}
#'
#' @export

plochy <- function() {
  result <- .downloader("Plochy-D200-2021-07.rds")
  result
}
