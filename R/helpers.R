#' Set the local cache directory
#'
#' The function sets the environment variable RCZECHIA_HOME to be used as a local cache for RCzechia remote files; if unset tempdir() is used instead, with persistence for current session only.
#'
#' Note that when set (it is unset by default) the remote files will be cached to local file system, for good or bad. Also note that you can set the value of RCZECHIA_HOME environment variable directly, either via \code{Sys.setenv()} or via your .Rprofile.
#'
#' @param path file to be downloaded (or not...) from S3
#'
#' @return TRUE for success and FALSE for failure; returned silently

set_home <- function(path) {

  if(file.access(path, mode = 2) == 0) {
    Sys.setenv("RCZECHIA_HOME" = path)
    invisible(TRUE)
  } else {
    warning("'path' not found or not writeable; default will be used instead")
    invisible(FALSE)
  }

}

#' Unset the local cache directory
#'
#' The function unsets the environment variable RCZECHIA_HOME, meaning tempdir() will be used in future function calls, and no persistent data will be stored locally.
#'
#' @return TRUE for success and FALSE for failure; returned silently

unset_home <- function() {

  Sys.unsetenv("RCZECHIA_HOME")
  invisible(TRUE)

}
