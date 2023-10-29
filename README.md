# RCzechia    
<!-- badges: start -->
[![R-CMD-check](https://github.com/jlacko/RCzechia/workflows/R-CMD-check/badge.svg)](https://github.com/jlacko/RCzechia/actions/workflows/R-CMD-check.yaml)
[![CRAN](http://www.r-pkg.org/badges/version/RCzechia)](https://cran.r-project.org/package=RCzechia)
[![CRAN-checks](https://badges.cranchecks.info/worst/RCzechia.svg)](https://cran.r-project.org/web/checks/check_results_RCzechia.html)
[![Codecov test coverage](https://codecov.io/gh/jlacko/RCzechia/branch/master/graph/badge.svg)](https://app.codecov.io/gh/jlacko/RCzechia?branch=master)
[![Downloads-weekly](http://cranlogs.r-pkg.org/badges/last-week/RCzechia?color=brightgreen)](https://cran.r-project.org/package=RCzechia)
[![Downloads-total](http://cranlogs.r-pkg.org/badges/grand-total/RCzechia?color=brightgreen)](https://cran.r-project.org/package=RCzechia)
[![DOI](https://zenodo.org/badge/97862932.svg)](https://zenodo.org/badge/latestdoi/97862932)
[![DOI](https://joss.theoj.org/papers/10.21105/joss.05082/status.svg)](https://doi.org/10.21105/joss.05082)
<!-- badges: end -->

This project downloads a set of shapefiles relevant to the Czech Republic. It was inspired by the popular [`tigris`](https://github.com/walkerke/tigris) package for US datasets.  

<p align="center">
  <img src="https://github.com/jlacko/RCzechia/blob/master/data-raw/kraje-lo-res.png?raw=true" alt="Kraje České republiky"/>
</p>

For examples of RCzechia in action please see the package vignette:

* [Visualizing Czech Population](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#visualizing-czech-population)
* [Geocoding Locations & Drawing them on a Map](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#geocoding-locations-drawing-them-on-a-map)
* [Distance Between Prague and Brno](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#distance-between-prague-and-brno)
* [Geographical Center of the City of Brno](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#geographical-center-of-the-city-of-brno)
* [Interactive Map](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#interactive-map)
* [KFME Grid Cells - faunistické čtverce](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#kfme-grid-cells)
* [Terrain of the Czech Republic](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#terrain-of-the-czech-republic)
* [Senate elections of 2020](https://CRAN.R-project.org/package=RCzechia/vignettes/vignette.html#senate-elections-of-2020)

The administrative area polygons are based on the [RÚIAN register](https://cs.wikipedia.org/wiki/Registr_%C3%BAzemn%C3%AD_identifikace,_adres_a_nemovitost%C3%AD); the natural objects were based originally on [ArcČR 500](https://www.arcdata.cz/cs-cz/produkty/data/arccr#text-3f16b51360) by ARCDATA and later moved to [Data200](https://geoportal.cuzk.cz/Default.aspx?mode=TextMeta&side=mapy_data200&text=dSady_mapyData200) by ČÚZK.

The shapefiles are by necessity larger than the limits of a CRAN package size allow. The data are therefore stored remotely (on Amazon Cloud / AWS S3) and downloaded as required. As consequence a working internet connection is required to fully use the package.

For the most commonly used shapes (*republika*, *kraje* and *okresy*) an optional low resolution version is also included. To access it specify the value of `resolution` parameter as `"low"` (default is `"high"`).

Access to the external files is logged, from time to time I check the logs (mainly to better understand my bandwidth charges).

### A note to Czech users
Tohle je "oficiální", a tedy anglické, readme. Českou verzi naleznete na http://www.jla-data.net/cze/package-rczechia/

### Installation
The package is on CRAN (as of March 2018) so to get a stable version simply run:
```r 
install.packages("RCzechia")
```
You can also get the latest development version by running `remotes::install_github("jlacko/RCzechia")`. The main branch should be always reasonably stable, but I do not suggest cloning of development branches unless you know what you are doing - these are where the raw action is happening, red in tooth and claw.

### The following spatial objects are included:  

administrative:

* **republika**: borders of the Czech Republic as a polygon
* **kraje**: 14 regions of the Czech Republic & Prague  
* **okresy**: 76 districts (LAU1 areas) of the Czech Republic + Prague (legally not *a district* but *the capital*)  
* **orp_polygony** 205 municipalities with extended powers (in Czech: obce s rozšířenou působností) + Prague (legally not *a city* but *the capital*)  
* **obce_polygony**: 6.258 municipalities of the Czech Republic  
* **obce_body** the same as obce_polygony, but centroids instead of polygons  
* **casti**: primarily 57 city parts of Prague, but also of other cities with defined parts (Brno, Ostrava and other)  
* **senat_obvody**: 81 senate districts (volební obvody senátu)
* **volebni_okrsky**: 14.733 general election districts (volební okrsky)
* **zip_codes**: 2.671 ZIP code areas (poštovní směrovací čísla / PSČ)
* **historie**: historical administrative areas + census data, notably including data on Czechoslovak residents of German nationality pre-WW2

natural:

* **reky**: streams and rivers
* **plochy**: stillwaters (lakes and ponds).
* **silnice**: roads (highways, speedways etc.)
* **zeleznice**: railroads
* **chr_uzemi**: protected natural areas (chráněná území)
* **lesy**: woodland areas (more than 30 ha in area)
* **KFME_grid**: KFME grid cells (faunistické čtverce)
* **vyskopis**: terrain of the Czech republic as a {terra} package raster object
* **geomorfo**: geomorphological division of the Czech Republic


All objects are implemented as functions returning data frames, so must be followed by brackets (i.e. `hranice <- republika()`).

### In addition a number of utility functions is provided:  
* **geocode**: interfaces to geocoding API of [ČÚZK](https://cuzk.cz/en).
* **revgeo**: interfaces to reverse geocoding API of [ČÚZK](https://cuzk.cz/en).

## Call for Action

The project is actively maintained, and ideas & suggestions to improve the package are greatly welcome. Should you feel more at ease with old fashioned email than the GitHub ticketing system - do drop me a line.

But raising an issue is preferable, as I am human and I forget; GitHub does not suffer from such a failing, and will keep on reminding me till the sun and moon are darkened, and the stars no longer shine.

More detailed information can be found in the [CONTRIBUTING](https://github.com/jlacko/RCzechia/blob/master/CONTRIBUTING.md) document.

## Code of Conduct
  
Please note that the RCzechia project is released with a [Contributor Code of Conduct](https://github.com/jlacko/RCzechia/blob/master/CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.
