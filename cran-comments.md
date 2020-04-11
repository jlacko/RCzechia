## Test environments
* ubuntu 18.04.3 LTS, R 3.6.3 (2020-02-29) (desktop)
* ubuntu 16.04.6 LTSS, R 3.6.2 (2017-01-27) (Travis)  
* Windows R 3.6.3 (2020-02-29) (win_builder)
* Windows R 4.0.0 alpha (2020-03-26 r78078) (win_builder)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
There is an error in r-devel-linux-x86_64-debian-clang that I am unable to reproduce; it is most likely related to character encoding issues on server side (the string in question is UTF-8 and works everywhere else).
