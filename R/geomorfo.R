#' Geomorphological division of the Czech Republic
#'
#' Bflm psvz boilerplate placeholder
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#' The data is current to December 2020. Downloaded size is 6 MB.
#'
#' @param level level of geomorphological division, one of system, subsystem, provincie, subprovincie, oblast, celek, podcelek, okrsek.
#'
#' @return `sf` data frame with 59.594 rows of 3 variables + geometry:
#'
#' \describe{
#'   \item{TRIDA}{Class of the road: highway = dálnice, speedway = rychlostní silnice, 1st class road = silnice I. třídy, 2nd class road = silnice II. třídy, 3rd class road = silnice III. třídy, other road = neevidovaná silnice}
#'   \item{CISLO_SILNICE}{Local road code}
#'   \item{MEZINARODNI_OZNACENI}{International road code}
#' }
#'
#' @source CENIA / INSPIRE, via Mgr. Vojtěch Blažek, Ph.D. <https://old.pf.jcu.cz/structure/departments/kge/blazek.html>
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
