## Test environments
* Ubuntu 20.04.2 LTS, R version 4.1.2 GEOS 3.9.1, GDAL 3.2.2, PROJ 8.0.0 (current)
* Ubuntu 20.04.2 LTS, R version 3.6.3 GEOS 3.6.2, GDAL 2.2.3, PROJ 4.9.3 (lowest supported)

* Ubuntu 20.04.2 LTS, 4.1.2 (2021-11-01) (GitHub Actions)
* Ubuntu 20.04.2 LTS, R Under development (unstable) (2021-11-16 r81199) (GitHub Actions)
* Windows Server 2019 10.0.17763, 4.1.2 (2021-11-01) (GitHub Actions)
* Mac OS X 10.15.7, R version 4.1.2 (2021-11-01) (GitHub Actions)

* Windows R version 4.1.2 (2021-11-01) (win builder)
* Windows R Under development (unstable) (2021-11-26 r81252) (win builder) 
* Windows R version 4.0.5 (2021-03-31) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.

## Downstream dependencies
There are no downstream dependencies.

## CRAN comments
This version addresses comments raised to v1.9.0, namely:
- \value is specified in man files (the returned value was formerly reported under \format field, which by hindsight does not seem appropriate; thanks for the comment!)
- unexecutable code (a typo) was removed from example in man/republika.rd
- examples for the most typical & frequently used (and smaller) objects were removed from the \donttest{} flag; note that it was not practical to uncomment all examples, as some consume largish (tens of megabytes) amouts of bandwidth and access external APIs. CI testing of these is done privately (using GitHub actions with run don't test settings).
