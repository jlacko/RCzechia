# 1. z původních jemných vytvoří zjednodušené okresy, kraje a stát
# 2. z obvodu státu vytvoří čtverce a čtverečky
# 3. pražská Vltava & řeky města Brna
# interní data uloží pro budoucí zpracování


library(devtools)
library(sf)
library(dplyr)
library(usethis)
library(ggplot2)
library(RCzechia)


# low res polygony
source("./data-raw/lo-res-polygons.R")

# faunistické čtverce a čtverečky
source("./data-raw/ctverce-a-ctverecky.R")

# městské řeky
source("./data-raw/reky_mesta.R")

# use data - internal (= private)
use_data(okresy_low_res,
  kraje_low_res,
  republika_low_res,
  faunisticke_ctverce,
  faunisticke_ctverecky,
  reky_brno,
  reky_praha,
  internal = T,
  overwrite = T
)


