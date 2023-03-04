## Test environments
* Ubuntu 22.04.1 LTS, R version 4.2.2 Patched GEOS 3.10.2, GDAL 3.4.3, PROJ 9.0.0 (current)
* Ubuntu 18.04.6 LTS, R version 3.6.3 GEOS 3.6.2, GDAL 2.2.3, PROJ 4.9.3 (lowest supported)

* Ubuntu 20.04.5 LTS, R version 4.2.2 (2022-10-31) (GitHub Actions)
* Ubuntu 20.04.5 LTS, R Under development (unstable) (2023-03-01 r83924) (GitHub Actions)
* Windows Server 2022 10.0.20348, R version 4.2.2 (2022-10-31 ucrt) (GitHub Actions)
* Mac OS X 12.6.3, R version 4.2.2 (2022-10-31) (GitHub Actions)

* Windows R version 4.2.2 (2022-10-31 ucrt) (win builder)
* Windows R Under development (unstable) (2023-03-02 r83926 ucrt) (win builder) 
* Windows R version 4.1.3 (2022-03-10) (win builder)

## R CMD check results
Status: OK

This release sidesteps the LaTeX errors ("checking PDF version of manual ... WARNING / LaTeX errors when creating PDF version.") that have developed on some - although not all - flavors of CRAN checks, e.g. r-release-macos and r-oldrel-macos.

## Downstream dependencies
There are no downstream dependencies.

