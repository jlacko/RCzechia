#' Get Dataset from DataStat
#'
#' Experimental function to access the "new" DataStat API of Czech Statistical Office / ČSÚ.
#'
#' This function takes as argument code of the dataset, and returns its content as a data frame.
#'
#' The function returns the dataset "as it is", without attempting to translate structure or content from the original Czech language.
#'
#' To save time & bandwidth attempt is made to cache the dataset, either to tempdir or RCZECHIA_HOME directory, if set.
#'
#' In case of API failures (CZSO down) the function returns NA, with a message.
#'
#' Usage of the CZSO DataStat API is governed by CZSO Terms & Conditions -
#' \url{https://csu.gov.cz/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu}.
#'
#' @return data frame containing a DataStat dataset
#'
#' @param kod code of the dataset
#' @param naming whether to use (human readable) \code{label} or (machine friendly) \code{id}
#'
#'
#' @examples
#'
#' # Unemployment statistics of Czechia
#'
#' datastat_dataset("NEZ01")
#'
#'
#' @export



datastat_dataset <- function(kod = "NEZ01", naming = "label") {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  czso <- as.logical(Sys.getenv("CZSO_UP", unset = TRUE)) # dummy variable to allow testing of network
  local_dir <- Sys.getenv("RCZECHIA_HOME", unset = tempdir()) # local cache directory - or tempdir if unset


  if (!curl::has_internet() | !network) { # network is down
    message("No internet connection.")
    return(NA)
  }

  if (!is.character(kod)) { # povinný parametr
    message("The dataset code (kod) is mandatory.")
    return(NA)
  }

  if (!is.na(naming) & !naming %in% c("label", "id")) { # povinný parametr
    message("The `naming` parameter is mandatory.")
    return(NA)
  }

  # is the dataset in local cache?

  query <- paste0("https://data.csu.gov.cz/api/dotaz/v1/velikosti/sady/", kod, "?format=JSON_STAT")

  if (httr::http_error(query) | !czso) { # error in connection?
    message("Error in connection to CZSO API.")
    return(NA)
  }

  resp <- httr::GET(query)

  httr::stop_for_status(resp)

  # TODO: implementovat načtení z keše když velikost remote stejná jako local

  query <- paste0("https://data.csu.gov.cz/api/dotaz/v1/data/sady/", kod, "?format=JSON_STAT")

  if (httr::http_error(query) | !czso) { # error in connection?
    message("Error in connection to CZSO API.")
    return(NA)
  }

  resp <- httr::GET(query)

  httr::stop_for_status(resp)

  # czso call was successful, now digest the json results!
  res <-  httr::content(resp, as = "text", encoding = "UTF-8") |>
    rjstat::fromJSONstat(naming = naming)

  # cache, or die!
  saveRDS(res, file = paste0(local_dir, .Platform$file.sep, kod, ".rds"))

  # all clear, return the results...
  res

} # /function
