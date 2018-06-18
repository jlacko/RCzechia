#' Obce s rozsirenou pusobnosti
#'
#' Function returning data frame of municipalities with extended powers (obce s rozšířenou působností) as \code{sf} polygons. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 9 MB (so use with caution, and patience).
#'
#' @format \code{sf} data frame with 206 rows of 10 variables + geometry
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

  local_path <- paste0(tempdir(),'/')
  remote_path <- 'http://rczechia.jla-data.net/'

  file <- 'ORP.rds'

  remote_file <- paste0(remote_path, file)
  local_file <- paste0(local_path, file)

  if (file.exists(local_file)) {

    message('RCzechia: using temporary local dataset.')

  } else {

    if (http_error(remote_file)) {

      stop('No internet connection or data source broken.')

    } else {

      message('RCzechia: downloading remote dataset.')
      download.file(url = remote_file, destfile = local_file)
    }
  }

  local_df <- readRDS(local_file)
  local_df
}
