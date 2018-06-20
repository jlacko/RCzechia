#' Water Bodies
#'
#' Function returning data frame of water bodies of the Czech Republic as \code{sf} polygons. It takes no parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 118.6 KB.
#'
#' @format \code{sf} data frame with 480 rows of 5 variables + geometry
#'
#' \describe{
#'   \item{TYP}{Type of water body: 1 = dam, 2 = pond, 3 = lake}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{VYSKA}{water level, meters above sea level}
#'   \item{Major}{Boolean indicating major water bodies}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#'
#' @export

plochy <- function() {

  remote_path <- 'http://rczechia.jla-data.net/'

  file <- 'Plochy.rds'

  remote_file <- paste0(remote_path, file)
  local_file <- file.path(tempdir(), file)

  if (file.exists(local_file)) {

    message('RCzechia: using temporary local dataset.')

  } else {

    if (http_error(remote_file)) {

      stop('No internet connection or data source broken.')

    } else {

      message('RCzechia: downloading remote dataset.')
      download.file(url = remote_file, destfile = local_file, method = "curl", quiet = T)
    }
  }

  local_df <- readRDS(local_file)
  local_df
}
