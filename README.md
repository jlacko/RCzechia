# RCzechia

This project creates a set of shapefiles (or rather Large SpatialPolygonDataFrames in R) relevant to the Czech Republic. The description will therefore continue in the Czech language.
- - - - - 
Cílem mého snažení bylo připravit set objektů pro snazší práci s geografickými daty o České republice v rámci R. 

K dispozici sice je Arc500 (https://www.arcdata.cz/produkty/geograficka-data/arccr-500) se kterým se z Rka dá přes [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html) docela dobře pracovat, ale není to ani úplně uživatelsky vstřícné ani triviální (například způsob kódování češtiny jsem vůbec nepochopil). Shapefily jsem trochu upravil pro snazší práci v R.

Souřadnicový systém je převedený z Křováka na WGS84, které se více kamarádí s google aplikacemi a ggplot2. Zastaralá a nadbytečná datová pole jsem odstranil, populaci okresů a obcí naopak aktualizoval k 1.1.2017. Počty obvyvatel jsou 1) celkové a 2) patnáct plus.

Package obsahuje tyto Large Spatial objekty:
* **republika**: Large SpatialPolygonDataFrame. Hranice České republiky.

* **okresy**: Large SpatialPolygonDataFrame. 77 okresů České republiky + Praha jedním polygonem. Název okresu je v diakritické češtině.  
Klíč pro připojení dat je KOD_LAU1 (kód okresu).

* **obce**: Large SpatialPolygonDataFrame. Obce a vojenské újezdy České republiky. Název obce je v diakritické češtině.  
Klíč pro připojení dat je  KOD_OBEC, v data frame jsou naví informace o příslušné obci s pověřeným obecním úřadem (tzv. dvojkové obce - KOD_POV, respektive PovObec) a příslušné obci s rozšířenou působností (tzv. trojkové obce - KOD_ROZ, respektive RozObec).

* **reky**: Large SpatialLinesDataFrame. Řeky České republiky. Přidáním do slepé pomohou základní orientaci.  

* **plochy**: Large SpatialPolygonDataFrame. Vodní plochy České republiky. Přidáním do mapy pomohou základní orientaci.
  
Shapefily vycházejí z Arc500, ©ArcČR, ARCDATA PRAHA, ZÚ, ČSÚ, 2016
