#' Water bodies (vodni plochy) of the Czech Republic
#'
#' @format 480 water bodies of the Czech Repubic, as a sf data frame:
#' \describe{
#'   \item{TYP}{Type of water body: 1 = dam, 2 = pond, 3 = lake}
#'   \item{NAZEV}{Name, with Czech accents}
#'   \item{NAZEV_ASCII}{Name, without Czech accents}
#'   \item{VYSKA}{water level, meters above sea level}
#'   \item{Major}{Boolean indicating the major water bodies (= Lipno, Orlik, Slapy, Nechranice, Novomlynske nadrze.)}
#' }
"plochy"
