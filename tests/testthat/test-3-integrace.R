library(RCzechia)
library(dplyr)

test_that("integrace", {

  skip_on_cran()

  obec_praha <- obce_body() %>% # bod Praha (určitě správně)
    filter(KOD_LAU1 == "CZ0100")

  okres_praha <- okresy("low") %>% # low res "okres" Praha (zjednodušovaný)
    filter(KOD_LAU1 == "CZ0100")

  ctverec_praha <- KFME_grid() %>%
    filter(ctverec == 5952) # čtverec "střed Prahy"

  low_res_stc <- kraje_low_res %>%
    filter(KOD_CZNUTS3 == "CZ020")

  expect_true(all(st_contains(republika("high"), okres_praha, sparse = F))) # okres Praha je v republice
  expect_true(all(st_contains(okres_praha, obec_praha, sparse = F))) # bod Praha je v okresu Praha

  expect_true(all(st_contains(okres_praha, ctverec_praha, sparse = F))) # čtverec Praha je v okresu Praha

  expect_false(all(st_contains(low_res_stc, obec_praha, sparse = F))) # bod Praha není ve Středních Čechách (je v Praze)

  # bod Brno není v Brně-venkově (je v Brně městě) - ani low, ani high res
  expect_false(st_contains(subset(okresy("high"), KOD_LAU1 == "CZ0643"),
                           subset(obce_body(), KOD_OBEC == "582786"),
                           sparse = F)[[1]])

  expect_false(st_contains(subset(okresy("low"), KOD_LAU1 == "CZ0643"),
                           subset(obce_body(), KOD_OBEC == "582786"),
                           sparse = F)[[1]])


  # rozdíl ploch = méně, než tisícina republiky
  expect_equal(sum(st_area(kraje("high"))), st_area(republika("high")), tolerance = 1/1000)
  expect_equal(sum(st_area(okresy("high"))), st_area(republika("high")), tolerance = 1/1000)
  expect_equal(sum(st_area(kraje("low"))), st_area(republika("low")), tolerance = 1/1000)
  expect_equal(sum(st_area(okresy("low"))), st_area(republika("low")), tolerance = 1/1000)
  expect_equal(sum(st_area(orp_polygony())), st_area(republika()), tolerance = 1/1000)
  expect_equal(sum(st_area(obce_polygony())), st_area(republika()), tolerance = 1/1000)

  # v újezdech se nevolí...
  vojaci <- filter(obce_polygony(), stringr::str_starts(NAZ_POU, "Vojenský újezd"))
  expect_equal(sum(st_area(volebni_okrsky("high"))), st_area(republika("high")) - sum(st_area(vojaci)), tolerance = 1/1000)

  expect_equal(sum(st_area(senat_obvody("high"))), st_area(republika("high")), tolerance = 1/1000)
  expect_equal(sum(st_area(zip_codes("high"))), st_area(republika("high")), tolerance = 1/1000)


  # pražské části odpovídají Praze městu
  expect_equal(sum(st_area(filter(casti(), NAZ_OBEC == "Praha"))),
               st_area(subset(obce_polygony(), NAZ_OBEC == "Praha")), tolerance = 1/1000)

  # pražské volební okrsky odpovídají Praze městu
  expect_equal(sum(st_area(subset(volebni_okrsky("high"), ObecKod == "554782"))),
               st_area(subset(obce_polygony(), NAZ_OBEC == "Praha")), tolerance = 1/1000)

  # pražské katastry odpovídají Praze městu
  expect_equal(sum(st_area(filter(katastry(), NAZ_OBEC == "Praha"))),
               st_area(subset(obce_polygony(), NAZ_OBEC == "Praha")), tolerance = 1/1000)

  # židovské město je v Praze
  expect_true(st_contains(subset(obce_polygony(), NAZ_OBEC == "Praha"),
                          subset(katastry(), NAZEV == "Josefov"),
                          sparse = F)[[1]])


  # Kramářova vila je v Praze / obci, orp, okresu i kraji

  skip_if_not(.ok_to_proceed("http://ags.cuzk.cz/arcgis/rest/services/RUIAN/Vyhledavaci_sluzba_nad_daty_RUIAN/MapServer/exts/GeocodeSOE/find"),
              message = "skipping tests - CUZK API seems down")

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

  telc <- geocode("Telč") %>% # známý bod Telč
    filter(type == "Obec")

  hrcava <- geocode("Hrčava") %>% # známý bod Hrčava
    filter(type == "Obec")

  cernousy <- geocode("Černousy") %>% # známý bod Černousy
    filter(type == "Obec")

  expect_equal(sf::st_intersection(KFME_grid("low"), telc)$ctverec, 6858) # bod Telč je ve velkém čtverci 6858
  expect_equal(sf::st_intersection(KFME_grid("high"), telc)$ctverec, "6858b") # bod Telč je v malém čtverci 6858b

  expect_equal(sf::st_intersection(KFME_grid("low"), hrcava)$ctverec, 6479) # bod Hrčava je ve velkém čtverci 6479
  expect_equal(sf::st_intersection(KFME_grid("high"), hrcava)$ctverec, "6479c") # bod Hrčava je v malém čtverci 6479c

  expect_equal(sf::st_intersection(KFME_grid("low"), cernousy)$ctverec, 4956) # bod Černousy je ve velkém čtverci 4956
  expect_equal(sf::st_intersection(KFME_grid("high"), cernousy)$ctverec, "4956c") # bod Černousy je v malém čtverci 4956c

})


