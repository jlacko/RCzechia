#' Obce s rozsirenou pusobnosti
#'
#' Function returning data frame of municipalities with extended powers (obce s rozšířenou působností) as \code{sf} polygons. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to January 2021 (i.e changes introduced by act 51/2020 Sb. are reflected). Downloaded size is 1.5 MB.
#'
#' @format \code{sf} data frame with 206 rows of 5 variables + geometry
#'
#' \describe{
#'   \item{KOD_ORP}{Code of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{NAZ_ORP}{Full name of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{KOD_KRAJ}{Code of the region (kraj).}
#'   \item{KOD_CZNUTS3}{Code of the NUTS3 unit (kraj)}
#'   \item{NAZ_CZNUTS3}{Name of the NUTS3 unit (kraj)}
#' }
#'
#' @source © ČÚZK, 2020 \url{https://vdp.cuzk.cz/}
#'
#' @export

orp_polygony <- function() {
  result <- downloader("ORP-R-2021-01.rds")
  result
}
