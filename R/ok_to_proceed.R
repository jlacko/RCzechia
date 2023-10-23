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
