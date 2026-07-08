#' List DataStat Metrics
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
#' # DataStat metrics related to unemployment ("nezaměstnanost" in Czech)
#'
#' result <- datastat_metrics() |>
#'   subset(grepl("nezam", nazev))
#'
#' result[,c("kod","nazev")]
#'
#'
#' @export



datastat_metrics <- function() {

  query <- "https://data.csu.gov.cz/api/katalog/v1/ukazatele"

  res <- .get_czso(query)

  # handle errors (as messages)
  if (is.na(res)) {
    return(NA)
  }

  # czso call was successful, now digest the json results!
  res <-  res |>
    jsonlite::fromJSON()

  # all clear, return the results...
  res

} # /function
