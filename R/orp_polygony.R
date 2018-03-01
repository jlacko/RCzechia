#' Municipalities with extended powers (obce s rozšířenou působností) of the Czech Republic
#'
#' \itemize{
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
#' @format sf data frame with 206 rows of 10 variables + geometry:
#'
#' @source ArcČR 500
#'
#' @examples {
#'
#'
#' }


orp_polygony <- function() {
  remote_df <- 'http://rczechia.jla-data.net/ORP.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
