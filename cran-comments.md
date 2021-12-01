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
This is a re-submission after the package being archived due to failure of vignette build on macOS 12 (Monterey, released on 2021-10-25).

The issue was likely triggered by dependency {czso}, which used to be used in the vignette. The dependency was removed, and {czso} package maintainer notified by raising an issue on GitHub.

The problematic {czso} code was removed from the package vignette, and the updated vignette has been confirmed to run on Monterey.

Out of abundance of caution, and in order to honour my email promise to prof. Brian D. Ripley that the vignette will not crash ever again, the formerly dynamic vignette has been replaced by a static, pre-computed one (known to be valid). Note that this is being done only after reproducing, and fixing, the Monterey issue.
