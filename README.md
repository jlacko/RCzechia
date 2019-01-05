# RCzechia  [![Travis-CI Build Status](https://travis-ci.org/jlacko/RCzechia.svg?branch=master)](https://travis-ci.org/jlacko/RCzechia)  [![Coverage Status](https://coveralls.io/repos/github/jlacko/RCzechia/badge.svg?branch=master)](https://coveralls.io/github/jlacko/RCzechia?branch=master) [![CRAN](http://www.r-pkg.org/badges/version/RCzechia)](https://cran.r-project.org/package=RCzechia) [![Downloads-total](http://cranlogs.r-pkg.org/badges/grand-total/RCzechia?color=brightgreen)](http://www.r-pkg.org/pkg/RCzechia) [![Downloads-weekly](http://cranlogs.r-pkg.org/badges/last-week/RCzechia?color=brightgreen)](http://www.r-pkg.org/pkg/RCzechia)
This project downloads a set of shapefiles relevant to the Czech Republic. It was inspired by the popular [`tigris`](https://github.com/walkerke/tigris) package for US datasets.  

<p align="center">
  <img src="https://github.com/jlacko/RCzechia/blob/master/data-raw/kraje-lo-res.png?raw=true" alt="Kraje České republiky"/>
</p>

The shapefiles are based on ArcČR 500 (https://www.arcdata.cz/produkty/geograficka-data/arccr-500) with some adjustments:  
 * the encoding was adjusted to handle Czech accents correctly in R  
 * coordinate reference system was changed from a local CRS ([S-JSTK](https://epsg.io/5513-1623)) to global WGS84 ([EPSG:4326](https://epsg.io/4326))   
 * demographic data were removed, as they get out of date rather fast and are very easy to re-attach using the `sf` and `tidyverse` workflow  
 * the shapefiles were slightly simplified to fit into memory better  

The default resolution is 1 meter; this makes the shapefiles 1) very accurate and 2) rather large. This level of detail is not always necessary, and often not beneficial - a lower resolution shapefile is not only smaller in memory, but also smoother and more aesthetically pleasing. For the most commonly used shapes (*republika*, *kraje* and *okresy*) an optional low resolution version is also included. To access it specify the value of `resolution` parameter as `"low"` (default is `"high"`).

Using of the lo-res versions does not require a working internet connection. To use the high resolution (default) shapefile a working intenet connection is necessary, as the data files were too big to meet the CRAN requirements on package size and must be stored externally. Access to the external files is logged, from time to time I check the logs (mainly to understand my bandwidth charges).

### A note to Czech users
Tohle je "oficiální", a tedy anglické, readme. Českou verzi naleznete na http://www.jla-data.net/cze/package-rczechia/

### Installation
The package is on CRAN (as of March 2018) so to get a stable version simply run:
```r 
install.packages("RCzechia")
```
You can also get the latest development version by running `devtools::install_github("jlacko/RCzechia")` and the last version built on [`sp`](https://github.com/edzer/sp) instead of [`sf`](https://github.com/r-spatial/sf) package by running  `devtools::install_github("jlacko/RCzechia", ref = "v0.1.4")`. 

### The following spatial objects are included:  
* **republika**: borders of the Czech Republic
* **kraje**: 14 regions of the Czech Republic + Prague.  
Key is KOD_CZNUTS3 (CZ NUTS3 code).
* **okresy**: 76 districts (LAU1 areas) of the Czech Republic + Prague (legally not *a district* but *the capital*).  
Key is KOD_LAU1 (CZ LAU1 code).
* **orp_polygony** 205 municipalities with extended powers (in Czech: obce s rozšířenou působností) + Prague (legally not *a city* but *the capital*).  
Key is KOD_ORP.
* **obce_polygony**: 6.258 municipalities of the Czech Republic.  
Key is KOD_OBEC, also contained are KOD_ORP (code of municipality with extended powers; see above) and KOD_POV (kód pověřené obce)
* **obce_body** the same as obce_polygony, but centroids instead of polygons.  
Key is again KOD_OBEC.
* **casti**: primarily 57 city parts of Prague, but also of other cities with defined parts (Brno, Ostrava..).  
Key is KOD.
* **reky**: streams and rivers
* **plochy**: stillwaters (lakes and ponds).
* **silnice**: roads (highways, speedways etc.)
* **zeleznice**: railroads
* **chr_uzemi**: protected natural areas (Chráněná území)
* **lesy**: woodland areas (more than 30 ha in area)

All objects are implemented as functions returning data frames, so must be followed by brackets (i.e. `hranice <- republika()`).
