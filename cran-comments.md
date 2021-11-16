## Test environments
* Ubuntu 20.04.2 LTS, R version 4.1.2 GEOS 3.9.1, GDAL 3.2.2, PROJ 8.0.0 (current)
* Ubuntu 20.04.2 LTS, R version 3.6.3 GEOS 3.6.2, GDAL 2.2.3, PROJ 4.9.3 (lowest supported)

* Ubuntu 20.04.2 LTS, 4.1.2 (2021-11-01) (GitHub Actions)
* Ubuntu 20.04.2 LTS, R Under development (unstable) (2021-11-14 r81188) (GitHub Actions)
* Windows Server 2019 10.0.17763, 4.1.2 (2021-11-01) (GitHub Actions)
* Mac OS X 10.15.7, R version 4.1.0 (2021-05-18) (GitHub Actions)

* Windows R version 4.1.1 (2021-08-10) (win builder)
* Windows R Under development (unstable) (2021-11-12 r81187)(win builder) 
* Windows R version 4.0.5 (2021-03-31) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
This release replaces a dynamic (calculated on the fly) vignette by a static one (pre-computed, known to be valid). It therefore eliminates the risk of re-occurence of the "--- failed re-building ‘vignette.Rmd’" error in CRAN logs. This has been a problem several times in the past, most recently on the Apple Silicon build.
