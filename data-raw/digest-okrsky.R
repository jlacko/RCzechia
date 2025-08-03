# načte mapu obecných volebních okrsků
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2025-07"


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

okrsky_high_res <- st_read("./data-raw/20250703_ST_UVOH.xml", stringsAsFactors = F) %>%
  st_make_valid() %>%
  st_set_geometry("OriginalniHranice") %>%
  st_transform("EPSG:4326") %>%
  mutate(across(where(is.numeric), as.character)) %>%
  inner_join(obce, by = c("ObecKod" = "KOD_OBEC")) %>%
  select(Kod, Cislo, ObecKod, MomcKod, KOD_LAU1, KOD_CZNUTS3, OriginalniHranice)

colnames(okrsky_high_res) <- c("Kod", "Cislo", "ObecKod", "MomcKod",
                         "KOD_LAU1", "KOD_CZNUTS3", "geometry")
st_geometry(okrsky_high_res) <- "geometry"

okrsky_low_res <- okrsky_high_res %>%
  rmapshaper::ms_simplify(keep = 1/20,
                          keep_shapes = T)



saveRDS(okrsky_high_res, paste0("./data-backup/Okrsky-high-", rozhodne_datum, ".rds"))
saveRDS(okrsky_low_res, paste0("./data-backup/Okrsky-low-", rozhodne_datum, ".rds"))

