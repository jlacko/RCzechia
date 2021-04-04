# interací místo externího mapshaperu
okresy_low_res <- okresy() %>% # původní, kvůli diakritice
  rmapshaper::ms_simplify(keep = 0.03, keep_shapes = TRUE) %>%
  st_transform(5514)


# mungle data - kraje
for (kod in unique(okresy_low_res$KOD_CZNUTS3)) {
  wrkKraj <- okresy_low_res[okresy_low_res$KOD_CZNUTS3 == kod, ] %>%
    st_union() %>%
    st_sf() %>%
    nngeo::st_remove_holes() %>%
    rename(geometry = geom) %>%
    mutate(
      KOD_KRAJ = unique(okresy_low_res$KOD_KRAJ[okresy_low_res$KOD_CZNUTS3 == kod]),
      KOD_CZNUTS3 = unique(okresy_low_res$KOD_CZNUTS3[okresy_low_res$KOD_CZNUTS3 == kod]),
      NAZ_CZNUTS3 = unique(okresy_low_res$NAZ_CZNUTS3[okresy_low_res$KOD_CZNUTS3 == kod])
    )


  if (wrkKraj$KOD_CZNUTS3 == okresy_low_res$KOD_CZNUTS3[1]) {
    kraje_low_res <- wrkKraj
  } else {
    kraje_low_res <- rbind(
      kraje_low_res,
      wrkKraj
    )
  }
}

st_geometry(kraje_low_res) <- "geometry"

# ze STČ vyříznout Prahu
kraje_low_res[kraje_low_res$KOD_KRAJ=="3026",] <- st_difference(kraje_low_res[kraje_low_res$KOD_KRAJ=="3026",], st_geometry(kraje_low_res[kraje_low_res$KOD_KRAJ=="3018",]))

# z Brna venkova vyříznout Brno město
okresy_low_res[okresy_low_res$KOD_LAU1=="CZ0643",] <- st_difference(okresy_low_res[okresy_low_res$KOD_LAU1=="CZ0643",], st_geometry(okresy_low_res[okresy_low_res$KOD_LAU1=="CZ0642",]))

svitavy <- okresy_low_res %>%
  subset(NAZ_LAU1 == "Svitavy") %>%
  st_geometry() %>%
  st_cast("POLYGON")

# větší ze svitavských polygonů
svitavy <- svitavy[[which.max(st_area(svitavy))]]

# dát geometrii low res okresů stranou
geometrie <- st_geometry(okresy_low_res)

# geometrii Svitav nahradit větším z obou polygonů
geometrie[which(okresy_low_res$NAZ_LAU1 == "Svitavy")] <- st_sfc(svitavy, crs = 5514)

# vrátit zpátky
st_geometry(okresy_low_res) <- geometrie

# mungle data - republika

republika_low_res <- okresy_low_res %>% # select the non-central parts
  summarize(NAZ_STAT = republika()$NAZ_STAT) %>% # return back the data value
  nngeo::st_remove_holes() %>%
  rename(geometry = geom)

st_geometry(republika_low_res) <- "geometry"

# úklid
okresy_low_res <- st_transform(okresy_low_res, 4326) # WGS84
kraje_low_res <- st_transform(kraje_low_res, 4326) # WGS84
republika_low_res <- st_transform(republika_low_res, 4326) # WGS84

colnames(okresy_low_res) <- colnames(okresy())
colnames(kraje_low_res) <- colnames(kraje())
colnames(republika_low_res) <- colnames(republika())

# ověřit...
plot(republika_low_res)
plot(kraje_low_res, max.plot = 1)
plot(subset(okresy_low_res, KOD_LAU1 == "CZ0643"), max.plot = 1)
