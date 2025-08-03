#' Cadastral Areas
#'
#' Function taking no parameters and returning data frame of cadastral areas (katastrální území) as `sf` polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The dataset is based on RUIAN data by the Czech cadastral office. If necessary you can download the most up to date raw dataset in VFR format (a special case of XML which is understood by GDAL) on <https://vdp.cuzk.cz/vdp/ruian/vymennyformat> (in Czech only).
#'
#' The data is current to July 2025. Downloaded size is 26.1 MB.
#'
#'
#' @return `sf` data frame with 13074 rows of 5 variables + geometry
#'
#' \describe{
#'   \item{KOD}{Code of the cadastral area / kód katastrálního území}
#'   \item{NAZEV}{Name of the cadastral area / název katastrálního území}
#'   \item{KOD_OBEC}{Code of the municipality}
#'   \item{NAZ_OBEC}{Name of the municipality}
#'   \item{digi}{boolean indicating completed digitalization}
#' }
#'
#' @source © ČÚZK, 2025 <https://vdp.cuzk.cz/>
#'
#' @examples
#'
#' \donttest{
#' library(sf)
#'
#' # which cadastral area of Prague is the smallest?
#' praha <- RCzechia::katastry() %>%
#'    subset(NAZ_OBEC == "Praha")
#'
#' smallest <- which.min(sf::st_area(praha))
#'
#' plot(st_geometry(RCzechia::obce_polygony() %>%
#'    subset(NAZ_OBEC == "Praha")))
#'
#' plot(st_geometry(RCzechia::reky("Praha")), col = "navyblue", add = TRUE)
#'
#' # it is Josefov - the former Jewish Ghetto
#' plot(st_geometry(praha[smallest, ]), col = "red", add = TRUE)
#'
#' }
#'
#' @export

katastry <- function() {
  result <- .downloader("katastry-R-2025-07.rds")
  result
}
