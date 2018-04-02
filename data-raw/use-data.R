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

# use data
use_data(okresy_low_res,
         kraje_low_res,
         republika_low_res,
         internal = T,
         overwrite = T)

# ověřit...
plot(republika_low_res)
plot(kraje_low_res, max.plot = 1)
