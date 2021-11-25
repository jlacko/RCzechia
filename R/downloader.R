#' Internal function - generic downloader, used to serve the rds files from S3
#'
#' @param file file to be downloaded (or not...) from S3
#' @keywords internal

.downloader <- function(file) {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  aws <- as.logical(Sys.getenv("AWS_UP", unset = TRUE)) # dummy variable to allow testing of network

  remote_path <- "https://rczechia.jla-data.net/" # remote archive

  remote_file <- paste0(remote_path, file) # path to AWS S3
  local_file <- file.path(tempdir(), file) # local file - in tempdir

  if (file.exists(local_file)) {
    message("RCzechia: using temporary local dataset.")
  } else {
    if (!.ok_to_proceed(remote_file) | !network) { # network is down
      message("No internet connection.")
      return(NULL)
    }

    if (!.ok_to_proceed(remote_file) | !aws) { # AWS bucket down
      message("Data source broken.")
      return(NULL)
    }

    # proceed to download via curl
    message("RCzechia: downloading remote dataset.")
    utils::download.file(url = remote_file, destfile = local_file, quiet = T, mode = "wb")
   } # /if - local file exists

  local_df <- readRDS(local_file)

  local_df

} # /function
