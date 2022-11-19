# spojí DEM data z https://land.copernicus.eu/imagery-in-situ/eu-dem/eu-dem-v1.1
# a ořízne dle potřeby

library(terra)
library(dplyr)
library(sf)

dolni <- terra::rast("./data-raw/eu_dem_v11_E40N20.TIF")
horni <- terra::rast("./data-raw/eu_dem_v11_E40N30.TIF")

celek <- terra::merge(horni, dolni)

# okolí republiky (ne jej)
maska <- RCzechia::republika() %>%
  st_bbox() %>%
  st_as_sfc() %>%
  st_transform(st_crs(celek))

cast <- crop(celek, maska, mask = T)

cast <- terra::aggregate(cast, fact = 4) # 25 m >> 100 m pixel size

# https://dieghernan.github.io/202210_tidyterra-hillshade/
slope <- terrain(cast, "slope", unit = "radians")
aspect <- terrain(cast, "aspect", unit = "radians")
hill <- shade(slope, aspect, 30, 270)

# normalize names
names(hill) <- "shades"

cast <- terra::project(cast, "EPSG:4326") %>%
  crop(RCzechia::republika(), mask = T)

hill <- terra::project(hill, "EPSG:4326")%>%
  crop(RCzechia::republika(), mask = T)

writeRaster(cast, "./data-backup/vyskopis-dem.tif", overwrite = T)
writeRaster(hill, "./data-backup/vyskopis-shaded-dem.tif", overwrite = T)
