library(sf)
library(tidyverse)


faunisticke_ctverce  <- st_make_grid(RCzechia::republika("low"),
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


faunisticke_ctverecky  <- st_make_grid(st_union(faunisticke_ctverce),
                                     cellsize = c(1/12, 1/20), # velikost čtverce
                                     offset = c(12, 48.5)) %>% # počátek (= vlevo dole :)
  st_sf() %>%
  mutate(id = row_number())

asdf <- faunisticke_ctverce %>%
  st_contains(faunisticke_ctverecky) %>%
  as.data.frame() %>%
  set_names(c("idx_ctverec", "idx_ctverecek"))

asdf$ctverec <- faunisticke_ctverce$ctverec[asdf$idx_ctverec]

asdf$ctverecek <- paste0(asdf$ctverec, c("c", "d", "a", "b"))

faunisticke_ctverecky <- faunisticke_ctverecky %>%
  inner_join(asdf, by = c("id" = "idx_ctverecek")) %>%
  select(ctverec = ctverecek)


obec <- "Hrčava" # a Czech location

# geolocate centroid of a place
place <- RCzechia::geocode(obec) %>%
  filter(typ == "Obec")

# ID of the KFME square containg place geocoded
ctverec_id <- sf::st_intersection(faunisticke_ctverecky, place)$ctverec
cat(paste0("Location found in grid cell number: ", ctverec_id, "."))

# telč = 6858b
