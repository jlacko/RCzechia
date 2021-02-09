library(RCzechia)
library(dplyr)

context("integrace")

obec_praha <- obce_body() %>% # bod Praha (určitě správně)
  filter(KOD_LAU1 == "CZ0100")

okres_praha <- okresy("low") %>% # low res "okres" Praha (zjednodušovaný)
  filter(KOD_LAU1 == "CZ0100")

ctverec_praha <- KFME_grid() %>%
  filter(ctverec == 5952) # čtverec "střed Prahy"

low_res_stc <- kraje_low_res %>%
  filter(KOD_CZNUTS3 == "CZ020")

expect_equal(st_contains(republika("high"), okres_praha)[[1]], 1) # okres Praha je v republice
expect_equal(st_contains(okres_praha, obec_praha)[[1]], 1) # bod Praha je v okresu Praha

expect_true(st_contains(okres_praha, ctverec_praha, sparse = F)[[1]]) # čtverec Praha je v okresu Praha

expect_false(st_contains(low_res_stc, obec_praha, sparse = F)[[1]]) # bod Praha není ve Středních Čechách (je v Praze)

# bod Brno není v Brně-venkově (je v Brně městě) - ani low, ani high res
expect_false(st_contains(subset(okresy("high"), KOD_LAU1 == "CZ0643"),
                         subset(obce_body(), KOD_OBEC == "582786"),
                         sparse = F)[[1]])

expect_false(st_contains(subset(okresy("low"), KOD_LAU1 == "CZ0643"),
                         subset(obce_body(), KOD_OBEC == "582786"),
                         sparse = F)[[1]])


# rozdíl ploch = méně, než tisícina republiky
expect_equal(sum(st_area(kraje())), sum(st_area(republika())), tolerance = 1/1000)
expect_equal(sum(st_area(okresy())), sum(st_area(republika())), tolerance = 1/1000)
expect_equal(sum(st_area(kraje("low"))), sum(st_area(republika("low"))), tolerance = 1/1000)
expect_equal(sum(st_area(okresy("low"))), sum(st_area(republika("low"))), tolerance = 1/1000)
expect_equal(sum(st_area(orp_polygony())), sum(st_area(republika())), tolerance = 1/1000)
expect_equal(sum(st_area(obce_polygony())), sum(st_area(republika())), tolerance = 1/1000)

# pražské části odpovídají Praze městu
expect_equal(sum(st_area(filter(casti(), NAZ_OBEC == "Praha"))),
             st_area(subset(obce_polygony(), NAZ_OBEC == "Praha")), tolerance = 1/1000)


# Kramářova vila je v Praze / obci, orp, okresu i kraji

vila <- geocode("Gogolova 212/1, Praha 1")

expect_equal(st_join(vila, kraje(), left = F)$KOD_CZNUTS3, "CZ010") # Kramářova vila je v kraji Praha
expect_equal(st_join(vila, okresy(), left = F)$KOD_LAU1, "CZ0100") # Kramářova vila je v okrese Praha
expect_equal(st_join(vila, orp_polygony(), left = F)$KOD_ORP, "1000") # Kramářova vila je v ORP Praha
expect_equal(st_join(vila, obce_polygony(), left = F)$KOD_OBEC, "554782") # Kramářova vila je v obci Praha

# Stezka v oblacích je na Dolní Moravě

stezka <- geocode("Velká Morava 46, Dolní Morava")

expect_equal(st_join(stezka, kraje(), left = F)$KOD_CZNUTS3, "CZ053") # Stezka v oblacích je v Pardubickém kraji
expect_equal(st_join(stezka, okresy(), left = F)$KOD_LAU1, "CZ0534") # Stezka v oblacích je v okrese Ústí nad Orlicí
expect_equal(st_join(stezka, orp_polygony(), left = F)$KOD_ORP, "5305") # Stezka v oblacích je v ORP Králíky
expect_equal(st_join(stezka, obce_polygony(), left = F)$KOD_OBEC, "580163") # Stezka v oblacích je v obci Dolní Morava


