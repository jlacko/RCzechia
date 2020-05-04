## Test environments
* ubuntu 20.04 LTS, R 4.0.0 (2020-04-24)
* Windows R 4.0.0 (2020-04-24)
* Windows R Under development (unstable) (2020-05-01 r78341) (win builder) 

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs.  

## Downstream dependencies
There are no downstream dependencies.

## CRAN checks
There is an error in r-devel-linux-x86_64-debian-clang that I am unable to reproduce; it is most likely related to character encoding issues on server side.

It was a part of an example (geocoding a Czech address with Czech accented characters) and I have replaced the example by another, with ASCI compliant address.

Character encoding remains a minefield and the function will work the best when provided by address in UTF-8 encoding. This is explicitly noted in documentation.

The check should be resolved (or rather sidestepped) by version 1.5.0
