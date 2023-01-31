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
#' on user's side is not attempted.
#'
#' This means that:
#' \itemize{
#'   \item a working internet connection is required to use the full resolution objects
#'   \item all objects need to be called with (possibly empty) braces
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
#' |  **Function call**  |  **Description**  |  **Data Source**  |  **High-Res**  |  **Low-Res** |
#' | -------- | ------- | ------- | -------------: | ------------: |
#' | republika | borders of the Czech Republic | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx) | 245.8 KB | internal |
#' | kraje | 14 regions / NUTS3 units | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx) | 982.2 KB | internal |
#' | okresy | 76 + 1 districts / LAU1 units | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx) | 2.1 MB | internal |
#' | orp_polygony | 205 + 1 municipalities with extended powers | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx) | 3.1 MB | *NA* |
#' | obce_polygony | 6.258 municipalities as polygons | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx) | 13.3 MB | *NA* |
#' | obce_body | 6.258 municipalities as centroids (points) | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx) | 252.0 KB | *NA* |
#' | casti | 57 city districts (where available) | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx) | 1.5 MB | *NA* |
#' | senat_obvody | 81 senate districts | [Czech Statistical Office](https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu) | 10.5 MB | 50.0 KB |
#' | volebni_okrsky | 14.733 general election districts | [RÚIAN / ČÚZK](https://www.cuzk.cz/ruian/RUIAN.aspx)  | 75.8 MB | 5.0 MB |
#' | zip_codes | 2.671 ZIP code areas | [Czech Statistical Office](https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu) | 45.4 MB | 2.1 MB |
#' | reky | rivers | [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?lng=EN&menu=2292&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-VODSTVO-V) | 4.4 MB | 301.4 KB |
#' | plochy | water bodies | [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?lng=EN&menu=2292&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-VODSTVO-V) | 687.0 KB | *NA* |
#' | lesy | woodland areas | [ArcČR 500 v3.3](https://www.arcdata.cz/produkty/geograficka-data/arccr-4) | 2.1 MB | *NA* |
#' | silnice | roads | [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?menu=2296&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-DOPRAVA-V) | 6.0 MB | *NA* |
#' | zeleznice | railroads | [Data200](https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?menu=2296&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-DOPRAVA-V) | 805.8 KB | *NA* |
#' | KFME_grid | KFME grid cells (faunistické čtverce) | *NA* | internal | *NA* |
#' | chr_uzemi | protected natural areas | [AOPK ČR](https://data.nature.cz/) | 7.0 MB | *NA* |
#' | vyskopis | terrain relief | [Copernicus EU](https://land.copernicus.eu/imagery-in-situ/eu-dem) | 68.8 MB | *NA* |
#'
#' @section Utility functions:
#' In addition three utility functions are implemented to support spatial
#' workflow:
#'
#' \itemize{
#'   \item geocode - geocoding (from address to coordinates)
#'   \item revgeo - reverse geocoding (from coordinates to address)
#' }
#'
#' @docType package
#' @name RCzechia-package
#'
#' @import sf
#' @importFrom httr http_error
#' @importFrom curl curl_download
#' @importFrom magrittr %>%

NULL
