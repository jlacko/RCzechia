#' Internal function - generic downloader, used to serve the rds files from S3
#'
#' The function utilizes environment variable RCZECHIA_MIRROR as a mirror location of remote files; to configure an alternative (possibly local) repository use `Sys.setenv("RCZECHIA_MIRROR" = "file:///someplace/local")`
#'
#' @param file file to be downloaded (or not...) from S3
#' @keywords internal

.downloader <- function(file) {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network

  remote_path <- Sys.getenv("RCZECHIA_MIRROR", unset = "https://rczechia.jla-data.net/") # remote archive

  remote_file <- paste0(remote_path, file) # path to AWS S3
  local_file <- file.path(tempdir(), file) # local file - in tempdir

  if (file.exists(local_file)) {
    message("RCzechia: using temporary local dataset.")
  } else {
    if (!.ok_to_proceed(remote_file) | !network) { # network is down
#      message("No internet connection.")
      return(NULL)
    }

    # proceed to download via curl
    message("RCzechia: downloading remote dataset.")
    curl::curl_download(url = remote_file,
                        destfile = local_file,
                        quiet = F)
   } # /if - local file exists

  # everything except rasters
  if(tools::file_ext(local_file) == "rds") local_df <- readRDS(local_file)

  # rasters, and rasters only
  if(tools::file_ext(local_file) == "tif") local_df <- terra::rast(local_file)

  # serve the result back
  local_df

} # /function
