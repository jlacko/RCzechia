#' Municipalities / communes (obce) of the Czech Republic. LAU2 administrative unit for the Czech Republic.
#'
#' A Large SpatialPointsDataFrame containing the municipalities of the Czech Republic.
#'
#' @format 6.258 municipalities of the Czech Republic, as a SpatialPointsDataFrame:
#' \describe{
#'   \item{KOD_OBEC}{Code of the municipality (obec), primary key. Use this as key to add other data items.}
#'   \item{KOD_LAU1}{Code of the district (okres).}
#'   \item{KOD_CZNUTS3}{Code of the region (kraj).}
#'   \item{Obec}{Name of the municipality. With Czech accents.}
#'   \item{KOD_POV}{Code of the level II commune (obec s poverenym uradem).}
#'   \item{PovObec}{Name of the level II commune (obec s poverenym uradem). With Czech accents.}
#'   \item{KOD_ROZ}{Code of the level III commune (obec s rozsirenou pusobnosti).}
#'   \item{RozObec}{Name of the level III commune (obec s rozsirenou pusobnosti). With Czech accents.}
#'   \item{Okres}{Name of the district (okres). With Czech accents.}
#'   \item{Kraj}{Name of the region (kraj). With Czech accents.}
#'   \item{Obyvatel}{Population, as of 2017-01-01. Source: Czech Statistial Office}
#'   \item{Obyvatel15p}{Population 15+, as of 2017-01-01. Source: Czech Statistial Office}
#' }
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
"obce_body"
