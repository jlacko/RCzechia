
okresy <- readRDS("./data-backup/Okresy-R-2021-01.rds")

reky <- readRDS("./data-backup/Reky.rds") %>%
  select(NAZEV)

brno <- okresy %>%
  filter(KOD_OKRES == "40711") %>%
  st_transform(5514)

svitava_brno <- reky %>%
  filter(NAZEV %in% c("Svitava")) %>%
  st_transform(5514) %>%
  st_intersection(st_buffer(brno, 1200)) %>%
  st_transform(4326) %>%
  st_geometry() %>%
  st_union() %>%
  st_as_sf() %>%
  mutate(NAZEV = "Svitava")

svratka_brno <- reky %>%
  filter(NAZEV %in% c("Svratka")) %>%
  st_transform(5514) %>%
  st_intersection(st_buffer(brno, 1200)) %>%
  st_transform(4326) %>%
  st_geometry() %>%
  st_union() %>%
  st_as_sf() %>%
  mutate(NAZEV = "Svratka")

reky_brno <- rbind(svitava_brno, svratka_brno)

ggplot() +
  geom_sf(data = reky_brno, color = "slategray", alpha = 2/3, size = 1.5) +
  geom_sf(data = st_transform(brno, 4326), fill = NA, color = "gray80", size = 1.4, alpha = 2/3)


praha <- okresy %>%
  filter(NAZ_LAU1 == "Praha") %>%
  st_transform(5514)

reky_praha <- reky %>%
  filter(NAZEV %in% c("Vltava")) %>%
  st_transform(5514) %>%
  st_intersection(st_buffer(praha, 1200)) %>%
  st_transform(4326) %>%
  st_geometry() %>%
  st_union() %>%
#  st_line_merge() %>%
  st_as_sf() %>%
  mutate(NAZEV = "Vltava")

ggplot() +
  geom_sf(data = reky_praha, color = "slategray", alpha = 2/3, size = 1.5) +
  geom_sf(data = st_transform(praha, 4326), fill = NA, color = "gray80", size = 1.4, alpha = 2/3)
