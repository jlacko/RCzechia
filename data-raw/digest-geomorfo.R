# načte mapu geomorfologických oblastí
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!



library(sf)
library(dplyr)

target_file <- "./data-raw/geomorfo.gpkg"

sources <- data.frame(layer_names = st_layers(target_file)["name"],
                   features = st_layers(target_file)["features"]) %>%
  arrange(features)


system <- st_read(target_file,
                  layer = "system") %>%
  select(system = `Systém`,
         geometry = geom) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  st_transform(4326)

subsystem <- st_read(target_file,
                  layer = "subsystem") %>%
  select(system = `System`,
         subsystem = `Subsystem`,
         kod = ID,
         geometry = geom) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  group_by(system, subsystem, kod) %>%
  summarize() %>%
  ungroup() %>%  
  st_transform(4326)

provincie <- st_read(target_file,
                  layer = "provincie") %>%
  select(provincie = `Provincie`,
         geometry = geom) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  group_by(provincie) %>%
  summarize() %>%
  ungroup() %>%
  st_transform(4326)

subprovincie <- st_read(target_file,
                     layer = "subprovincie") %>%
  select(subprovincie = `SOUSTAVA`,
         kod = ID,
         geometry = geom) %>%
  mutate(subprovincie = stringr::str_remove_all(subprovincie, " soustava")) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  group_by(subprovincie, kod) %>%
  summarize() %>%
  ungroup() %>%
  st_transform(4326)

oblast <- st_read(target_file,
                        layer = "oblast") %>%
  select(subprovincie = `SOUSTAVA`,
         oblast = `PODSOUSTAVA`,
         kod = ID,
         geometry = geom) %>%
  mutate(subprovincie = stringr::str_remove_all(subprovincie, " soustava")) %>%
  mutate(oblast = stringr::str_remove_all(oblast, " podsoustava")) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  group_by(subprovincie, oblast, kod) %>%
  summarize() %>%
  ungroup() %>%
  st_transform(4326)

celek <- st_read(target_file,
                  layer = "celek") %>%
  select(subprovincie = `SOUSTAVA`,
         oblast = `PODSOUSTAVA`,
         celek = `CELEK`,
         kod = ID,
         geometry = geom) %>%
  mutate(subprovincie = stringr::str_remove_all(subprovincie, " soustava")) %>%
  mutate(oblast = stringr::str_remove_all(oblast, " podsoustava")) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  group_by(subprovincie, oblast, celek, kod) %>%
  summarize() %>%
  ungroup() %>%
  st_transform(4326)

podcelek <- st_read(target_file,
                 layer = "podcelek") %>%
  select(subprovincie = `SOUSTAVA`,
         oblast = `PODSOUSTAVA`,
         celek = `CELEK`,
         podcelek = `PODCELEK`,
         kod = ID,
         geometry = geom) %>%
  mutate(subprovincie = stringr::str_remove_all(subprovincie, " soustava")) %>%
  mutate(oblast = stringr::str_remove_all(oblast, " podsoustava")) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  group_by(subprovincie, oblast, celek, podcelek, kod) %>%
  summarize() %>%
  ungroup() %>%
  st_transform(4326)

okrsek <- st_read(target_file,
                    layer = "okrsek") %>%
  select(subprovincie = `SOUSTAVA`,
         oblast = `PODSOUSTAVA`,
         celek = `CELEK`,
         podcelek = `PODCELEK`,
         okrsek = `OKRSEK`,
         kod = KOD_GMJ,
         geometry = geom) %>%
  mutate(subprovincie = stringr::str_remove_all(subprovincie, " soustava")) %>%
  mutate(oblast = stringr::str_remove_all(oblast, " podsoustava")) %>%
  st_set_geometry("geometry") %>%
  st_zm() %>%
  st_cast("MULTIPOLYGON") %>%
  group_by(subprovincie, oblast, celek, podcelek, okrsek, kod) %>%
  summarize() %>%
  ungroup() %>%
  st_transform(4326)

saveRDS(system, "./data-backup/geomorfo-system-2023-03.rds")
saveRDS(subsystem, "./data-backup/geomorfo-subsystem-2023-03.rds")
saveRDS(provincie, "./data-backup/geomorfo-provincie-2023-03.rds")
saveRDS(subprovincie, "./data-backup/geomorfo-subprovincie-2023-03.rds")
saveRDS(oblast, "./data-backup/geomorfo-oblast-2023-03.rds")
saveRDS(celek, "./data-backup/geomorfo-celek-2023-03.rds")
saveRDS(podcelek, "./data-backup/geomorfo-podcelek-2023-03.rds")
saveRDS(okrsek, "./data-backup/geomorfo-okrsek-2023-03.rds")
