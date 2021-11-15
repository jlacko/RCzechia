# božstva CRAN-u žádají oběti...

library(knitr)
fs::file_delete("./vignettes/vignette.Rmd")
fs::dir_delete("./vignettes/figure")
knit("./vignettes/vignette.Rmd.orig",
     output = "./vignettes/vignette.Rmd")
fs::file_move("./figure", "./vignettes")

