## Test environments
* Ubuntu 20.04.2 LTS, R version 4.1.2 GEOS 3.9.1, GDAL 3.2.2, PROJ 8.0.0 (current)
* Ubuntu 20.04.2 LTS, R version 3.6.3 GEOS 3.6.2, GDAL 2.2.3, PROJ 4.9.3 (lowest supported)

* Ubuntu 20.04.2 LTS, 4.1.2 (2021-11-01) (GitHub Actions)
* Ubuntu 20.04.2 LTS, R Under development (unstable) (2021-11-14 r81188) (GitHub Actions)
* Windows Server 2019 10.0.17763, 4.1.2 (2021-11-01) (GitHub Actions)
* Mac OS X 10.15.7, R version 4.1.0 (2021-05-18) (GitHub Actions)
* macOS 11.5.2 (20G95) R version 4.1.1 Patched (2021-09-01 r80848) (macOS builder)

* Windows R version 4.1.2 (2021-11-01) (win builder)
* Windows R Under development (unstable) (2021-11-19 r81213) (win builder) 
* Windows R version 4.0.5 (2021-03-31) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
This release resolves issues identified in v1.8.5 submission - chiefly detritus (vignette.Rmd.orig + helper R script) in the vignettes directory. The /vignettes directory now contains only the vignette.Rmd + supporting images.

In addition the package has been tested on the macOS builder - https://mac.r-project.org/macbuilder/results/1637432104-f742fcddbf21dd31/ - with no notes, errors nor warnings.
