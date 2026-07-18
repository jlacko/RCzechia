#' Get Dataset from DataStat
#'
#' Experimental function to access the "new" DataStat API of Czech Statistical Office / ČSÚ.
#'
#' This function takes as argument code of the dataset, and returns its content as a data frame.
#'
#' The function leverages the functionality of JSON_STAT data format, so that either human readable labels, or machine readable codes are returned - this is driven by \code{naming} parameter to the function, which is passed directly to the \code{naming} parameter of the rjstat::fromJSONstat() function used internally.
#'
#' The function returns the dataset "as it is", without attempting to translate structure or content from the original Czech language.
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
#' @seealso [RCzechia::datastat_metrics()] [RCzechia::datastat_dimensions()] [RCzechia::datastat_catalogue()] [rjstat::fromJSONstat()]
#'
#' @examples
#'
#' \donttest{
#' # Unemployment statistics of Czechia
#'
#' unempl <- datastat_dataset("NEZ01", "id") |>
#'   subset(UZ023H2U == "CZ"  # the country as a whole
#'          & IndicatorType == "5973DI"  # unemployement rate
#'          )
#'
#' plot(value ~ CasR, data = unempl, main = "Unemployment in Czechia",
#'      ylab = "value", xlab = "year")
#'}
#'
#' @export



datastat_dataset <- function(kod = "NEZ01", naming = "label") {

  query <- paste0("https://data.csu.gov.cz/opendata/sady/", kod, "/distribuce/json")

  res <- .get_czso(query)

  # handle errors (as messages)
  if (is.na(res)) {
    return(NA)
  } # /if errors in CZSO call

  # czso call was successful, now digest the json results!
  res <-  res |>
    rjstat::fromJSONstat(naming = naming)

  # all clear, return the results...
  res

} # /function
