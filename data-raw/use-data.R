library(devtools)
library(sf)
library(tidyverse)

# read data
okresy_low_res <- readRDS("data-raw/OkresyLR.rds")

# mungle data - kraje

# mungle data - republika


# use data
use_data(okresy_low_res, internal = T, overwrite = T)
