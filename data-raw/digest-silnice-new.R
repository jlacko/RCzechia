library(sf)
library(dplyr)

print(paste(Sys.time(), "work started"))

raw_data <- st_read(dsn = "~/Downloads/TN-ROAD/TN_ROAD.gpkg",
                    query = "select * from konsolidace;",
                    quiet = T)

print(paste(Sys.time(), "data in; transforming"))

clean_data <- raw_data %>%
  summarise(.by = c(name, class, enumber, roadnumber), across(GEOMETRY, st_union)) %>%
  st_transform(4326)

st_write(clean_data, "./data-backup/silnice.parquet",
         driver = "Parquet",
         delete_dsn = T,
         quiet = T)

print(paste(Sys.time(), "work finished"))
