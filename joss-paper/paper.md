---
title: 'RCzechia: Spatial Objects of the Czech Republic'
tags:
  - R
  - spatial
  - vector data
  - country specific Czechia
authors:
  - name: Jindra Lacko^[Corresponding author] 
    orcid: 0000-0002-0375-5156
    affiliation: 1
affiliations:
 - name: Prague University of Economics and Business
   index: 1
date: 1 November 2022
bibliography: paper.bib

---

# Summary
`RCzechia` is a R package providing spatial objects relevant in the context of the Czech Republic for spatial data analysis and visualization purposes. The package uses `sf` @pebesma18 data format to serve the most commonly used administrative areas and natural objects. As the underlying data is by necessity larger than CRAN package size limits allow the data is stored externally and a working internet connection is required to use the package.

# State of the field
The history of spatial data analysis in `R` is long and respectable @bivand_gebhardt00. The first packages focusing specifically on providing spatial data date from the `S` days, with `maps` @deckmyn22 being one of the oldest packages in continuous use on CRAN (the oldest archive version dates from October 2003). The early packages used pattern of storing spatial data internally, which due to CRAN limits of package size placed a hard limit on volume and level of detail of data stored. 

With the advent of `sp` @pebesma_bivand05 and later `sf` @pebesma18 platforms for handling spatial information the universe of data packages focused on providing spatial data blossomed. There are packages with global focus, such as `rnaturalearth` @south17 and regional focus like `giscoR` @hernangomezdiego22 oriented at the EU. Number of packages are country specific, such as `tigirs` @walker_rudis22 for the US, or `rgugik` @dyba_nowosad21 for Poland. With current near universal and reliable internet access a new pattern has emerged, with spatial data packages accessing cloud stored spatial data files as required, and distributing only lightweight code.

In the context of statistical programming language R there exists `CzechData` package @caha22, with somewhat overlapping functionality but available only on GitHub. The CRAN package `czso` @bouchal22a interfaces API of the Czech Statistical Office [ČSÚ](https://www.czso.cz/csu/czso/home), providing access to statistical data about Czech administrative areas (without the spatial information itself). Package `pragr` @bouchal22b provides raster geodata about the city of Prague.

# Statement of need
No country specific spatial data package has been published on CRAN for the Czech Republic to date, creating a need that could be filled using global or regional packages only to a limited extent.

While there there are open data resources available for researchers, mostly in the format of ESRI Shapefiles, these have a number of practical disadvantages. They have to be located and downloaded individually, and their users in R context face additional hurdles, such as conflicting Coordinate Reference Systems and character encodings. In addition the datasets are not guaranteed to be topologically valid and are too detailed for many use cases.

# Features
The package provides two distinct sets of spatial objects: administrative areas, and natural objects:

## Administrative area polygons:

* **republika**: borders of the Czech Republic as a polygon
* **kraje**: 14 regions of the Czech Republic & Prague
* **okresy**: 76 districts (LAU1 areas) of the Czech Republic + Prague (legally not *a district* but *the capital*)
* **orp_polygony** 205 municipalities with extended powers (obce s rozšířenou působností) + Prague (legally not *a city* but *the capital*)
* **obce_polygony**: 6.258 municipalities of the Czech Republic
* **obce_body** the same as obce_polygony, but centroids instead of polygons
* **casti**: primarily 57 city parts of Prague, but also of other cities with defined parts (Brno, Ostrava and other)
* **senat_obvody**: 81 senate districts (volební obvody senátu)
* **volebni_okrsky**: 14.761 general election districts (volební okrsky)
* **zip_codes**: 2.671 ZIP code areas (poštovní směrovací čísla / PSČ)

## Natural objects:

* **reky**: streams and rivers
* **plochy**: stillwaters (lakes and ponds).
* **silnice**: roads (highways, speedways etc.)
* **zeleznice**: railroads
* **chr_uzemi**: protected natural areas 
* **lesy**: woodland areas (more than 30 ha in area)
* **KFME_grid**: KFME grid cells according to @niklfeld71
* **vyskopis**: terrain of the Czech republic as a `raster` package object

All objects are implemented as functions returning `sf` class data frames, so must be followed by brackets (i.e. `RCzechia::republika()`).

## Utility functions:

* **geocode**: geocodes an address to coordinates
* **revgeo**: reverse geocodes coordinates to an address

The utility functions interface API of the Czech State Administration of Land Surveying and Cadastre [ČÚZK](https://cuzk.cz/en) and are therefore limited in scope to the area of the Czech Republic.


<center>

![14 Regions of the Czech Republic](kraje.png)

</center>


<center>

![Relief of the Czech Republic, with major rivers](relief.png)

</center>

Examples of `RCzechia` use in current research practice include @korecky_etal21 and @brejcha_etal21.

# Acknowledgements

Pár teplých slov k doc. ing. TF PhD.

# References
