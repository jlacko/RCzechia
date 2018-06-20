## Test environments
* ubuntu 16.04 (RStudio Server on AWS), R 3.4.4
* ubuntu 14.04 (Travis), R 3.5.0
* windows 10 (desktop), R 3.5.0
* win-builder R devel (unstable)

## R CMD check results
Status: OK
There were no NOTES, ERRORs or WARNINGs. 

## Downstream dependencies
There are no downstream dependencies.

Note to CRAN Maintainers: this is an emergency fix of compatibility issues introduced in 1.2.5 release on some - though not all, unfortunately - Windows machines (caused by method argument in the download.file() function). The problem did not show in my previous testing, nor in win_builder.
