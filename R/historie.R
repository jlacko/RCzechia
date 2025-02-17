#' Historical censuses of the Czech Republic
#'
#' Function returning historical admin areas of the Czech Republic, together with relevant census data as specified by parameter  **era**.
#'
#' The census data structure is too complex to fully list here; most of the fields are self documenting (for Czech speakers) - and when in doubt please consult the original metadata at <https://cuni.maps.arcgis.com/home/item.html?id=c2f19cd1146747a9a8daf5b900e7747b>, or the original journal article at \doi{https://doi.org/10.14712/23361980.2015.93}.
#'
#' Of notable interest is the 1930 census, which was the last before WWII - and thus the last one to include Czechoslovak citizens of German ethnicity.
#'
#' Due to package size constraints the data are stored externally (and a working internet connection is required to use the package).
#'
#'
#' @param era a historical era of interest.
#'
#' @return `sf` data frame with historical admin area names & census data + geometry; namely:
#'
#' \describe{
#'   \item{okresy_1921}{soudní okresy + census 1921; 328 rows / 92 columns + geometry}
#'   \item{okresy_1930}{soudní okresy + census 1931; 330 rows / 90 columns + geometry}
#'   \item{okresy_1947}{politické okresy + census 1947; 163 rows / 68 columns + geometry}
#'   \item{okresy_1950}{správní okresy + census 1950; 182 rows / 57 columns + geometry}
#'   \item{okresy_1961}{správní okresy + census 1960; 76 rows / 105 columns + geometry}
#'   \item{okresy_1970}{správní okresy + census 1970; 76 rows / 144 columns + geometry}
#'   \item{okresy_1980}{správní okresy + census 1980; 76 rows / 148 columns + geometry}
#'   \item{okresy_1991}{správní okresy + census 1991; 76 rows / 155 columns + geometry}
#'   \item{okresy_2001}{správní okresy + census 2001; 77 rows / 174 columns + geometry}
#'   \item{okresy_2011}{správní okresy + census 2011; 77 rows / 176 columns + geometry}
#'   \item{kraje_1950}{kraje + census 1950; 13 rows / 55 columns + geometry}
#'   \item{kraje_1961}{kraje + census 1960; 8 rows / 103 columns + geometry}
#'   \item{kraje_1970}{kraje + census 1970; 8 rows / 144 columns + geometry}
#'   \item{kraje_1980}{kraje + census 1980; 8 rows / 146 columns + geometry}
#'   \item{kraje_1991}{kraje + census 1991; 8 rows / 153 columns + geometry}
#'   \item{kraje_2001}{kraje + census 2001; 14 rows / 172 columns + geometry}
#'   \item{kraje_2011}{kraje + census 2011; 14 rows / 174 columns + geometry}
#' }
#'
#' Credits:
#' 1) „Tento výstup vznikl v rámci řešení projektu číslo DF12P01OVV033 Zpřístupnění historických prostorových a statistických dat v prostředí GIS řešeného v rámci programu Aplikovaného výzkumu a vývoje národní a kulturní identity (NAKI), jehož poskytovatel je Ministerstvo kultury České republiky.“
#' 2) „JÍCHOVÁ, J., SOUKUP, M., NEMEŠKAL, J., OUŘEDNÍČEK, M., POSPÍŠILOVÁ, L., SVOBODA, P., ŠPAČKOVÁ, P. a kol. (2014): Geodatabáze historických statistických a prostorových dat Česka ze Sčítání lidu, domů a bytů 1921-2011. Urbánní a regionální laboratoř, Přírodovědecká fakulta Univerzity Karlovy v Praze, Praha.“
#'
#' @source Urbánní a regionální laboratoř (UrRlab) působící na katedře sociální geografie a regionálního rozvoje Přírodovědecké fakulty Univerzity Karlovy v Praze <https://www.historickygis.cz/>
#'
#' @examples
#'
#' \donttest{
#' library(sf)
#'
#' pre_war <- RCzechia::historie("okresy_1930")
#'
#' plot(pre_war[, 47], main = "Residents of German ethnicity")
#'
#' }
#'
#' @export

historie <- function(era) {

  if(missing(era)) {
    stop("historical era is an obligatory parameter!")
  }

  if (!is.element(era, c("okresy_1921", "okresy_1930", "okresy_1947", "okresy_1950", "okresy_1961", "okresy_1970", "okresy_1980", "okresy_1991", "okresy_2001", "okresy_2011", "kraje_1950",  "kraje_1961", "kraje_1970",  "kraje_1980", "kraje_1991",  "kraje_2001", "kraje_2011"))) {
    stop(paste(era, "is not a valid historical era!"))
  }

  result <- .downloader(paste0("history_", era, "v2.rds"))
  result
}
