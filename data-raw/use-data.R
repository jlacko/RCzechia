library(tidyverse)
library(devtools)
library(sf)
library(tidyverse)
library(RCzechia)
library(geojsonio)

# read data
srcOkresy <- st_read("data-raw/okresy.json") %>% # přes topsimplify -P 0.0125
  select(KOD_OKRES)

st_crs(srcOkresy) <- 4326 # používá default = WGS84
srcOkresy <- st_transform(srcOkresy, 5514)  # Křovák kvůli metrům

okresy_low_res <- okresy() %>% # původní, kvůli diakritice
  st_transform(5514)

st_geometry(okresy_low_res) <- NULL # Out with the old...

okresy_low_res <- okresy_low_res %>% # ... in with the new!
  inner_join(srcOkresy, by = "KOD_OKRES") %>%
  st_sf()


# mungle data - kraje


for (kod in unique(okresy_low_res$KOD_CZNUTS3)) {
  wrkKraj <- okresy_low_res[okresy_low_res$KOD_CZNUTS3 == kod, ] %>%
    lwgeom::st_make_valid() %>%
    st_buffer(50) %>% # avoid slivers!
    st_union() %>%
    st_sf() %>%
    mutate(KOD_KRAJ = unique(okresy_low_res$KOD_KRAJ[okresy_low_res$KOD_CZNUTS3 == kod]),
           KOD_CZNUTS3 = unique(okresy_low_res$KOD_CZNUTS3[okresy_low_res$KOD_CZNUTS3 == kod]),
           NAZ_CZNUTS3 = unique(okresy_low_res$NAZ_CZNUTS3[okresy_low_res$KOD_CZNUTS3 == kod]))

  if (wrkKraj$KOD_CZNUTS3 == okresy_low_res$KOD_CZNUTS3[1]) {
    kraje_low_res <- wrkKraj
  } else {
    kraje_low_res <- rbind(kraje_low_res,
                           wrkKraj)
  }
}

# mungle data - republika

republika_low_res <- okresy_low_res %>% # select the non-central parts
  lwgeom::st_make_valid() %>%
  st_buffer(50) %>% # avoid slivers!
  st_union() %>% # unite to a geometry object
  st_sf() %>% # make the geometry a data frame object
  mutate(NAZ_STAT = 'Česká republika') # return back the data value

# úklid
okresy_low_res <- st_transform(okresy_low_res, 4326)  # WGS84
kraje_low_res <- st_transform(kraje_low_res, 4326)  # WGS84
republika_low_res <- st_transform(republika_low_res, 4326)  # WGS84


# faunistické čtverce
faunisticke_ctverce  <- st_make_grid(republika_low_res,
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
                     4938:4979)) %>%
  st_set_agr("constant")

# faunistické čtverečky = podčtverce
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
  select(ctverec = ctverecek) %>%
  st_set_agr("constant")


# use data
use_data(okresy_low_res,
         kraje_low_res,
         republika_low_res,
         faunisticke_ctverce,
         faunisticke_ctverecky,
         internal = T,
         overwrite = T)

# ověřit...
plot(republika_low_res)
plot(kraje_low_res, max.plot = 1)
