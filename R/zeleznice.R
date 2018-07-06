#' Železnice
#'
#' Function returning data frame of railorads of the Czech Republic as \code{sf} lines. It has no obligatory parameters.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package). Downloaded size is 285 KB.
#'
#' @param method Method argument for `download.file()`. The default (i.e. "curl") should be appropriate in most situations.
#'
#' @format \code{sf} data frame with 3.525 rows of 4 variables + geometry:
#'
#' \describe{
#'   \item{ELEKTRIFIKACE}{is the railroad electrified?: yes = ano, no = ne}
#'   \item{KATEGORIE}{category: international = mezinárodní, local = vnitrostátní}
#'   \item{KOLEJNOST}{track: single = jednokolejní, double = dvojkolejní, more = tří a vícekolejní}
#'   \item{ROZCHODNOST}{gauge: standard = normální, narrow = úzkokolejka}
#' }
#'
#' @source \url{https://www.arcdata.cz/produkty/geograficka-data/arccr-500}
#'
#' @export

zeleznice <- function(method = "curl") {

  remote_path <- 'http://rczechia.jla-data.net/'

  file <- 'Zeleznice.rds'

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
