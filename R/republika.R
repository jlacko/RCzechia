#' Republika
#'
#' Boundaries of the Czech Republic as \code{sf} polygon.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size of high resolution shapefile is 949.7 KB.
#'
#' @param resolution Should the function return high or low resolution shapefile? Allowed values are "high" (default) and "low". This parameter affects only the geometry column, all other fields remain the same.
#'
#' @format \code{sf} data frame with 1 row of 1 variable + geometry:
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @examples
#' \donttest{
#' library(sf)
#'
#' hranice <- republika()
#' plot(hranice, col = "white")
#' }
#' @export


republika <- function(resolution = "high") {

  remote_path <- 'https://rczechia.jla-data.net/'

  file <- 'Republika.rds'

  remote_file <- paste0(remote_path, file)
  local_file <- file.path(tempdir(), file)

  if (!is.element(resolution, c("high", "low"))) stop(paste(resolution, "is not a valid resoulution; recognized values are \"high\" or \"low\"."))

  if (resolution == "low") {

    return(republika_low_res)

  } else {

    if (file.exists(local_file)) {

      message('RCzechia: using temporary local dataset.')

    } else {

      if (httr::http_error(remote_file)) {

        stop('No internet connection or data source broken.')

      } else {

        message('RCzechia: downloading remote dataset.')
        curl::curl_download(url = remote_file, destfile = local_file, quiet = T)

        }
    }

    local_df <- readRDS(local_file)
    local_df
  }
}
