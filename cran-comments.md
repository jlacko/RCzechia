## Test environments
* Ubuntu 20.04 LTS, R version 4.0.3 (2020-10-10)
* Ubuntu 20.04.1 LTS, R version 4.0.3 (2020-10-10) (GitHub Actions)
* Windows Server 2019 10.0.17763, R version 4.0.3 (2020-10-10)(GitHub Actions)
* Mac OS X 10.15.7, R version 4.0.3 (2020-10-10) (GitHub Actions)
* Windows R version 4.0.3 (2020-10-10) (win builder)
* Windows R Under development (unstable) (2021-01-02 r79767) (win builder) 
* Windows R version 3.6.3 (2020-02-29) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
This bugfix release is expected to resolve the issue with v1.6.2 on CRAN Solaris
and oldrel Mac OS builds. These seem to be caused by oldish PROJ version.

It has been tested with PROJ 4.9.3 (the patched-solaris and oldrel-macos
use PROJ 5.2.0).

