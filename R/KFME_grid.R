#' KFME grid cells (faunistické čtverce) of the Czech Republic
#'
#' Function returning grid covering the Czech Republic according to the Kartierung der Flora Mitteleuropas methodology.
#'
#' The function returns a {sf} data frame of grid cells. Depending on the value of parameter `resolution` either low resolution (26×42 cells - default) with labels in 4 digit format (e.g. Hrčava = 6479) or high resolution (104×168 cells) with labels in 4 digit + 1 letter format (e.g Hrčava = 6479c).
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "low" and "high". Default is "low".
#'
#' @format \code{sf} data frame with 1092 rows in low resolution and 4368 rows in high resolution
#'
#' \describe{
#'   \item{ctverec}{KFME code of the grid cell; depending on value of `resolution` parameter either 4 digits, or 4 digits + 1 letter}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot() +
#'    geom_sf(data = republika("low")) +
#'    geom_sf(data = KFME_grid("low"), fill = NA)
#'
#' @export

KFME_grid <- function(resolution = "low") {
  if (!is.element(resolution, c("high", "low"))) {

    stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))

  }

  if (resolution == "low") {

    return(faunisticke_ctverce)

  } else {

    return(faunisticke_ctverecky)

  }
}


