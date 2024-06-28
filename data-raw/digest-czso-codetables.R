# Načte RUIAN soubor + obohatí ho o data z číselníku obcí
# data z CZSO staženy via {czso} package
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2024-06"

# aktuální RUIAN export - gitignorován, páč velký jak cyp...
ruian_data <- "./data-raw/20240531_ST_UKSG.xml"

print(st_layers(ruian_data))

# RUIAN polygony obcí
obce_poly <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "GeneralizovaneHranice") %>%
  select(KOD_OBEC = Kod)  %>% # , ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

colnames(obce_poly) <- c("KOD_OBEC", "geometry")
st_geometry(obce_poly) <- "geometry"

#RUIAN definiční body obcí
obce_body <- st_read(ruian_data,
                 layer = "Obce",
                 geometry_column = "DefinicniBod") %>%
  select(KOD_OBEC = Kod)  %>% # , ruian_naz = Nazev) %>%
  mutate(KOD_OBEC = as.character(KOD_OBEC)) %>%
  st_transform(4326)

colnames(obce_body) <- c("KOD_OBEC", "geometry")
st_geometry(obce_body) <- "geometry"

# CZSO číselník obcí - #043
cisob <- czso::czso_get_codelist("cis43") %>%
  mutate(CHODNOTA = as.character(chodnota)) %>%
  select(KOD_OBEC = chodnota, NAZ_OBEC = text)

# CZSO číselník okresů - #0101
cisokre <- czso::czso_get_codelist("cis101")  %>%
  mutate(CHODNOTA = as.character(chodnota)) %>%
  select(KOD_OKRES = chodnota, KOD_LAU1 = okres_lau, NAZ_LAU1 = text)

# CZSO číselník krajů - #0100
ciskraj <- czso::czso_get_codelist("cis100") %>%
  mutate(CHODNOTA = as.character(chodnota)) %>%
  select(KOD_KRAJ = chodnota, KOD_CZNUTS3 = cznuts, NAZ_CZNUTS3 = text)

