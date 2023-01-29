#' RCzechia: Spatial Objects of the Czech Republic
#'
#' A selection of spatial objects relevant to the Czech Republic. Due to CRAN
#' package size requirements (5 MB) the objects are stored externally (on Amazon
#' S3) - and therefore could not be implemented as datasets. They are functions
#' returning data frames instead.
#'
#' To save time (and bandwidth) the downloaded objects are saved locally in
#' `tempdir` directory when requested, and downloaded at most once *per R
#' session*; out of respect to CRAN Repository Policy a more permanent caching
#' on user's side is not attempted.
#'
#' This means that:
#' \itemize{
#'   \item a working internet connection is required to use the full resolution objects
#'   \item all objects need to be called with (possibly empty) braces
#' }
#'
#' For the most frequently used objects - **republika**, **kraje** and
#' **okresy** - a low resolution version is also implemented. The low
#' resolution data sets are stored locally (and working internet connection is
#' not necessary to use them).
#'
#' All objects are implemented as `sf` data frames.
#'
#' @section Administrative regions:
#'
#' | asdf | asdf |
#' | ---- | ----- |
#' | ema má mísu | psvz |
#' | míla je emo | 500 |
#'
#'
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
#'   \item lesy - woodland areas (more than 30 ha in area)
#' }
#'
#' @section Other objects:
#' \itemize{
#'   \item silnice - roads
#'   \item zeleznice - railroads
#'   \item KFME_grid - grid cells (faunistické čtverce) according to Kartierung
#'   der Flora Mitteleuropas methodology
#'   \item chr_uzemi - protected natural areas (chráněná území)
#' }
#'
#' @section Utility functions:
#' In addition three utility functions are implemented to support spatial
#' workflow:
#'
#' \itemize{
#'   \item geocode - geocoding (from address to coordinates)
#'   \item revgeo - reverse geocoding (from coordinates to address)
#' }
#'
#' @docType package
#' @name intro
#'
#' @import sf
#' @importFrom httr http_error
#' @importFrom curl curl_download
#' @importFrom magrittr %>%

NULL
