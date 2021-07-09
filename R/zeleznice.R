#' Railroad Network
#'
#' Function returning data frame of railroads of the Czech Republic as \code{sf} lines. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to December 2020. Downloaded size is 1.5 MB.
#'
#' @format \code{sf} data frame with 3.525 rows of 3 variables + geometry:
#'
#' \describe{
#'   \item{ELEKTRIFIKACE}{is the railroad electrified?}
#'   \item{KOLEJNOST}{track: single = jednokolejní, double = dvojkolejní, more = tří a vícekolejní}
#'   \item{ROZCHODNOST}{gauge: standard = normální, narrow = úzkokolejka}
#' }
#'
#' @source Mapový podklad – Data50, 2021 © Český úřad zeměměřický a katastrální \url{https://www.cuzk.cz}
#'
#' @export

zeleznice <- function() {
  result <- downloader("Zeleznice-D200-2021-07.rds")
  result
}
