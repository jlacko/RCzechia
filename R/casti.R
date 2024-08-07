#' City Districts
#'
#' Function taking no parameters and returning data frame of districts of Prague and other major cities as `sf` polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The dataset is based on RUIAN data by the Czech cadastral office. If necessary you can download the most up to date raw dataset in VFR format (a special case of XML which is understood by GDAL) on <https://vdp.cuzk.cz/vdp/ruian/vymennyformat> (in Czech only).
#'
#' The data is current to June 2024. Downloaded size is 1.5 MB.
#'
#'
#' @return `sf` data frame with 142 rows of 4 variables + geometry
#'
#' \describe{
#'   \item{KOD}{Code of the city part / kod mestske casti}
#'   \item{NAZEV}{Name of the city part / nazev mestske casti}
#'   \item{KOD_OBEC}{Code of the city}
#'   \item{NAZ_OBEC}{Name of the city}
#' }
#'
#' @source © ČÚZK, 2021 <https://vdp.cuzk.cz/>
#'
#' @export

casti <- function() {
  result <- .downloader("casti-R-2024-06.rds")
  result
}
