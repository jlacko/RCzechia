#' Reversely Geocode a Czech Address
#'
#' This function connects to Czech State Administration of Land Surveying and
#' Cadastre (<https://www.cuzk.cz/en>) API to reversely geocode an address.
#' As consequence it is implemented only for Czech addresses.
#'
#' Input of the function is a `sf` data frame of spatial points, and
#' output a vector of characters.
#'
#' The function returns the same `sf` data frame as input, with added field
#' revgeocoded; it contains the result of operation. Should the data frame contain
#' a column named revgeocoded it will be overwritten.
#'
#' In case of reverse geocoding failures (e.g. coordinates outside of the Czech
#' Republic and therefore scope of ČÚZK) NA is returned.
#'
#' In case of API failures (CUZK down) the function returns NAs again, with a message.
#'
#' Usage of the ČÚZK API is governed by ČÚZK Terms & Conditions -
#' <https://geoportal.cuzk.cz/Dokumenty/Podminky.pdf>.
#'
#' @param coords coordinates to be reverse geocoded; expected as `sf` data
#'   frame of spatial points
#'
#' @return `sf` data frame as input, with column revgeocoded added (or overwritten)
#'
#' @examples
#' \donttest{
#' library(dplyr)
#' library(sf)
#'
#' brno <- obce_polygony() %>% # shapefile of Brno
#'   filter(NAZ_OBEC == "Brno") %>%
#'   st_transform(5514) # planar CRS (eastings & northings)
#'
#' pupek_brna <- st_centroid(brno) # calculate centroid
#'
#' adresa_pupku <- revgeo(pupek_brna)$revgeocoded # address of the center
#' }
#' @export



revgeo <- function(coords) {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  cuzk <- as.logical(Sys.getenv("CUZK_UP", unset = TRUE)) # dummy variable to allow testing of network


  if (missing(coords)) {
    warning("required argument coords is missing")
    return(NULL)  # nothing better to return, since nothing was provided...
  }

  if (!inherits(coords, "sf")) {
    warning("coords is expected in sf format")
    return(coords)
  }

  coords$revgeocoded <- NA # initiate result column in coords data frame

  if (sf::st_geometry_type(coords)[1] != "POINT") {
    warning("reverse geocoding is limited to sf point objects")
    return(coords)
  }


  if (!curl::has_internet() | !network) { # network is down
    message("No internet connection.")
    return(coords)
  }

  coords_krovak <- sf::st_transform(coords, crs = 5514) # a temporary version of coords, in a very specific CRS

  # coordinates as a string understood by CUZK API
  coords_krovak$modified <- paste0(
    sf::st_coordinates(coords_krovak)[, "X"],
    ",",
    sf::st_coordinates(coords_krovak)[, "Y"]
  )

  for (i in seq_along(coords_krovak$modified)) {
    query <- paste0(
      "http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/tables/1/reverseGeocode",
      "?location=", coords_krovak$modified[i], "&f=pjson"
    )

    if (httr::http_error(query) | !cuzk) { # error in connection?
      message("Error in connection to CUZK API.")
      return(coords)
    }

    resp <- httr::GET(query)

    httr::stop_for_status(resp)

    # reverse geocoding was successful, now digest the json results!

    adresa <- httr::content(resp) %>%
      jsonlite::fromJSON() %>%
      magrittr::extract2("address")

    if (is.null(adresa)) adresa["Address"]$Address <- NA # if no result was found then return NA (and not NULL)

    # update the value in coords data frame
    coords$revgeocoded[i] <- adresa["Address"]$Address
  } # /for

  coords # all set :)

} # /function
