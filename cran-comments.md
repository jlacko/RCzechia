## Test environments
* ubuntu 18.04.3 LTS, R 3.6.2 (2019-12-12) (desktop)
* ubuntu 16.04.6 LTS, R 3.6.2 (2017-01-27) (Travis)  
* macOS 10.11 El Capitan, R-release (experimental) (rhub)
* Windows Server 2008 R2 SP1, R-release, 32/64 bit (rhub)
* Windows R version 3.6.2 (2019-12-12) (win_builder)
* Windows R Under development (unstable) (2020-01-07 r77633)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
There is an error in r-devel-linux-x86_64-debian-clang that I am unable to reproduce; it is most likely related to character encoding issues on server side (the string in question is UTF-8 and works everywhere else).
