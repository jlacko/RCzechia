#' Reversely Geocode a Czech Address
#'
#' tohle jednou bude vooostrá geokódovací funkce nad RÚIAN
#'
#' @param coords coordinates to be reverse geocoded; expected as sf spatial_points format
#'
#' @export
#' @importFrom magrittr %>%
#'


revgeo <- function(coords) {
  if (missing(coords)) stop("required argument coords is missing")
  if (!inherits(coords, "sf")) stop("coords is expected in sf format")
  if (nrow(coords)>500) stop("reverse geocoding is limited to 500 points")
  if (sf::st_geometry_type(coords)[1] != 'POINT') stop("reverse geocoding is limited to sf point objects")

  coords <- sf::st_transform(coords, crs = 5514) # jeden Křovák vládne všem...

  coords$modified <- paste0(sf::st_coordinates(coords)[,"X"], # as understood by CUZK API
                            ",",
                            sf::st_coordinates(coords)[,"Y"])

  result <- character() # initiation; empty character vector

  for (i in seq_along(coords$modified)) {

    query <- paste0("http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/tables/1/reverseGeocode",
              "?location=",coords$modified[i], "&f=pjson")

    resp <- httr::GET(query)

    httr::stop_for_status(resp)

    if (resp$status_code != 200) stop("error in connection to CUZK API")
      # error in connection

    # reverse geocoding was successful, now digest the json results!

    adresa <- httr::content(resp) %>%
      jsonlite::fromJSON() %>%
      magrittr::extract2("address")

    if (is.null(adresa)) adresa["Address"]$Address <- NA # if no result was found then return NA (and not NULL)

    # bind the current iteration of results to vector of global results
    result <- c(result, adresa["Address"]$Address) # address matched
  }

  # convert to a sf object

  result # all set :)
}
