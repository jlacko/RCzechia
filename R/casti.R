#' City Parts
#'
#' Function taking no parameters and returning data frame of districts of Prague and other major cities as \code{sf} polygons.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 593.6 KB.
#'
#' @format \code{sf} data frame with 142 rows of 4 variables + geometry
#'
#' \describe{
#'   \item{KOD}{Code of the city part / kod mestske casti}
#'   \item{NAZEV}{Name of the city part / nazev mestske casti}
#'   \item{KOD_OBEC}{Code of the city}
#'   \item{NAZ_OBEC}{Name of the city}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

casti <- function() {

  remote_path <- 'http://rczechia.jla-data.net/'

  file <- 'casti.rds'

  remote_file <- paste0(remote_path, file)
  local_file <- file.path(tempdir(), file)

  if (file.exists(local_file)) {

    message('RCzechia: using temporary local dataset.')

  } else {

    if (http_error(remote_file)) {

      stop('No internet connection or data source broken.')

    } else {

      message('RCzechia: downloading remote dataset.')
      download.file(url = remote_file, destfile = local_file, quiet = T)
    }
  }

  local_df <- readRDS(local_file)
  local_df
}
