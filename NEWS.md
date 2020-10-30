## version 1.6.1

  - union_sf removed entirely (after being deprecated in 1.6.1)
  
  - handling of remotely stored datasets amended to better align with the variety of PROJ versions supported


## version 1.6.0

  - [!] all data objects now explicitly state the month for which the data is current

  - protected areas (chráněná území) based on AOPK open data instead of former ARC ČR500; the AOPK data are more current
  
  - small scale protected areas (maloplošná chráněná území) are included in output of chr_uzemi(); extra dimension to the dataset to diffentiate small and large scale protected areas added. The downloaded file size increased to 7 MB.
  
  - dimension of ZUJ (základní územní jednotka) removed from obce datasets, in line with move to RÚIAN as main source of administrative units. RÚIAN does not support this metric, and it does not map easily to obce (a ZUJ is sometimes an obec, and sometimes a část).
  
  - union_sf() function is deprecated, as it has little connection to the Czech Republic; it is being moved to (so far experimental) package of spatial helper functions
  
  - dimensionality of ORP (obce s rozšířenou působností) was reduced - district / okres and shortened name were removed. This reflects the cardinality of dimensions - ORP do not map to okres 1:n, but m:n (several ORPs are spread over multiple districts, eg. Jihlava, Tanvald or Stod). Kraj was retained, as it maps 1:n (each ORP can be mapped to a single kraj).

## version 1.5.3
  
  - bugfix in simplified shapefiles / kraje("low")
  
  - unit tests updated
  
  - url of vanity badges changed to https

## version 1.5.1

  - minor correction of simplified shapefiles (low res objects)

## version 1.5.0

  - [!] administrative areas based on RÚIAN generalised boundaries instead of former ARC ČR500; this results in a negligible loss of accuracy, and a significant reduction of size (and dowload time)
  
  - special cases of rivers object implemented for easier visualization of Prague and Brno maps
  
  - unit tests reflect recent changes in PROJ

## version 1.4.6

  - dependency on lwgeom decomissioned (st_make_valid moved to sf)
  
## version 1.4.5
  
  - tidyverse style guide applied
  
  - examples updated to resolve warnings
  
  - bug in union_sf() corrected

## version 1.4.3

  - vyskopis() function added to facilitate rasters of Czech relief; dependency on {raster} introduced
  
  - dependency on {sf} changed from Imports to Depends (loading of RCzechia triggers a load of sf)

  - dependency on {tmap} decommissioned, vignette refactored to {ggplot2} & {leaflet} only

## version 1.4.2

  - KFME grid cells (faunistické čtverce) object added
  
  - minor optimization of geocode() and tests 

## version 1.4.1

  - downgraded error on unavailable internet to message in line with updates to CRAN policy
  
  - internal optimization
 
## version 1.4.0

  - introduced geocode and revgeo functions (via ČÚZK API)
  
  - optimization of documentation and vignette

## version 1.3.3

  - upgraded shapefile downloads from http:// to https://

## version 1.3.2

  - updated vignette (Czech Population) to reflect changes in readxl package

## version 1.3.1  

  - replaced internally utils::download.file() by curl::curl_download() to improve compatibility

## version 1.3.0  

  - new objects / functions added: silnice, zeleznice, chr_uzemi and lesy  
  
  - updated vignette to reflect changes in tmap package (v.1.x -> v.2.0)

## version 1.2.6  

  - fixing of bugs introduced by 1.2.5 on some windows machines

## version 1.2.5  

  - added support for local cache to speed up calculation and save bandwidth

## version 1.2.4  

  - added function union_sf to aggregate sf data frames  

  - corrected typos in documentation (NUTS2 vs. NUTS3 in obce)  

  - unit tests optimized

## version 1.2.3  

  - low resolution shapefiles added for republika, kraje and okresy  

  - internet connection not required for using lo-res shapefiles  

  - dependency on tidyverse replaced by dplyr  

## version 1.1.1  

  - [!] this is the the first CRAN version  

  - [!] to make the package pass CRAN size requirements data files were changed from internal to external (internet connection required to load)  

  - a development version is available on https://github.com/jlacko/RCzechia  

  - if you have any questions or suggestions, please contact me (jindra dot lacko at gmail dot com)
