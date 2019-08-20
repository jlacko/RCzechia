## version 1.4.2
  - KFME grid cells (faunistické čtverce) object added
  
  - minor optimization of geocode() and tests 

## version 1.4.1

  - downgraded error on unavailable internet to message in line with updates to CRAN policy
  
  - internal optimalization
 
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

  - dependency on tidverse replaced by dplyr  

## version 1.1.1  

  - [!] this is the the first CRAN version  

  - [!] to make the package pass CRAN size requirements data files were changed from internal to external (internet connection required to load)  

  - a development version is available on https://github.com/jlacko/RCzechia  

  - if you have any questions or suggestions, please contact me (jindra dot lacko at gmail dot com)
