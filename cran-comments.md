## Resubmission
This is a resubmission; compared to previous version I have

* fixed the encoding issues that led to failure of build of pdf manuals
* slightly amended vignette to speed up generation
* the note about large size of data remains; there is no workaround for that


## First submission
This is a first submission both for me as person and for the package. I appreciate the attention of reviewers and thank in advance for their patience.

It is a data package - it contains data files in sf data frame format only; no code intended for execution is included (the only "code" are dummy R files for documentation of datasets via Roxygen). 

It is likely to be of interest mainly to Czech R users, but in local context has - hopefuly - value. It has lived for a while on GitHub and received positive feedback.

Written consent of the copyright holder for the source data was requested and given; it is available (in Czech language only) on https://raw.githubusercontent.com/jlacko/RCzechia/master/data-raw/confirmation.pdf

## Test environments
* ubuntu 16.04 (RStudio Server on AWS), R 3.4.3
* ubuntu 14.04 (Travis), R 3.4.2
* windows 10 (desktop), R 3.4.3

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking installed package size ... NOTE
    installed size is 57.3Mb
    sub-directories of 1Mb or more:
      data  57.2Mb
    
This is a data package; size can not really be helped given the level of spatial detail included. The 50+ MB size is explained in readme and should be acceptable to the target user group.

