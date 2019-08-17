library(sf)
library(RCzechia)
library(tidyverse)
library(devtools)

obrys <- republika("low")

ctverce  <- st_make_grid(obrys,
                         cellsize = c(1/6, 1/10), # velikost čtverce
                         offset = c(12, 48.5)) %>% # počátek (= vlevo dole :)
  st_sf() %>%
  mutate(ctverec = c(7438:7479,
                     7338:7379,
                     7238:7279,
                     7138:7179,
                     7038:7079,
                     6938:6979,
                     6838:6879,
                     6738:6779,
                     6638:6679,
                     6538:6579,
                     6438:6479,
                     6338:6379,
                     6238:6279,
                     6138:6179,
                     6038:6079,
                     5938:5979,
                     5838:5879,
                     5738:5779,
                     5638:5679,
                     5538:5579,
                     5438:5479,
                     5338:5379,
                     5238:5279,
                     5138:5179,
                     5038:5079,
                     4938:4979))

# use data
use_data(ctverce,
         internal = T)
