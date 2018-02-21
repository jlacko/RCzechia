# RCzechia  [![Travis-CI Build Status](https://travis-ci.org/jlacko/RCzechia.svg?branch=master)](https://travis-ci.org/jlacko/RCzechia)

This project creates a set of shapefiles relevant to the Czech Republic.  

The shapefiles are based on ArcČR 500 (https://www.arcdata.cz/produkty/geograficka-data/arccr-500) with some adjustments:  
 * the encoding was adjusted to handle Czech accents correctly in R  
 * coordinate reference system was changed from a local CRS (S-JSTK) to global WGS84 ([EPSG:4326](https://epsg.io/4326))   
 * demographic data were removed, as they get out of date rather fast and are very easy to re-attach using the `sf` package workflow  
 * the shapefiles were slightly simplified to fit into memory better (still, the package comes over 50 MB - so load with care)

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



