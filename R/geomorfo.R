#' Geomorphological division of the Czech Republic
#'
#' Function returning one of the 8 levels of Geomorphological division of the Czech Republic, as specified by the obligatory parameter **level**.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to 2014 (3rd edition of Demek & Mackovčin's *Zeměpisný lexikon ČR. Hory a nížiny.*) Downloaded size is < 1 MB for any of the hierarchy levels.
#'
#' @param level level of geomorphological division. One of system, subsystem, provincie, subprovincie, oblast, celek, podcelek, okrsek.
#'
#' @return `sf` data frame with geomorfo division names & codes + geometry; namely:
#'
#' \describe{
#'   \item{system}{name of the system; 2 rows}
#'   \item{subsystem}{names of the system, subsystem + kod; 4 rows}
#'   \item{provincie}{name of the province; 4 rows}
#'   \item{subprovincie}{name of the subprovince + kod; 10 rows}
#'   \item{oblast}{name of the subprovince, oblast + kod; 27 rows}
#'   \item{celek}{name of the subprovince, oblast, celek + kod; 93 rows}
#'   \item{podcelek}{name of the subprovince, oblast, celek, podcelek + kod; 253 rows}
#'   \item{okrsek}{name of the subprovince, oblast, celek, podcelek, okrsek  + kod; 933 rows}
#' }
#'
#' @source CENIA / INSPIRE, via Mgr. Vojtěch Blažek, Ph.D. <https://www.arcgis.com/home/item.html?id=25813686a8564b0bbcdc951a5573cfa4>
#'
#' @export

geomorfo <- function(level) {

  if(missing(level)) {
    stop("geomorphological level is an obligatory parameter!")
  }

  if (!is.element(level, c("system", "subsystem", "provincie", "subprovincie", "oblast", "celek", "podcelek", "okrsek"))) {
    stop(paste(level, "is not a valid geomorphological division."))
  }

  translation_table = c("system" =  "geomorfo-system-2023-03.rds",
                        "subsystem" = "geomorfo-subsystem-2023-03.rds",
                        "provincie" =  "geomorfo-provincie-2023-03.rds",
                        "subprovincie" = "geomorfo-subprovincie-2023-03.rds",
                        "oblast" =  "geomorfo-oblast-2023-03.rds",
                        "celek" = "geomorfo-celek-2023-03.rds",
                        "podcelek" =  "geomorfo-podcelek-2023-03.rds",
                        "okrsek" = "geomorfo-okrsek-2023-03.rds")

  result <- .downloader(translation_table[[level]])
  result
}
