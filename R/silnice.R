#' Road Network
#'
#' Function returning data frame of roads of the Czech Republic as \code{sf} lines. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 1.5 MB.
#'
#' @param method Method argument for `download.file()`. The default (i.e. "curl") should be appropriate in most situations.
#'
#' @format \code{sf} data frame with 18.979 rows of 4 variables + geometry:
#'
#' \describe{
#'   \item{TRIDA}{Class of the road: highway = dálnice, speedway = rychlostní silnice, 1st clas road = silnice I. třídy, 2nd class road = silnice II. třídy, 3rd class road = silnice III. třídy, other road = neevidovaná silnice}
#'   \item{CISLO_SILNICE}{Local road code}
#'   \item{MEZINARODNI_OZNACENI}{International road code}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @export

silnice <- function(method = "curl") {

  remote_path <- 'http://rczechia.jla-data.net/'

  file <- 'Silnice.rds'

  remote_file <- paste0(remote_path, file)
  local_file <- file.path(tempdir(), file)

  if (file.exists(local_file)) {

    message('RCzechia: using temporary local dataset.')

  } else {

    if (http_error(remote_file)) {

      stop('No internet connection or data source broken.')

    } else {

      message('RCzechia: downloading remote dataset.')
      download.file(url = remote_file, destfile = local_file, method = method, quiet = T)
    }
  }

  local_df <- readRDS(local_file)
  local_df
}
