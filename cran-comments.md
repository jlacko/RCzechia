## Test environments
* Ubuntu 20.04.2 LTS, R version 4.1.1 GEOS 3.9.1, GDAL 3.2.2, PROJ 8.0.0 (current)
* Ubuntu 20.04.2 LTS, R version 3.6.3 GEOS 3.6.2, GDAL 2.2.3, PROJ 4.9.3 (lowest supported)

* Ubuntu 20.04.2 LTS, R version 4.1.0 (2021-05-18) (GitHub Actions)
* Ubuntu 20.04.2 LTS, R Under development (unstable) (2021-08-09 r80724) (GitHub Actions)
* Windows Server 2019 10.0.17763, 4.1.0 (2021-05-18) (2021-05-18) (GitHub Actions)
* Mac OS X 10.15.7, R version 4.1.0 (2021-05-18) (GitHub Actions)

* Windows R version 4.1.1 (2021-08-10) (win builder)
* Windows R Under development (unstable) (2021-08-30 r80832) (win builder) 
* Windows R version 4.0.5 (2021-03-31) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
There is a WARN on r-devel-windows; this warning is due to timeout of https://web.archive.org/ during vignette processing - the vignette uses a snapshot of recent official Czech Election results stored in the Wayback Machine as an example of a real world use of the Czech Senate electoral districts shapefile. As it is unlikely for the Wayback Machine to be actually down I suspect the timeout to be caused by overload of network infrastructure due to heavy load.

The WARN is in my opinion therefore only of a technical nature, and should have no relation to the actual working of the package.
