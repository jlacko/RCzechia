#' Rivers
#'
#' Function returning data frame of rivers of the Czech Republic as \code{sf} lines. It takes a single parameter \code{scope} with default "global".
#'
#' Two special case scopes are defined: Praha (returning the part of Vltava in and around Prague) and Brno (returning Svitava and Svratka near and around Brno).
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 1 MB.
#'
#' @param scope Should the function return all rivers, or just Vltava in Prague / Svitava & Svratka in Brno?
#'
#' @format \code{sf} data frame with 6.198 rows of 4 variables + geometry:
#'
#' \describe{
#'   \item{TYP}{Type of river: 1 =  natural, 2 = man-made, 3 = fictional}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{Major}{Boolean indicating one of the major rivers.}
#' }
#'
#' @examples
#' library(sf)
#'
#' plot(st_geometry(subset(okresy(), NAZ_LAU1 == "Brno-město"))) # Brno city
#' plot(reky("Brno"), add = T) # Svitava & Svratka added to Brno my city plot
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @export

reky <- function(scope = "global") {

    if (!length(scope) == 1) {
    stop("A single ")
  } # /if

  if (!is.element(scope, c("global", "Praha", "Brno"))) {
    stop(paste(scope, "is not a valid scope; recognized values are \"global\", \"Brno\" or \"Praha\"."))
  }


  if (scope == "Brno") {
    return(reky_brno)
  } # /if

  if (scope == "Praha") {
    return(reky_praha)
  } # /if

  # return default
  result <- downloader("Reky.rds")
  result
}
