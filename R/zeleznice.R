#' Railroad Network
#'
#' Function returning data frame of railorads of the Czech Republic as \code{sf} lines. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 285 KB.
#'
#' @format \code{sf} data frame with 3.525 rows of 4 variables + geometry:
#'
#' \describe{
#'   \item{ELEKTRIFIKACE}{is the railroad electrified?: yes = ano, no = ne}
#'   \item{KATEGORIE}{category: international = mezinárodní, local = vnitrostátní}
#'   \item{KOLEJNOST}{track: single = jednokolejní, double = dvojkolejní, more = tří a vícekolejní}
#'   \item{ROZCHODNOST}{gauge: standard = normální, narrow = úzkokolejka}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @export

zeleznice <- function() {
  result <- downloader("Zeleznice.rds")
  result
}
