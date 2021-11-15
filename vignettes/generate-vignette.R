# božstva CRAN-u žádají oběti...

library(knitr)
knit("./vignettes/vignette.Rmd.orig",
     output = "./vignettes/vignette.Rmd")
system("mv ./*.png ./vignettes/")