# vazba obec / okres
vazob <- czso::czso_get_codelist("cis101vaz43") %>%
  mutate(CHODNOTA1 = as.character(chodnota1),
         CHODNOTA2 = as.character(chodnota2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_OKRES = CHODNOTA1)

#  vazba okres / kraj
vazokr <- czso::czso_get_codelist("cis100vaz101") %>%
  mutate(CHODNOTA1 = as.character(chodnota1),
         CHODNOTA2 = as.character(chodnota2)) %>%
  select(KOD_OKRES = CHODNOTA2, KOD_KRAJ = CHODNOTA1)

# vazba obec / pou obec
vazpou <- czso::czso_get_codelist("cis61vaz43") %>%
  mutate(CHODNOTA1 = as.character(chodnota1),
         CHODNOTA2 = as.character(chodnota2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_POU = CHODNOTA1, NAZ_POU = text1)

# vazba obec / orp obec
vazorp <- czso::czso_get_codelist("cis65vaz43") %>%
  mutate(CHODNOTA1 = as.character(chodnota1),
         CHODNOTA2 = as.character(chodnota2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_ORP = CHODNOTA1, NAZ_ORP = text1)

# pospojování do zdroje všech zdrojů :)
obce <- cisob %>%
  inner_join(vazpou, by = "KOD_OBEC") %>%
  inner_join(vazorp, by = "KOD_OBEC") %>%
  inner_join(vazob, by = "KOD_OBEC") %>%
  inner_join(cisokre, by = "KOD_OKRES") %>%
  inner_join(vazokr, by = "KOD_OKRES") %>%
  inner_join(ciskraj, by = "KOD_KRAJ")

# očekávané rozdíly = geometry column
setdiff(colnames(RCzechia::obce_polygony()), colnames(obce))

# polygony obcí s číselníky
fin_obce_poly <- obce_poly %>%
  inner_join(obce)

saveRDS(fin_obce_poly, paste0("./data-backup/ObceP-R-", rozhodne_datum, ".rds"))


# body obcí s číselníky
fin_obce_body <- obce_body %>%
  inner_join(obce)

saveRDS(fin_obce_body, paste0("./data-backup/ObceB-R-", rozhodne_datum, ".rds"))

# polygony ORP s číselníky
fin_orp_poly <- fin_obce_poly %>%
  group_by(KOD_ORP, NAZ_ORP, KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes()

saveRDS(fin_orp_poly, paste0("./data-backup/ORP-R-", rozhodne_datum, ".rds"))

# polygony okresů s číselníky
fin_okresy_poly <- fin_obce_poly %>%
  group_by(KOD_OKRES, KOD_LAU1, NAZ_LAU1, KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes()

# z Brna venkova vyříznout Brno město
fin_okresy_poly[fin_okresy_poly$KOD_LAU1=="CZ0643",] <- st_difference(fin_okresy_poly[fin_okresy_poly$KOD_LAU1=="CZ0643",], st_geometry(fin_okresy_poly[fin_okresy_poly$KOD_LAU1=="CZ0642",]))

saveRDS(fin_okresy_poly, paste0("./data-backup/Okresy-R-", rozhodne_datum, ".rds"))

# polygony krajů s číselníky
fin_kraje_poly <- fin_obce_poly %>%
  group_by(KOD_KRAJ, KOD_CZNUTS3, NAZ_CZNUTS3) %>%
  summarise() %>%
  nngeo::st_remove_holes()

# ze STČ vyříznout Prahu
fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3026",] <- st_difference(fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3026",], st_geometry(fin_kraje_poly[fin_kraje_poly$KOD_KRAJ=="3018",]))

saveRDS(fin_kraje_poly, paste0("./data-backup/Kraje-R-", rozhodne_datum, ".rds"))

# republika na brutku všechno
fin_republika_poly <- fin_obce_poly %>%
  mutate(NAZ_STAT = iconv("Česká republika", "UTF-8")) %>%
  group_by(NAZ_STAT) %>%
  summarise() %>%
  nngeo::st_remove_holes()

saveRDS(fin_republika_poly, paste0("./data-backup/Republika-R-", rozhodne_datum, ".rds"))


# RUIAN polygony MOMC
casti_poly <- st_read(ruian_data,
                     layer = "Momc",
                     geometry_column = "OriginalniHranice") %>%
  select(KOD = Kod, NAZEV = Nazev, KOD_OBEC = ObecKod)  %>%
  mutate(across(where(is.factor), as.character)) %>%
  mutate(across(where(is.numeric), as.character)) %>%
  left_join(cisob, by = "KOD_OBEC") %>%
  st_transform(4326) %>%
  st_buffer(0)

colnames(casti_poly) <- c("KOD", "NAZEV", "KOD_OBEC", "NAZ_OBEC", "geometry")
st_geometry(casti_poly) <- "geometry"

saveRDS(casti_poly, paste0("./data-backup/casti-R-", rozhodne_datum, ".rds"))

# RUIAN polygony katastr
katastry <- st_read(ruian_data,
                    layer = "KatastralniUzemi",
                    geometry_column = "OriginalniHranice") %>%
  select(KOD = Kod, NAZEV = Nazev, KOD_OBEC = ObecKod, digi = ExistujeDigitalniMapa)  %>%
  mutate(across(where(is.factor), as.character)) %>%
  mutate(across(where(is.numeric), as.character)) %>%
  mutate(digi = as.logical(digi)) %>%
  left_join(cisob, by = "KOD_OBEC") %>%
  relocate(digi, .after = "NAZ_OBEC") %>%
  st_transform(4326) %>%
  st_buffer(0)

colnames(katastry) <- c("KOD", "NAZEV", "KOD_OBEC", "NAZ_OBEC", "digi", "geometry")
st_geometry(katastry) <- "geometry"

saveRDS(katastry, paste0("./data-backup/katastry-R-", rozhodne_datum, ".rds"))
