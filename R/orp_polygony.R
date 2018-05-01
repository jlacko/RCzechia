#' Obce s rozsirenou pusobnosti
#'
#' Function returning data frame of municipalities with extended powers (obce s rozšířenou pusobností) as sf polygons. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 9 MB (so use with caution, and patience).
#'
#' @format sf data frame with 206 rows of 10 variables + geometry
#'
#' \describe{
#'   \item{KOD_ORP}{Code of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{NAZ_ZKR_ORP}{Short name of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{NAZ_ORP}{Full name of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{KOD_RUIAN}{RUIAN (Registr uzemni identifikace, adres a nemovitosti) code.}
#'   \item{KOD_OKRES}{Code of the district (okres).}
#'   \item{KOD_LAU1}{Code of the LAU1 administrative unit (okres).}
#'   \item{NAZ_LAU1}{Name of the LAU1 administrative unit (okres).}
#'   \item{KOD_KRAJ}{Code of the region (kraj).}
#'   \item{KOD_KRAJ}{Code of the region (kraj).}
#'   \item{KOD_CZNUTS2}{Code of the NUTS3 unit (kraj)}
#'   \item{NAZ_CZNUTS2}{Name of the NUTS3 unit (kraj)}
#' }
#'
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

orp_polygony <- function() {
  remote_df <- 'http://rczechia.jla-data.net/ORP.rds'
  if (http_error(remote_df)) {
    stop('No internet connection or data source broken.')
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
