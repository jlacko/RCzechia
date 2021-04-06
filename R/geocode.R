#' Geocode a Czech Address
#'
#' This function connects to Czech State Administration of Land Surveying and
#' Cadastre (\url{https://www.cuzk.cz/en}) API to geocode an address. As
#' consequence it is implemented only for Czech addresses.
#'
#' Input of the function are an address to geocode (or a vector of addresses)
#' and expected Coordinate Reference System of output (default is WGS84 =
#' EPSG:4326, but in some use cases inž. Křovák = EPSG:5514 may be more
#' relevant).
#'
#' NA's in input are considered an error.
#'
#' Output is a \code{sf} data frame of spatial points.
#'
#' Depending on the outcome of matching the address to RÚIAN data there is a
#' number of possible outcomes:
#'
#' \itemize{
#'    \item{All items were *matched exactly*: the returned \code{sf} data
#'    frame has the same number of rows as there were elements in vector to
#'    be geocoded. The field \emph{target} will have zero duplicates.}
#'    \item{Some items had *multiple matches*: the returned \code{sf} data
#'    frame has more rows than the there were elements in vector to be geocoded.
#'    In the field \emph{target} will be duplicate values. Note that the RÚIAN API
#'    limits multiple matches to 10.}
#'    \item{Some (but not all) items had *no match* in RUIAN data: the returned
#'    \code{sf} data frame will have fewer rows than the vector sent.
#'    to be geocoded elements. Some values will be missing from field \emph{target}}.
#'    \item{No items were matched at all: the function returns empty data frame and a message.}
#'    \item{The CUZK API is down or overloaded: the function returns empty data frame and a message.}
#'    }
#'
#' Note that character encoding is heavily platform dependent, and you may need to convert to UTF-8,
#' e.g. by running \code{address <- iconv(address, from = "windows-1250", to = "UTF-8")}
#' before calling the function.
#'
#' Usage of the ČÚZK API is governed by ČÚZK Terms & Conditions -
#' \url{https://geoportal.cuzk.cz/Dokumenty/Podminky.pdf}.
#'
#' @param address point to be geocoded, as character (vector)
#' @param crs coordinate reference system of output; default = WGS84
#'
#' @format \code{sf} data frame with 3 variables + geometry
#'
#'   \describe{
#'     \item{address}{the address searched (address input)}
#'     \item{type}{type of record matched by API}
#'     \item{result}{address as returned by API / recorded in RÚIAN}
#'     \item{geometry}{hidden column with spatial point data}
#'   }
#'
#'
#' @examples
#' \donttest{
#' asdf <- geocode("Gogolova 212, Praha 1")
#' print(asdf)
#' }
#' @export
#'


geocode <- function(address, crs = 4326) {
  network <- as.logical(Sys.getenv("NETWORK_UP", unset = TRUE)) # dummy variable to allow testing of network
  cuzk <- as.logical(Sys.getenv("CUZK_UP", unset = TRUE)) # dummy variable to allow testing of network

  # initiation - empty (so far)
  result <- data.frame(
    address = character(),
    typ = character(),
    result = character(),
    x = double(),
    y = double()
  )

  # fall back object - empty, but in formally "correct" structure
  fallback <- data.frame(
    address = c(NA_character_),
    type = c(NA_character_),
    result = c(NA_character_)
    ) %>%
    sf::st_sf(geometry = sf::st_sfc(NULL,
                                    crs = 4326))


  if (missing(address)) {
    warning("required argument address is missing")
    return(fallback)

  }

  if(any(is.na(address))) {
    warning("NAs in address field are not an accepted form of input.")
    return(fallback)
  }

  if (!curl::has_internet() | !network) { # network is down
    message("No internet connection.")
    return(fallback)
  }


  for (i in seq_along(address)) {
    cil <- gsub(" ", "+", address[i]) %>% # spaces to pluses (for url use)
      utils::URLencode() # get rid of funny Czech characters

    query <- paste0(
      "http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/find",
      "?text=", cil, "&outSR=", crs, "&maxLocations50=&f=pjson"
    )


    if (!ok_to_proceed(query) | !cuzk) { # error in connection?
      message("Error in connection to CUZK API.")
      return(fallback)
    }

    resp <- httr::GET(query)

    httr::stop_for_status(resp)

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

    if (!is.null(s3)) { # was the *current* geocoding successful?

      # if yes, rbind the current result to global
      result <- result %>%
        rbind(data.frame(
          target = address[i], # string queried
          typ = typ["Type"], # type of response, as per https://cuzk.cz/
          address = adresa["Match_addr"], # address matched
          x = s3["x"], # x coordinate
          y = s3["y"]
        )) # y coordinate
    } # /if
  } # /for

  if (nrow(result) <= 0) { # was the *global* geocoding successful?
    # if no, then report a failure
    message("CUZK API returned no match for any of the adresses provided.")
    return(fallback)
  } # /if

  colnames(result) <- c("address", "type", "result", "x", "y") # get the names right

  # add the special {sf} sauce to a regular data frame...
  result <- sf::st_as_sf(result,
                         coords = c("x", "y"),
                         crs = crs,
                         agr = "constant")

  result # all set :)
} # /function
