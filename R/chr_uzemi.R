#' Protected Natural Areas
#'
#' Function returning data frame of protected natural areas (Chráněná území) of the Czech Republic as \code{sf} polygons. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 7 MB.
#'
#'
#' @format \code{sf} data frame with 2677 rows of 3 variables + geometry
#'
#' \describe{
#'   \item{TYP}{Type of protected area}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{PLOCHA}{type of protected area: large or small}
#' }
#'
#' @source (c) AOPK ČR \url{https://data.nature.cz/}
#'
#'
#' @export

chr_uzemi <- function() {
  result <- downloader("ChrUzemiAOPK.rds")
  result
}
