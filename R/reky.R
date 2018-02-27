#' Rivers (řeky) of the Czech Republic
#'
#' \itemize{
#'   \item{TYP}{Type of river: 1 =  natural, 2 = man-made, 3 = fictional}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{Major}{Boolean indicating the major rivers (= Labe, Vltava, Svratka, Morava, Berounka, Sazava, Odra, Dyje, Mze, Radbuza, Uslava, Ohre, Otava).}
#' }
#' @format sf data frame with 6.198 rows of 4 variables + geometry:
#'
#' @source ArcČR 500
#'
#' @example {
#'
#'
#' }
reky <- function() {
  remote_df <- url('http://rczechia.jla-data.net/Reky.rds')
  local_df <- readRDS(remote_df)
  local_df
}
