## Test environments
* Ubuntu 20.04.2 LTS, R version 4.1.2 GEOS 3.9.1, GDAL 3.2.2, PROJ 8.0.0 (current)
* Ubuntu 20.04.2 LTS, R version 3.6.3 GEOS 3.6.2, GDAL 2.2.3, PROJ 4.9.3 (lowest supported)

* Ubuntu 20.04.2 LTS, 4.1.2 (2021-11-01) (GitHub Actions)
* Ubuntu 20.04.2 LTS, R Under development (unstable) (2021-11-14 r81188) (GitHub Actions)
* Windows Server 2019 10.0.17763, 4.1.2 (2021-11-01) (GitHub Actions)
* Mac OS X 10.15.7, R version 4.1.0 (2021-05-18) (GitHub Actions)
* macOS 11.5.2 (20G95) R version 4.1.1 Patched (2021-09-01 r80848) (macOS builder)

* Windows R version 4.1.2 (2021-11-01) (win builder)
* Windows R Under development (unstable) (2021-11-22 r81222) (win builder) 
* Windows R version 4.0.5 (2021-03-31) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  ´

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
The source code had been amended, to use more conservative utils::download.file instad of curl::curl_download.

As requested in comments to v1.8.6 submission the vignette (formerly static) has been replaced by a dynamic one, again tested on mac builder https://mac.r-project.org/macbuilder/results/1637871311-0df675c79c52f327/

Note that the vignette uses internet resources, 24/7 availability of which can not be 100% guaranteed by the package maintainer. Compliance at all times with the CRAN policy (graceful fail on internet resources not available) has been requested by prof. Brian D. Ripley, in a very specific wording. 

A static vignette seems the only reliable way to achieve this / as having try & catch blocks *in vignette code* is not a feasible way to introduce the package functionality to its target user base of entry level R spatial users. This is something else than having try & catch in actual package code, where it will not confuse users just starting out on the learning curve.

It is therefore expected that a static vignette will be introduced in a future version, once the reliability of the code used is re-established.
