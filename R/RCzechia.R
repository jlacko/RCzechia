#' RCzechia: Spatial Objects of the Czech Republic
#'
#' A selection of spatial objects relevant to the Czech Republic. Due to CRAN package size requirements the objects are stored externally - and thus could not be implemented as datasets, but are functions returning data frames instead.
#'
#' This means that 1) a working internet connection is required to use the full resolution objects and 2) all objects need to be called with (possibly empty) braces.
#'
#' For the most frequently used objects - republika, kraje and okresy - a low resolution version is implemented. The low resolution data sets are stored locally (and working intenet connection is not necessary to use them).
#'
#' All objects are implemented as `sf` data frames.
#'
#' @section Administrative regions:
#' \itemize{
#'   \item republika - borders of the Czech Republic
#'   \item kraje - regions / NUTS3 units
#'   \item okresy - districts / LAU1 units
#'   \item orp_polygony - municipalities with extended powers (obce s rozšířenou působností)
#'   \item obce_polygony - municipalities as polygons
#'   \item obce_body - municipalities as centroids (points)
#'   \item casti - city districts (for cities that implement them)
#' }
#'
#' @section Natural objects:
#' \itemize{
#'   \item reky - rivers
#'   \item plochy - water bodies
#' }
#'
#' @docType package
#' @name RCzechia-package
#'
#' @importFrom httr http_error

NULL
