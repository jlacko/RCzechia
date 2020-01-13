#' Internal function - generic downloader, used to serve the rds files from S3
#'
#' @param file file to be downloaded (or not...) from S3
#' @keywords internal

downloader <- function(file) {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network

  remote_path <- "https://rczechia.jla-data.net/" # remote archive

  remote_file <- paste0(remote_path, file) # path to AWS S3
  local_file <- file.path(tempdir(), file) # local file - in tempdir

  if (file.exists(local_file)) {
    message("RCzechia: using temporary local dataset.")
  } else {
    if (!curl::has_internet() | httr::http_error(remote_file) | !network) { # network is down, real or fake
      message("No internet connection or data source broken.")
      return(NULL)
    } else { # network is up = proceed to download via curl

      message("RCzechia: downloading remote dataset.")
      curl::curl_download(url = remote_file, destfile = local_file, quiet = T)
    } # /if - network up or down
  } # /if - local file exists

  local_df <- readRDS(local_file)
  local_df
} # /function
