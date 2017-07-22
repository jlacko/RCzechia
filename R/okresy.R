#' Districts (okresy) of the Czech Republic. LAU1 administrative unit for the Czech Republic.
#'
#' A Large SpatialPolygonsDataFrame containing districts (okresy) of the Czech Republic.
#'
#' @format 77 districts of the Czech Republic, as a SpatialPolygonsDataFrame:
#' \describe{
#'   \item{KOD_LAU1}{Code of the district (okres), primary key. Use this as key to add other data items.}
#'   \item{KOD_CZNUTS3}{Code of the region (kraj).}
#'   \item{Okres}{Name of the district. With Czech accents.}
#'   \item{Obyvatel}{Population, as of 2017-01-01. Source: Czech Statistial Office}
#' }
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
"okresy"
