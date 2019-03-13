#' Reversely Geocode a Czech Address
#'
#' This function connects to Czech State Administration of Land Surveying and
#' Cadastre (\url{https://www.cuzk.cz/en}) API to reversely geocode an address.
#' As consequence it is implemented only for Czech addresses.
#'
#' As an input the function takes a \code{sf} data frame of spatial points, and
#' returns a vector of characters.
#'
#' The function returns the same \code{sf} data frame as input, with added field
#' revgeocoded; it contains the result of operation. If the data frame contained
#' a column named revgeocoded it gets overwritten.
#'
#' In case of reverse geocoding failures (e.g. coordinates outside of the Czech
#' Republic and therefore scope of ČÚZK) NA is returned.
#'
#' @param coords coordinates to be reverse geocoded; expected as \code{sf} data
#'   frame of spatial points
#'
#' @export
#' @importFrom magrittr %>%
#'


revgeo <- function(coords) {
  if (missing(coords)) stop("required argument coords is missing")
  if (!inherits(coords, "sf")) stop("coords is expected in sf format")
  if (sf::st_geometry_type(coords)[1] != 'POINT') stop("reverse geocoding is limited to sf point objects")

  coords$revgeocoded <- NULL # initiate result column in coords data frame

  coords_krovak <- sf::st_transform(coords, crs = 5514) # a temporary version of coords, in a very specific CRS

  # coordinates as a stirng understood by CUZK API
  coords_krovak$modified <- paste0(sf::st_coordinates(coords_krovak)[,"X"],
                            ",",
                            sf::st_coordinates(coords_krovak)[,"Y"])

  for (i in seq_along(coords_krovak$modified)) {

    query <- paste0("http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/tables/1/reverseGeocode",
              "?location=",coords_krovak$modified[i], "&f=pjson")

    resp <- httr::GET(query)

    httr::stop_for_status(resp)

    if (resp$status_code != 200) stop("error in connection to CUZK API")
      # error in connection

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
