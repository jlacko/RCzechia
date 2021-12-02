#' Rivers
#'
#' Function returning data frame of rivers of the Czech Republic as \code{sf} lines. It takes a single parameter \code{scope} with default "global".
#'
#' Two special case scopes are defined: Praha (returning the part of Vltava in and around Prague) and Brno (returning Svitava and Svratka near and around Brno).
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to December 2020. Downloaded size is 4.4 MB.
#'
#' @param scope Should the function return all rivers, or just Vltava in Prague / Svitava & Svratka in Brno?
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @return \code{sf} data frame with 3.616 rows of 4 variables + geometry:
#'
#' \describe{
#'   \item{TYP}{Type of river}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{Navigable}{Boolean indicating navigability of river.}
#'   \item{Major}{Boolean indicating one of the major rivers.}
#' }
#'
#' @examples
#' library(sf)
#'
#' plot(st_geometry(subset(okresy(), KOD_LAU1 == "CZ0642"))) # Brno city
#' plot(reky("Brno"), add = TRUE) # Svitava & Svratka added to Brno my city plot
#'
#' @source Mapový podklad – Data200, 2021 © Český úřad zeměměřický a katastrální. \url{https://www.cuzk.cz}
#'
#' @export

reky <- function(scope = "global", resolution = "high") {

  if (!length(scope) == 1) {
    stop("A single scope is required.")
  } # /if scope

  if (!is.element(scope, c("global", "Praha", "Brno"))) {
    stop(paste(scope, "is not a valid scope; recognized values are \"global\", \"Brno\" or \"Praha\"."))
  } # /if element

  if (!is.element(resolution, c("high", "low"))) {
    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))
  } #/if resolution


  if (scope == "Brno") {
    return(reky_brno)
  } # /if

  if (scope == "Praha") {
    return(reky_praha)
  } # /if


  # return default
  result <- if(resolution == "high") {
    .downloader("Reky-D200-high-2021-07.rds")
  } else {
    .downloader("Reky-D200-low-2021-07.rds")
  } # /if downloader

  result
}
