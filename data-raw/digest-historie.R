library(sf)
library(arcpullr)

remote_target <- "https://services1.arcgis.com/LPm07959azIAvFRD/ArcGIS/rest/services/urrlab_historicky_gis_cesko/FeatureServer/"

objekty <- list( "3" = "okresy_1921",
                 "4" = "okresy_1930",
                 "2" = "okresy_1947",
                 "6" = "okresy_1950",
                 "7" = "okresy_1961",
                 "8" = "okresy_1970",
                 "9" = "okresy_1980",
                "10" = "okresy_1991",
                "11" = "okresy_2001",
                "12" = "okresy_2011",
                "13" = "kraje_1950",
                "14" = "kraje_1961",
                "15" = "kraje_1970",
                "16" = "kraje_1980",
                "17" = "kraje_1991",
                "18" = "kraje_2001",
                "19" = "kraje_2011")


for (i in seq_along(objekty)) {

  wrk_objekt <- arcpullr::get_spatial_layer(paste0(remote_target, names(objekty)[i]))

  info <- arcpullr::get_layer_info(paste0(remote_target, names(objekty)[i]))

  clean_objekt <- wrk_objekt %>%
    st_make_valid() %>%
    st_buffer(0) %>%
    st_transform(4326)

  colnames(clean_objekt) <- c(info$fields$alias, "geometry")

  st_geometry(clean_objekt) <- "geometry"

  duplicity <- which(duplicated(colnames(clean_objekt))) # indexy duplictních názvů sloupců

  clean_objekt <- clean_objekt[, -duplicity] # duplicitní sloupce ven!

  if((st_crs(clean_objekt)$input == "EPSG:4326") & all(st_is_valid(clean_objekt))) {
    saveRDS(clean_objekt, paste0("./data-backup/history_", objekty[i], ".rds"))
  } else {
    warning(paste(objekty[i], "je nevalidní, ještě jednou a pořádně!!"))
  }

}

