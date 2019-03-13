#' Geocode a Czech Address
#'
#' This function connects to Czech State Administration of Land Surveying and
#' Cadastre (\url{https://www.cuzk.cz/en}) API to geocode an address. As
#' consequence it is implemented only for Czech addresses.
#'
#' As input the function takes an address to geocode (or a vector of addresses)
#' and expected Coordinate Reference System of output (mainly intended for, but
#' not limited to, either WGS84 = EPSG:4326 or inž. Křovák = EPSG:5514).
#'
#' It returns a \code{sf} data frame of spatial points.
#'
#' Depending on the outcome of matching the address to RÚIAN data there is a
#' number of possible outcomes:
#'
#' \itemize{
#'    \item{All items were matched exactly: the returned \code{sf} data
#'    frame has the same number of rows as there were elements in vector to
#'    be geocoded. The field \emph{target} will have zero duplicates.}
#'    \item{Some items had multiple matches: the returned \code{sf} data
#'    frame has more rows than the there were elements in vector to be geocoded.
#'    In the field \emph{target} will be duplicate values. Note that the RÚIAN API
#'    limits multiple matches to 10.}
#'    \item{Some (but not all) items had no match in RUIAN data: the returned
#'    \code{sf} data frame will have fewer rows than the vector
#'    to be geocoded elements. Some values will be missing from field \emph{target}}.
#'    \item{No items were matched at all: the function returns NA.
#' }}
#'
#'
#' @param address point to be geocoded, as character (vector)
#' @param crs coordinate reference system of output
#'
#' @format \code{sf} data frame with 3 variables + geometry
#'
#'   \describe{ \item{target}{the address searched (address input)}
#'   \item{typ}{type of record matched by API} \item{address}{address as
#'   recorded by RÚIAN}  \item{geometry}{hidden column with spatial point data}
#'   }
#'
#' @export
#' @importFrom magrittr %>%
#'


geocode <- function(address, crs = 4326) {
  if (missing(address)) stop("required argument address is missing")

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



    if (!is.null(s3)) { # was the current geocoding successful?

      # if yes, rbind the current result to global
      result <- result %>%
        rbind(cbind(target = address[i], # string queried
                    typ = typ["Type"], # type of response, as per ČÚZK
                    address = adresa["Match_addr"],   # address matched
                    x = s3["x"],  # x coordinate
                    y = s3["y"])) # y coordinate
    } # /if

  } # /for

  if(nrow(result) > 0) { # was the global geocoding successful?

    # if yes thenconvert to a sf object
    result <- sf::st_as_sf(result, coords = c("x", "y")) %>%
      sf::st_set_crs(crs) # set CRS as required
  } else {
    # if no, then report a failure
    result <- NA
  } # /if

  result # all set :)
} # /function
