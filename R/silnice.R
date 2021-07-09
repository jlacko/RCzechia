#' Road Network
#'
#' Function returning data frame of roads of the Czech Republic as \code{sf} lines. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to December 2020. Downloaded size is 14.4 MB.
#'
#' @format \code{sf} data frame with 18.979 rows of 2 variables + geometry:
#'
#' \describe{
#'   \item{TRIDA}{Class of the road: highway = dálnice, speedway = rychlostní silnice, 1st class road = silnice I. třídy, 2nd class road = silnice II. třídy, 3rd class road = silnice III. třídy, other road = neevidovaná silnice}
#'   \item{CISLO_SILNICE}{Local road code}
#' }
#'
#' @source Mapový podklad – Data50, 2021 © Český úřad zeměměřický a katastrální \url{https://www.cuzk.cz}
#'
#' @export

silnice <- function() {
  result <- downloader("Silnice-D200-2021-07.rds")
  result
}
