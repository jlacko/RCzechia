## Test environments
* Ubuntu 24.04.4 LTS, R version 4.6.0 (2026-04-24) GEOS 3.12.0, GDAL 3.8.3, PROJ 9.3.1 (current)

* Ubuntu 22.04.5 LTS, R version 4.6.0 (2026-04-24) (GitHub Actions)
* Ubuntu 22.04.5 LTS, R Under development (unstable) (2026-06-02 r90096) (GitHub Actions)
* Windows Server 2022 x64 (build 26100), R version 4.6.0 (2026-04-24 ucrt) (GitHub Actions)
* macOS Sequoia 15.7.7, R version 4.6.0 (2026-04-24) (GitHub Actions)

* Windows R version 4.6.0 (2026-04-24 ucrt) (win builder)
* Windows R version 4.5.3 (2026-03-11 ucrt) (win builder)
* Windows R Under development (unstable) (2026-06-02 r90096 ucrt) (win builder) 

## R CMD check results
Status: OK

## Downstream dependencies
There are no downstream dependencies.

## CRAN notes
This release resolves the donttest fail noted by prof. Brian D. Ripley on 2026-06-03; the problem was introduced by upstream changes in {sf} version 1.1-1, released earlier in May, which moved from the old style magrittr pipe (%>%) to the new style base pipe (|>).

The current version of {RCzechia} aligns with {sf} and as consequence moves up the required R version to 4.1.0 as well.
