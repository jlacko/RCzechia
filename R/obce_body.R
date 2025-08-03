#' Municipalities / communes (obce) as centerpoints
#'
#' Function returning data frame of LAU2 administrative units for the Czech Republic as `sf` points. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The dataset is based on RUIAN data by the Czech cadastral office. If necessary you can download the most up to date raw dataset in VFR format (a special case of XML which is understood by GDAL) on <https://vdp.cuzk.cz/vdp/ruian/vymennyformat> (in Czech only).
#'
#' The data is current to July 2025. Downloaded size is <1 MB.
#'
#' @return `sf` data frame with 6.258 rows of 14 variables + geometry
#'
#' \describe{
#'   \item{KOD_OBEC}{Code of the level I commune (obec).}
#'   \item{NAZ_OBEC}{Name of the level I commune (obec).}
#'   \item{KOD_POU}{Code of the level II commune (obec s poverenym uradem).}
#'   \item{NAZ_POU}{Name of the level II commune (obec s poverenym uradem)).}
#'   \item{KOD_ORP}{Code of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{NAZ_ORP}{Name of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{KOD_OKRES}{Code of the district (okres).}
#'   \item{KOD_LAU1}{Code of the LAU1 administrative unit (okres).}
#'   \item{NAZ_LAU1}{Name of the LAU1 administrative unit (okres).}
#'   \item{KOD_KRAJ}{Code of the region (kraj).}
#'   \item{KOD_CZNUTS3}{Code of the NUTS3 unit (kraj)}
#'   \item{NAZ_CZNUTS3}{Name of the NUTS3 unit (kraj)}
#'   \item{ICO}{ID number of the commune / ičo obce}
#'   \item{DIC}{tax ID of the commune / dič obce}

#'   }
#'
#' @source © ČÚZK, 2025 <https://vdp.cuzk.cz/>
#'
#' @export

obce_body <- function() {
  result <- .downloader("ObceB-R-2025-07.rds")
  result
}
