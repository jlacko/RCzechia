# RCzechia

This project creates a set of shapefiles (or rather Large SpatialPolygonDataFrames in R) relevant to the Czech Republic. The description will therefore continue in the Czech language.
- - - - 
Cílem mého snažení bylo připravit set objektů pro snazší práci s geografickými daty o České republice v rámci R. K dispozici sice je Arc500 (https://www.arcdata.cz/produkty/geograficka-data/arccr-500) se kterým se dá pomoci [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html) docela dobře pracovat, ale není to úplně uživatelsky vstřícné ani triviální (například způsob kódování češtiny jsem vůbec nepochopil). 

Souřadnicový systém je převedený z Křováka na WGS84, které se více kamarádí s google a ggplot2.

Tato package obsahuje několik shapefilů / Large Spatial objektů:
  * **republika**: Large SpatialPolygonDataFrame. Hranice České republiky.
  * **okresy**: Large SpatialPolygonDataFrame. Vychází z okresů Arc500, oproti kterým jsou upravena datová pole (populace a populace 15+ aktualizovaná k 1.1.2017).
  Pro doplnění dat doporučuju použít funkci `tmaptools::append_data`, například takto:  `outShape <- append_data(srcShape, frmData, key.shp = "KOD_LAU1", key.data = "LAU1")` LAU1 je okres.
  * **obce**: Large SpatialPolygonDataFrame. Vychází z obcí Arc500, stejně jako u okresů jsou aktualizovány data o populaci a vyčištěna datová pole.
  pro párování dat doporučuju `KOD_OBEC`, což je kód obce podle statistického úřadu.
  * **reky**:Large SpatialLinesDataFrame. Řeky z Arc500. Pro snazší orientaci jsem doplnil příznak `Major`, což jsou řeky z výčtu `c('Labe', 'Vltava', 'Svratka', 'Morava', 'Berounka', 'Sazava', 'Odra', 'Dyje', 'Mze', 'Radbuza','Uslava', 'Ohre', 'Otava')`. Přidáním do mapy pomohou základní orientaci.  
  * **plochy**:Large SpatialPolygonDataFrame. Vodní plochy z Arc500. Pro snazší orientaci jsem doplnil příznak `Major`, což jsou Lipno, Orlík, Slapy, Nechranice a Novomlýnské nádrže. Přidáním do mapy pomohou základní orientaci.  
  
Shapefily vycházejí z databáze Arc500, ©ArcČR, ARCDATA PRAHA, ZÚ, ČSÚ, 2016
