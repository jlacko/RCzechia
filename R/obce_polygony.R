#' Municipalities / communes (obce) as polygons
#'
#' Function returning data frame of LAU2 administrative units for the Czech Republic as sf polygons. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 36.3 MB (so use with caution, and patience).
#'
#' @format sf data frame with 6.258 rows of 14 variables + geometry
#'
#' \describe{
#'   \item{KOD_OBEC}{Code of the level I commune (obec).}
#'   \item{NAZ_OBEC}{Name of the level I commune (obec).}
#'   \item{KOD_ZUJ}{Code of the basic administrative unit (ICZUJ).}
#'   \item{NAZ_ZUJ}{Name of the basic administrative unit (ICZUJ).}
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
#' }
#'
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' \dontrun{
#' praha <- obce_polygony() %>%
#'    filter(NAZ_LAU1 == "Praha")
#'
#' plot(praha, max.plot = 1)
#' }
#'
#'
#' @export

obce_polygony <- function() {
  remote_df <- 'http://rczechia.jla-data.net/ObceP.rds'
  if (http_error(remote_df)) {
    stop('No internet connection or data source broken.')
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
