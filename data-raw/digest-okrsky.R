# načte mapu obecných volebních okrsků
#
# big fat warning: je zcela nezbytné pouštět na starém PROJ 4.9.3 !!!
#


library(sf)
library(dplyr)

rozhodne_datum <- "2021-02"


# CZSO číselník obcí - #043
cisob <- czso::czso_get_codelist("cis43") %>%
  mutate(CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_OBEC = CHODNOTA, NAZ_OBEC = TEXT)

# CZSO číselník okresů - #0101
cisokre <- czso::czso_get_codelist("cis101")  %>%
  mutate(CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_OKRES = CHODNOTA, KOD_LAU1 = OKRES_LAU, NAZ_LAU1 = TEXT)

# CZSO číselník krajů - #0100
ciskraj <- czso::czso_get_codelist("cis100") %>%
  mutate(CHODNOTA = as.character(CHODNOTA)) %>%
  select(KOD_KRAJ = CHODNOTA, KOD_CZNUTS3 = CZNUTS, NAZ_CZNUTS3 = TEXT)

# vazba obec / okres
vazob <- czso::czso_get_codelist("cis101vaz43") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_OKRES = CHODNOTA1)

#  vazba okres / kraj
vazokr <- czso::czso_get_codelist("cis100vaz101") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OKRES = CHODNOTA2, KOD_KRAJ = CHODNOTA1)

# vazba obec / pou obec
vazpou <- czso::czso_get_codelist("cis61vaz43") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_POU = CHODNOTA1, NAZ_POU = TEXT1)

# vazba obec / orp obec
vazorp <- czso::czso_get_codelist("cis65vaz43") %>%
  mutate(CHODNOTA1 = as.character(CHODNOTA1),
         CHODNOTA2 = as.character(CHODNOTA2)) %>%
  select(KOD_OBEC = CHODNOTA2, KOD_ORP = CHODNOTA1, NAZ_ORP = TEXT1)

# pospojování do zdroje všech zdrojů :)
obce <- cisob %>%
  inner_join(vazpou, by = "KOD_OBEC") %>%
  inner_join(vazorp, by = "KOD_OBEC") %>%
  inner_join(vazob, by = "KOD_OBEC") %>%
  inner_join(cisokre, by = "KOD_OKRES") %>%
  inner_join(vazokr, by = "KOD_OKRES") %>%
  inner_join(ciskraj, by = "KOD_KRAJ")

okrsky_high_res <- st_read("./data-raw/20201003_ST_UVOH.xml", stringsAsFactors = F) %>%
  st_make_valid() %>%
  st_set_geometry("OriginalniHranice") %>%
  st_cast() %>%
  st_buffer(0) %>%
  st_transform("EPSG:4326") %>%
  mutate(across(where(is.numeric), as.character)) %>%
  inner_join(obce, by = c("ObecKod" = "KOD_OBEC")) %>%
  select(Kod, Cislo, ObecKod, MomcKod, KOD_LAU1, KOD_CZNUTS3, OriginalniHranice)

okrsky_low_res <- okrsky_high_res %>%
  rmapshaper::ms_simplify(keep = 1/20,
                          keep_shapes = T) %>%
  st_buffer(0)



saveRDS(okrsky_high_res, paste0("./data-backup/Okrsky-high-", rozhodne_datum, ".rds"))
saveRDS(okrsky_low_res, paste0("./data-backup/Okrsky-low-", rozhodne_datum, ".rds"))

