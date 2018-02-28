#' Municipalities / communes (obce) of the Czech Republic.
#' LAU2 administrative unit for the Czech Republic.
#'
#' \itemize{
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
#'   \item{KOD_CZNUTS2}{Code of the NUTS3 unit (kraj)}
#'   \item{NAZ_CZNUTS2}{Name of the NUTS3 unit (kraj)}
#' }
#'
#' @format sf data frame with 6.258 rows of 14 variables + geometry:
#'
#' @source ArcČR 500
#'
#' @example {
#'   praha <- obce_polygony() %>%
#'      filter(NAZ_LAU1 == "Praha")
#'
#'   plot(praha, max.plot = 1)
#' }
library("httr")

obce_polygony <- function() {
  remote_df <- 'http://rczechia.jla-data.net/ObceP.rds'
  if (http_error(remote_df)) {
    warning('No internet connection or data source broken.')
    return(NA)
  } else {
    local_df <- readRDS(url(remote_df))
  }
  local_df
}
