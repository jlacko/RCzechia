#' Protected Natural Areas
#'
#' Function returning data frame of protected natural areas (Chráněná území) of the Czech Republic as \code{sf} polygons. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 114 KB.
#'
#'
#' @format \code{sf} data frame with 36 rows of 5 variables + geometry
#'
#' \describe{
#'   \item{TYP}{Type of protected area: Národní park, Chráněná krajinná oblast}
#'   \item{NAZEV}{Name, with Czech accents}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

chr_uzemi  <- function() {

  remote_path <- 'http://rczechia.jla-data.net/'

  file <- 'ChrUzemi.rds'

  remote_file <- paste0(remote_path, file)
  local_file <- file.path(tempdir(), file)

  if (file.exists(local_file)) {

    message('RCzechia: using temporary local dataset.')

  } else {

    if (http_error(remote_file)) {

      stop('No internet connection or data source broken.')

    } else {

      message('RCzechia: downloading remote dataset.')
      curl_download(url = remote_file, destfile = local_file, quiet = T)
    }
  }

  local_df <- readRDS(local_file)
  local_df
}