test_that("dopady 51/2020 Sb.", {

  skip_on_cran()

  # očekáváné změny okresů
  bukovec <- subset(obce_body(), KOD_OBEC == "553506") %>%
    dplyr::select(NAZ_OBEC)
  cerniky <- subset(obce_body(), KOD_OBEC == "599301") %>%
    dplyr::select(NAZ_OBEC)
  harrachov <- subset(obce_body(), KOD_OBEC == "577081") %>%
    dplyr::select(NAZ_OBEC)
  studlov <- subset(obce_body(), KOD_OBEC == "544931") %>%
    dplyr::select(NAZ_OBEC)

  expect_equal(st_join(bukovec, okresy(), left = F)$KOD_LAU1, "CZ0324") # Plzeň jih
  expect_equal(st_join(cerniky, okresy(), left = F)$KOD_LAU1, "CZ0204") # Kolín
  expect_equal(st_join(harrachov, okresy(), left = F)$KOD_LAU1, "CZ0512") # Jablonec nad Nisou
  expect_equal(st_join(studlov, okresy(), left = F)$KOD_LAU1, "CZ0724") # Zlín

  # očekávané změny ORP
  bristvi <- subset(obce_body(), KOD_OBEC == "537047") %>%
    dplyr::select(NAZ_OBEC)
  frydstejn <- subset(obce_body(), KOD_OBEC == "563579") %>%
    dplyr::select(NAZ_OBEC)
  veznice <- subset(obce_body(), KOD_OBEC == "569704") %>%
    dplyr::select(NAZ_OBEC)

  expect_equal(st_join(bristvi, orp_polygony(), left = F)$KOD_ORP, "2113") # Lysá nad Labem
  expect_equal(st_join(frydstejn, orp_polygony(), left = F)$KOD_ORP, "5103") # Jablonec nad Nisou
  expect_equal(st_join(veznice, orp_polygony(), left = F)$KOD_ORP, "6102") # Havlíčkův Brod
})

test_that("Vltava dělí Prahu na dvě půlky", {

  skip_on_cran()

  # polygon Praha
  praha <- kraje() %>%
    filter(KOD_CZNUTS3 == "CZ010")

  # řeka Vltava
  reka <- reky("Praha")

  # Praha říznutá na půlky
  pulky <- praha %>%
    st_geometry() %>%
    lwgeom::st_split(reka) %>% # polygon říznutý čárou
    st_cast()

  expect_equal(length(pulky), 2) # dvě půlky z jednoho celku

})


