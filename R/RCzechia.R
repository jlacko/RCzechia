#' RCzechia: Spatial Objects of the Czech Republic
#'
#' A selection of spatial objects relevant to the Czech Republic. Due to CRAN
#' package size requirements (5 MB) the objects are stored externally (on Amazon
#' S3) - and therefore could not be implemented as datasets. They are functions
#' returning data frames instead.
#'
#' To save time (and bandwidth) the downloaded objects are saved locally in
#' `tempdir` directory when requested, and downloaded at most once *per R
#' session*; out of respect to CRAN Repository Policy a more permanent caching
#' on user's side is not attempted by default – but it can be actively introduced
#' by the user either via a \code{RCzechia::set_home()} call or by setting the
#' value of `RCZECHIA_HOME` environment variable directly, either using a
#' \code{Sys.setenv()} call or via editing the \code{.Renviron} file.
#'
#' This means that:
#' \itemize{
#'   \item a working internet connection is required to use the full resolution objects
#'   \item the first call to an object in a R session will download
#'   the object from the internet (and thus take some time)
#'   \item the user an has an option to create a permanent local cache of the objects
#'   by setting the `RCZECHIA_HOME` environment variable in her  \code{.Renviron} file,
#'   gaining a faster access to the objects in the future and sidestepping the
#'   requirement of a working internet connection. Out of respect to CRAN
#'   Repository Policy this is not default behavior.
#' }
#'
#' For the most frequently used objects - **republika**, **kraje** and
#' **okresy** - a low resolution version is also implemented. The low
#' resolution data sets are stored locally (and working internet connection is
#' not necessary to use them).
#'
#' All objects are implemented as `sf` data frames.
#'
#' @section Data overview & download sizes:
#'
#' \itemize{
#'  \item *republika* - borders of the Czech Republic
#'
#'   source: [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 245.8 KB, low res version internal
#'
#'  \item *kraje* - 14 regions / NUTS3 units
#'
#'  source: [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 982.2 KB, low res version internal
#'  \item *okresy* - 76 + 1 districts / LAU1 units
#'
#'  source:  [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 2.1 MB, low res version internal
#'  \item *orp_polygony* - 205 + 1 municipalities with extended powers
#'
#'  source: [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 3.1 MB, no low res version
#'  \item *obce_polygony* - 6.258 municipalities as polygons
#'
#'  source:  [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 13.3 MB, no low res version
#'  \item *obce_body* - 6.258 municipalities as centroids (points)
#'
#'  source: [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 252.0 KB, no low res version
#'  \item *casti* - 57 city districts (where available)
#'
#'  source:  [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 1.5 MB, no low res version
#'  \item *senat_obvody* - 81 senate districts
#'
#'  source:  [Czech Statistical Office](https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu), high res object: 10.5 MB, low res object: 50.0 KB
#'  \item *volebni_okrsky* - 14.733 general election districts
#'
#'  source:  [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx), high res object: 75.8 MB, low res object:  5.0 MB
#'  \item *zip_codes* - 2.671 ZIP code areas
#'
#'  source:  [Czech Statistical Office](https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu), high res object: 45.4 MB, low res object: 2.1 MB
#'  \item *reky* - rivers
#'
#'  source:  [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?lng=EN&menu=2292&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-VODSTVO-V), high res object: 4.4 MB, low res object: 301.4 KB
#'  \item *plochy* - water bodies
#'
#'  source:  [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?lng=EN&menu=2292&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-VODSTVO-V), high res object: 687.0 KB, no low res version
#'  \item *lesy* - woodland areas
#'
#'  source:  [ArcČR 500 v3.3](https://www.arcdata.cz/cs-cz/produkty/data/arccr?rsource=https%3A%2F%2Fwww.arcdata.cz%2Fprodukty%2Fgeograficka-data%2Farccr-4), high res object: 2.1 MB, no low res version
#'  \item *silnice* - roads
#'
#'  source:  [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?menu=2296&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-DOPRAVA-V), high res object: 6.0 MB, no low res version
#'  \item *zeleznice* - railroads
#'
#'  source:  [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?menu=2296&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-DOPRAVA-V), high res object: 805.8 KB, no low res version
#'  \item *KFME_grid* - KFME grid cells (faunistické čtverce)
#'
#'  source:  own work,  internal
#'  \item *chr_uzemi* - protected natural areas
#'
#'  source:  [AOPK ČR](https://data.nature.cz/), high res object: 7.0 MB, no low res version
#'  \item *vyskopis* - terrain relief
#'
#'  source:  [Copernicus EU](https://land.copernicus.eu/en/products/products-that-are-no-longer-disseminated-on-the-clms-website), high res object: 68.8 MB, no low res version
#'  \item *geomorfo* - geomorphological divisions
#'
#'  source:  [CENIA / INSPIRE](https://www.arcgis.com/home/item.html?id=25813686a8564b0bbcdc951a5573cfa4), high res object: <1 MB, no low res version
#'  \item *historie* - historical admin areas and census records, download size ~ 100 KB to 3.5 MB depending on object
#'
#'  source: [URRlab](https://www.historickygis.cz/)
#'
#' }
#'
#' @section Utility functions:
#' In addition the following utility functions are implemented to support spatial
#' workflow:
#'
#' \itemize{
#'   \item *geocode* - geocoding (from address to coordinates)
#'   \item *revgeo* - reverse geocoding (from coordinates to address)
#' }
#' @references
#' Lacko J (2023). “RCzechia: Spatial Objects of the Czech Republic.” Journal of Open Source Software, 8(83). doi:10.21105/joss.05082, https://joss.theoj.org/papers/10.21105/joss.05082.
#'
#' @import sf
#' @importFrom httr http_error
#' @importFrom curl curl_download
#' @importFrom magrittr %>%

"_PACKAGE"
