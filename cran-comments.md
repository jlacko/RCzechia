## Test environments
* Ubuntu 20.04 LTS, R version 4.0.2 (2020-06-22)
* Ubuntu 16.04.6 LTS R version 4.0.0 (2020-04-24) (Travis)
* Windows R version 4.0.2 (2020-06-22) (R hub)
* macOS R version 4.0.0 (2020-04-24) (R hub)
* Windows R version 4.0.2 (2020-06-22) (win builder)
* Windows R Under development (unstable) (2020-08-23 r79071) (win builder) 
* Windows R version 3.6.3 (2020-02-29) (win builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
There is an error in R oldrel (3.6.3 ) that I am unable to reproduce; 
it most likely relates to server connectivity - a gateway timeout (HTTP 504 error).

All other environments - and oldrelease on win builder - test OK.

URL of vanity badges in README changed: http >> https

