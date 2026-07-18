#' Query DataStat Datasets
#'
#' Experimental function to access the "new" DataStat API of Czech Statistical Office / ČSÚ.
#'
#' This function takes as argument either a dimension or a metric, and returns a data frame listing datasets using the supplied dimension or metric.
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
#' \donttest{
#' # DataStat datasets related to Artificial Intelligence
#'
#' result <- datastat_query(dimension = "DRUHTECHAI")
#'
#' result[,c("kod","nazev")]
#' }
#'
#' @export



datastat_query <- function(dimension = NULL, metric = NULL) {

  if (missing(dimension) & missing(metric)) {
    warning("either dimension or metric must be provided")
    return(NULL)  # nothing better to return, since nothing was provided...
  }

  if (length(dimension) > 0 & length(metric) > 0) {
    warning("only one of dimension and metric must be provided")
    return(NULL)  # nothing better to return, since nothing was provided...
  }

  if (length(dimension) > 1) {
    warning("a single dimension is expected")
    return(NULL)  # nothing better to return, since nothing was provided...
  }

  if (length(metric) > 1) {
    warning("a single metric is expected")
    return(NULL)  # nothing better to return, since nothing was provided...
  }

  if (length(dimension) == 1) {
    # querying for a dimension
    query <- paste0("https://data.csu.gov.cz/api/katalog/v1/dimenze/", dimension, "/sady")
  } else {
    # querying for a metric
    query <- paste0("https://data.csu.gov.cz/api/katalog/v1/ukazatele/", metric, "/sady")
  }

  res <- .get_czso(query)

  # handle errors (as messages)
  if (is.na(res)) {
    return(NA)
  }

  # czso call was successful, now digest the json results!
  res <-  res |>
    jsonlite::fromJSON()|>
    dplyr::mutate(urovneTypObdobi = purrr::map_chr(urovneTypObdobi, ~ paste(.x$nazevUrovne, collapse = ", ")),
                  urovneTypUzemi = purrr::map_chr(urovneTypUzemi, ~ paste(.x$nazevUrovne, collapse = ", ")))

  # all clear, return the results...
  res

} # /function
