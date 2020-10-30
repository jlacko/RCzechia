## Test environments
* Ubuntu 20.04 LTS, R version 4.0.3 (2020-10-10)
* Ubuntu 18.04.5 LTS R version 4.0.2 (2020-06-22) (Travis)
* Windows Server 2008 R2 SP1, R-release, 32/64 bit (R hub)
* macOS 10.13.6 High Sierra, R-release, CRAN's setup (R hub)
* Windows R version 4.0.3 (2020-10-10) (win builder)
* Windows R Under development (unstable) (2020-10-28 r79382) (win builder) 
* Windows R version 3.6.3 (2020-02-29) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
There is an issue with Solaris build; most likely related to PROJ version.

This release should take care of that; it has been tested with PROJ 4.9.3
