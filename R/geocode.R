#' Geocode a Czech Address
#'
#' tohle jednou bude vooostrá geokódovací funkce nad RÚIAN
#'
#' @param address point to be geocoded
#' @param crs coordinate reference system of output
#'
#' @export
#' @importFrom magrittr %>%
#'


geocode <- function(address, crs = 4326) {
  if (missing(address)) stop("required argument address is missing")
  if (length(address)>500) stop("geocoding is limited to 500 points")

  result <- data.frame() # initiation; empty...

  for (i in seq_along(address)) {

    cil <- gsub(" ", "+", address[i]) %>% # spaces to pluses (for url use)
#      utils::enc2utf8() %>% # do UTF-8
      utils::URLencode() # get rid of funny Czech characters

    query <- paste0("http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/find",
              "?text=", cil, "&outSR=", crs, "&maxLocations50=&f=pjson")

    resp <- httr::GET(query)

    httr::stop_for_status(resp)

    if (resp$status_code != 200) stop("error in connection to CUZK API")
      # error in connection

    # geocoding was successful, now digest the json results!

    typ <- httr::content(resp) %>%
      jsonlite::fromJSON() %>%
      magrittr::extract2("locations") %>%
      magrittr::extract2("feature") %>%
      magrittr::extract2("attributes")

    adresa <- httr::content(resp) %>%
      jsonlite::fromJSON() %>%
      magrittr::extract2("locations") %>%
      magrittr::extract2("feature") %>%
      magrittr::extract2("attributes")

    s3 <- httr::content(resp) %>%
      jsonlite::fromJSON() %>%
      magrittr::extract2("locations") %>%
      magrittr::extract2("feature") %>%
      magrittr::extract2("geometry")


    # rbind the current iteration of results to dataframe of global results
    result <- result %>%
      rbind(cbind(target = address[i], # string queried
                  typ = typ["Type"], # type of response, as per ČÚZK
                  address = adresa["Match_addr"], # address matched
                  s3["x"],  # x coordinate
                  s3["y"])) # y coordinate
  }

  # convert to a sf object
  result <- sf::st_as_sf(result, coords = c("x", "y")) %>%
    sf::st_set_crs(crs) # set CRS as required

  result # all set :)
}
