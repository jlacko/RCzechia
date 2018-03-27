library(devtools)
library(sf)
library(tidyverse)

# read data
okresy_low_res <- readRDS("~/GeoCzech/OkresyLR.rds")


# use data
use_data(okresy_low_res)
