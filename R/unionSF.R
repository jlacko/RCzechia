#' Aggregate Polygons in a sf object
#'
#' The function aggregates polygons of a sf data frame according to values of a single column. It has outcome comparable to `unionSpatialPolygons` from `maptools` package, except that it works for sf and not sp objects.
#'
#' The function has data frame on the first position, so it is pipe friendly. It retains only geometry and key value, dropping all other columns.
#'
#' @param .data sf data frame to be aggregated
#' @param key name of column to define the output objects
#'

#'
#' @examples
#' library(sf)
#'
#' kraje <- unionSF(okresy(), "KOD_CZNUTS3")
#'   # returns CZ NUTS3 regions of Czech Republic = equivalent to kraje() in geometry, with a bunch of columns missing
#'
#'
#' @export
#' @importFrom magrittr %>%

unionSF <- function(.data, key) {

  if (missing(.data)) stop("required argument .data is missing")
  if (missing(key)) stop("required argument key is missing")
  if (!is.element("sf", class(.data))) stop(".data is not a sf object")
  if (!is.element(key, colnames(.data))) stop("key is not a recognized column of .data")

  wrk_crs <- sf::st_crs(.data) # save the current CRS
  .data <- sf::st_transform(.data, 5514) # transform to a temporary metric CRS

  ids <- .data[key] %>% # key column values
    sf::st_set_geometry(NULL) %>% # with geometry removed
    unique() # unique values only...

  for (i in 1:nrow(ids)) {
    vec <- sf::st_set_geometry(.data[key], NULL) == ids[i,] # rows matching current i

    wrk <- .data[vec, ] %>% # rows matching current i
      lwgeom::st_make_valid() %>%  # make valid, just in case...
      sf::st_buffer(0.5) %>% # sparkle some magical dust
      sf::st_union() %>% # unite!
      sf::st_sf() %>% # extract geometry only
      dplyr::mutate(key = ids[i,])

    if (i == 1) { # is this the first row?
      res <- wrk # assing current working data frame as result
    } else {
      res <- rbind(res, wrk) # append current working data frame to the result
    }
  }
  st_transform(res, wrk_crs) # return res in original CRS

}
