#' Inhabited places (obce) of the Czech Republic.
#'
#' A Large SpatialPolygonsDataFrame containing inhabited places (obce) of the Czech Republic.
#'
#' @format 6258 obcí of the Czech Republic, as SpatialPolygonsDataFrame:
#' \describe{
#'   \item{KOD_OBEC}{Code of the place (obec), primary key. Use this as key to add other data items.}
#'   \item{KOD_LAU1}{Code of the district (okres).}
#'   \item{KOD_CZNUTS3}{Code of the region (kraj).}
#'   \item{Obec}{Name of the populated place. With Czech accents.}
#'   \item{KOD_POV}{Code of the level II commune (dvojková obec).}
#'   \item{PovObec}{Name of the level II commune (dvojková obec).}
#'   \item{KOD_ROZ}{Code of the level III commune (trojková obec).}
#'   \item{RozObec}{Name of the level III commune (trojková obec).}
#'   \item{Okres}{Name of the district (okres). With Czech accents.}
#'   \item{Kraj}{Name of the region (kraj). With Czech accents.}
#'   \item{Obyvatel}{Population, as at 2017-01-01. Source: Czech Statistial Office}
#'   \item{Obyvatel15p}{Population 15+, as at 2017-01-01. Source: Czech Statistial Office}
#' }
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
NULL
