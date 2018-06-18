#' Districts (okresy)
#'
#' Function returning data frame of LAU1 administrative units for the Czech Republic as \code{sf} polygons. It takes a single parameter resolution - high res (default) or low res polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size of high resolution shapefile is 6.1 MB (so use with caution, and patience).
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @format \code{sf} data frame with 77 rows of 6 variables + geometry
#'
#' \describe{
#'   \item{KOD_OKRES}{Code of the district (okres).}
#'   \item{KOD_LAU1}{Code of the district as LAU1 unit (okres), primary key. Use this as key to add other data items.}
#'   \item{NAZ_LAU1}{Name of the district as LAU1 unit (okres).}
#'   \item{KOD_KRAJ}{Code of the region.}
#'   \item{KOD_CZNUTS3}{Code of the region as NUTS3 (kraj).}
#'   \item{NAZ_CZNUTS3}{Name of the region (kraj).}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' \donttest{
#' library(sf)
#'
#' hranice <- okresy()
#' plot(hranice, col = "white", max.plot = 1)
#'
#' object.size(okresy("low"))
#' object.size(okresy("high"))
#' }
#' @export

okresy <- function(resolution = "high") {

  local_path <- paste0(tempdir(),'/')
  remote_path <- 'http://rczechia.jla-data.net/'

  file <- 'Okresy.rds'

  remote_file <- paste0(remote_path, file)
  local_file <- paste0(local_path, file)

  if (!is.element(resolution, c("high", "low"))) stop("Unknown resolution!")

  if (resolution == "low") {

    return(okresy_low_res)

  } else {

    if (file.exists(local_file)) {

      message('RCzechia: using temporary local dataset.')

    } else {

      if (http_error(remote_file)) {

        stop('No internet connection or data source broken.')

      } else {

        message('RCzechia: downloading remote dataset.')
        download.file(url = remote_file, destfile = local_file)
      }
    }

    local_df <- readRDS(local_file)
    local_df
  }
}
