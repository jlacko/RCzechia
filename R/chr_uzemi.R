#' Protected Natural Areas
#'
#' Function returning data frame of protected natural areas (Chráněná území) of the Czech Republic as `sf` polygons. It has no obligatory parameters. 32 large (velkoplošná) and 2680 local (maloplošná) protected areas are provided.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to June 2025. Downloaded size is 7 MB  (so use with caution, and patience).
#'
#'
#' @return `sf` data frame with 2712 rows of 3 variables + geometry
#'
#' \describe{
#'   \item{TYP}{Type of protected area}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{PLOCHA}{type of protected area: large or small}
#' }
#'
#' @source © AOPK ČR, 2025 <https://data.nature.cz/>
#'
#' @export

chr_uzemi <- function() {
  result <- .downloader("ChrUzemiAOPK-2025-06.rds")
  result
}
