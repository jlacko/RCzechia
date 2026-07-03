#' Get Catalogue of DataStat Reports
#'
#' Experimental function to access the "new" DataStat API of Czech Statistical Office / ČSÚ.
#'
#' This function takes no arguments, and returns a data frame with data catalogue of DataStat data sets, the most important part of which is the code (kod) and description (nazev).
#'
#' The function returns the dataset "as it is", without attempting to translate structure or content from the original Czech language.
#'
#' In case of API failures (CZSO down) the function returns NA, with a message.
#'
#' Usage of the CZSO DataStat API is governed by CZSO Terms & Conditions -
#' \url{https://csu.gov.cz/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu}.
#'
#' @return data frame with codes and descriptions of DataStat datasets
#'
#' @examples
#' # DataStat datasets related to unemployment ("nezaměstnanost" in Czech)
#'
#' datastat_catalogue() |>
#'   subset(grepl("nezam", nazev))
#'
#'
#' @export



datastat_catalogue <- function() {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  czso <- as.logical(Sys.getenv("CZSO_UP", unset = TRUE)) # dummy variable to allow testing of network


  if (!curl::has_internet() | !network) { # network is down
    message("No internet connection.")
    return(NA)
  }

  query <- "https://data.csu.gov.cz/api/katalog/v1/sady"

  if (httr::http_error(query) | !czso) { # error in connection?
    message("Error in connection to CZSO API.")
    return(NA)
  }

  resp <- httr::GET(query)

  if (length(resp$content) == 0) { # no data in request
    message("Error in CZSO response; try later...")
    return(NA)
  }

  # czso call was successful, now digest the json results!
  res <-  httr::content(resp, as = "text", encoding = "UTF-8") |>
    jsonlite::fromJSON() |>
    dplyr::mutate(urovneTypObdobi = purrr::map_chr(urovneTypObdobi, ~ paste(.x$nazevUrovne, collapse = ", ")),
                  urovneTypUzemi = purrr::map_chr(urovneTypUzemi, ~ paste(.x$nazevUrovne, collapse = ", ")))

  # all clear, return the results...
  res

} # /function
