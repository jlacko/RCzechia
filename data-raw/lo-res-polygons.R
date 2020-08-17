# interací místo externího mapshaperu
okresy_low_res <- okresy() %>% # původní, kvůli diakritice
  rmapshaper::ms_simplify(keep = 0.03, keep_shapes = TRUE) %>%
  st_transform(5514)


# mungle data - kraje
for (kod in unique(okresy_low_res$KOD_CZNUTS3)) {
  wrkKraj <- okresy_low_res[okresy_low_res$KOD_CZNUTS3 == kod, ] %>%
    st_make_valid() %>%
    st_union() %>%
    st_sf() %>%
    nngeo::st_remove_holes() %>%
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

# ze STČ vyříznout Prahu
kraje_low_res[kraje_low_res$KOD_KRAJ=="3026",] <- st_sym_difference(kraje_low_res[kraje_low_res$KOD_KRAJ=="3026",], st_geometry(kraje_low_res[kraje_low_res$KOD_KRAJ=="3018",]))

# mungle data - republika

republika_low_res <- okresy_low_res %>% # select the non-central parts
  st_make_valid() %>%
  st_union() %>% # unite to a geometry object
  st_sf() %>% # make the geometry a data frame object
  nngeo::st_remove_holes() %>%
  mutate(NAZ_STAT = "Česká republika") # return back the data value

# úklid
okresy_low_res <- st_transform(okresy_low_res, 4326) # WGS84
kraje_low_res <- st_transform(kraje_low_res, 4326) # WGS84
republika_low_res <- st_transform(republika_low_res, 4326) # WGS84


# ověřit...
plot(republika_low_res)
plot(kraje_low_res, max.plot = 1)
