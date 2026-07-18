#' List DataStat Dimensions
#'
#' Experimental function to access the "new" DataStat API of Czech Statistical Office / ČSÚ.
#'
#' This function takes no arguments, and returns a data frame with data catalogue of DataStat dimensions, the most important part of which is the code (kod) and description (nazev).
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
#' # DataStat dimensions related to Artificial Intelligence
#'
#' result <- datastat_dimensions() |>
#'   subset(grepl("AI", nazev))
#'
#' result[,c("kod","nazev")]
#' }
#'
#' @export



datastat_dimensions <- function() {

  query <- "https://data.csu.gov.cz/api/katalog/v1/dimenze"

  res <- .get_czso(query)

  # handle errors (as messages)
  if (is.na(res)) {
    return(NA)
  }

  # czso call was successful, now digest the json results!
  res <-  res |>
    jsonlite::fromJSON() |>
    dplyr::mutate(urovneHierarchie = purrr::map_chr(urovneHierarchie, ~ paste(.x$kodUrovne, collapse = ", ")),
                  urovneDimenze = purrr::map_chr(urovneDimenze, ~ paste(.x$kodUrovne, collapse = ", ")),
                  pouziteCiselnikyKody = purrr::map_chr(pouziteCiselnikyKody, ~ paste(.x, collapse = ", ")))

  # all clear, return the results...
  res

} # /function
