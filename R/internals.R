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
    message(paste("RCzechia: using dataset stored locally in", local_dir))
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


#' Internal function - executes on load, and informs about state of the RCZECHIA_HOME environment variable
#'
#' The function takes no parameters; it serves the need to make the .onAttach code testable
#'
#' @keywords internal

.rhome_state <- function() {

  home <- Sys.getenv("RCZECHIA_HOME")

  if(home != "") packageStartupMessage("Using local RCzechia cache at ", home, appendLF = TRUE)

}


# check the environment variable & report back

.onAttach <- function(libname, pkgname)  {

  .rhome_state()

}

# common code to handle the CZSO API - downloads & caches the return of an API call; the exact endpoint depends on value of query parameter
.get_czso <- function(query) {

  # technical variables for testing
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  czso <- as.logical(Sys.getenv("CZSO_UP", unset = TRUE)) # dummy variable to allow testing of network
  laggy <- as.logical(Sys.getenv("CZSO_LAGGY", unset = TRUE)) # dummy variable to allow testing API experiencing difficulties

  # functional variables
  local_dir <- tempdir() # note to self: consider costs & benefits of persistent caching in a future release
  retries <- 0 # init of retries of API in case of empty return
  query_hash <- tools::md5sum(bytes = charToRaw(query))

  if (!curl::has_internet() | !network) { # network is down
    message("No internet connection.")
    return(NA)
  }

  if (httr::http_error(query) | !czso) { # error in connection?
    message("Error in connection to CZSO API.")
    return(NA)
  }

  # is a cached response available?
  if(file.exists(paste0(local_dir, .Platform$file.sep, query_hash, ".rds"))) {

    # if yes, use the cache
    resp <- readRDS(paste0(local_dir, .Platform$file.sep, query_hash, ".rds"))

  } else {

    # if not, get a fresh one
    resp <- httr::GET(query, httr::user_agent("RCzechia"))

  }# /if cache


  # CZSO API is not fully stable yet, so a few retries may help
  while (length(resp$content) == 0 & retries < 6) {

    retries <- retries + 1

    message(paste("CZSO reply malformed, attempting retry (attempt", retries, "of 6)"))

    Sys.sleep(15) # timeout in seconds

    resp <- httr::GET(query, httr::user_agent("RCzechia"))

  } # /retries

  # testing for fake lag
  if(!laggy) resp$content <- NULL

  # did six retries help at all?
  if (length(resp$content) == 0) { # no data in request
    message(paste("CZSO API is experiencing difficulties, quitting after", retries, "retries."))
    return(NA)
  } # / final check

  # cache, or die!
  saveRDS(resp, file = paste0(local_dir, .Platform$file.sep, query_hash, ".rds"))

  # all clear; return the data
  httr::content(resp, as = "text", encoding = "UTF-8")

} # / funciton
