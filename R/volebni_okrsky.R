#' Election Districts (Volební okrsky) of the Czech Republic
#'
#' Function returning data frame of the local election districts for the Czech Republic as \code{sf} polygons. It takes a single parameter resolution - high res (default) or low res polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to January 2023 (the presidential elections). Downloaded size of high resolution shapefile is 75 MB, size of the low res object is 5 MB (so proceed with caution, and patience).
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @return \code{sf} data frame with 14 733 rows of 6 variables + geometry
#'
#' \describe{
#'   \item{Kod}{Unique id of the district.}
#'   \item{Cislo}{Id of the district within a given Obec / not globally unique.}
#'   \item{ObecKod}{Id of obec - maps to obce_polygony()$KOD_OBEC.}
#'   \item{MomcKod}{Id of městská část - maps to casti()$KOD.}
#'   \item{KOD_LAU1}{Id of okres - maps to okresy()$KOD_LAU1.}
#'   \item{KOD_CZNUTS3}{Id of kraj - maps to kraje()$KOD_CZNUTS3.}
#' }
#'
#' @source © ČÚZK, 2023 \url{https://vdp.cuzk.cz/}
#'
#' @examples
#' \donttest{
#'  library(sf)
#'
#' prazske_okrsky <- subset(volebni_okrsky("low"), ObecKod == "554782")
#' plot(prazske_okrsky) # the districts of Prague
#' }
#' @export

volebni_okrsky <- function(resolution = "high") {
  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  }

  if (resolution == "low") {
    result <- .downloader("Okrsky-low-2023-01.rds")
  } else {
    result <- .downloader("Okrsky-high-2023-01.rds")
  }
  result
}
