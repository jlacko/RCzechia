## Test environments
* Ubuntu 22.04.1 LTS, R version 4.2.2 Patched GEOS 3.10.2, GDAL 3.4.3, PROJ 9.0.0 (current)
* Ubuntu 18.04.6 LTS, R version 3.6.3 GEOS 3.6.2, GDAL 2.2.3, PROJ 4.9.3 (lowest supported)

* Ubuntu 20.04.5 LTS, R version 4.2.2 (2022-10-31) (GitHub Actions)
* Ubuntu 20.04.5 LTS, R Under development (unstable) (2023-01-16 r83624) (GitHub Actions)
* Windows Server 2022 10.0.20348, R version 4.2.2 (2022-10-31 ucrt) (GitHub Actions)
* Mac OS X 11.7, R version 4.2.2 (2022-10-31) (GitHub Actions)

* Windows R version 4.2.2 (2022-10-31 ucrt) (win builder)
* Windows R Under development (unstable) (2023-01-16 r83624 ucrt) (win builder) 
* Windows R version 4.1.3 (2022-03-10) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.

## Downstream dependencies
There are no downstream dependencies.

## Comments
There was a note on Win Builder machine about SSL error on www.volby.cz, which is referenced in the package vignette - this I believe to be technical in nature, as the site 1) is up & running and 2) supports SSL (and the link is https).

There may be more than usual traffic on the site (there is an election going on) but the site itself is legit.

Also there has been no change in the vignette since last version (this release is a minor one) and the package is passing all the CRAN checks with OK status.

