#' Internal function - generic downloader, used to serve the rds files from S3
#'
#' The function utilizes environment variable RCZECHIA_MIRROR as a mirror location of remote files; to configure an alternative (possibly local) repository use `Sys.setenv("RCZECHIA_MIRROR" = "file:///someplace/local")`
#'
#' @param file file to be downloaded (or not...) from S3
#' @keywords internal

.downloader <- function(file) {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  remote_path <- Sys.getenv("RCZECHIA_MIRROR", unset = "https://rczechia.jla-data.net/") # remote archive
  local_dir <- Sys.getenv("RCZECHIA_HOME", unset = tempdir()) # local cache directory - or tempdir if unset

  remote_file <- paste0(remote_path, file) # path to AWS S3
  local_file <- file.path(local_dir, file) # local file - in tempdir, or local cache if set

  if (file.exists(local_file) & network) {
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

#' Internal function - tests availability of internet resources
#'
#' @param remote_file resource to be tested
#' @keywords internal

.ok_to_proceed <- function(remote_file) {

  # local files are OK to proceed by definiton
  if (grepl("file:///", remote_file))  return(TRUE)

  # remote files require testing
  try_head <- function(x, ...) {
    tryCatch(
      httr::HEAD(url = x, httr::timeout(10), ...),
      error = function(e) conditionMessage(e),
      warning = function(w) conditionMessage(w)
    )
  }

  is_response <- function(x) {
    class(x) == "response"
  }

  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network

  # First check internet connection
  if (!curl::has_internet() | !network) {
    message("No internet connection.")
    return(FALSE)
  }
  # Then try for timeout problems
  resp <- try_head(remote_file)
  if (!is_response(resp)) {
    message("Timeout reached; external data source likely broken.")
    return(FALSE)
  }
  # Then stop if status > 400
  if (httr::http_error(resp)) {
    message("Data source broken.")
    return(FALSE)
  }

  # safe to proceed
  TRUE
}

# check the environment variable & report back

.onAttach <- function(libname, pkgname)  {

  home <- Sys.getenv("RCZECHIA_HOME")

  if(home != "") packageStartupMessage("Using local RCzechia cache at ", home, appendLF = TRUE)
}
