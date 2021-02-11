library(dplyr)
library(httr)

context("republika")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(republika(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(republika(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(republika()))
expect_true(is.data.frame(republika("low")))
expect_true(is.data.frame(republika("high")))

expect_s3_class(republika(), "sf")
expect_s3_class(republika("high"), "sf")
expect_s3_class(republika("low"), "sf")

expect_equal(nrow(republika()), 1)
expect_equal(nrow(republika("low")), 1)
expect_equal(nrow(republika("high")), 1)

expect_equal(st_crs(republika("low"))$input, "EPSG:4326")
expect_equal(st_crs(republika("high"))$input, "EPSG:4326")

expect_true(all(st_is_valid(republika("high"))))
expect_true(all(st_is_valid(republika("low"))))

# sloupce se nerozbily...
expect_equal(colnames(republika()), c("NAZ_STAT", "GeneralizovaneHranice"))

expect_error(republika("bflm")) # neznámé rozlišení - očekávám high(default) / low

# low res je menší než high res
expect_true(object.size(republika("low")) < object.size(republika("high")))

context("kraje")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(kraje(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(kraje(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(kraje()))
expect_true(is.data.frame(kraje("low")))
expect_true(is.data.frame(kraje("high")))

expect_s3_class(kraje(), "sf")
expect_s3_class(kraje("high"), "sf")
expect_s3_class(kraje("low"), "sf")

expect_equal(nrow(kraje()), 14)
expect_equal(nrow(kraje("low")), 14)
expect_equal(nrow(kraje("high")), 14)

expect_equal(st_crs(kraje("low"))$input, "EPSG:4326")
expect_equal(st_crs(kraje("high"))$input, "EPSG:4326")

expect_true(all(st_is_valid(kraje("high"))))
expect_true(all(st_is_valid(kraje("low"))))

# sloupce se nerozbily...
expect_equal(colnames(kraje()), c("KOD_KRAJ", "KOD_CZNUTS3", "NAZ_CZNUTS3", "GeneralizovaneHranice"))

expect_error(kraje("bflm")) # neznámé rozlišení - očekávám high(default) / low

# low res je menší než high res
expect_true(object.size(kraje("low")) < object.size(kraje("high")))

# Středočeský kraj má v sobě díru jménem Praha - plocha je plus mínus 1%
stc_low <- kraje("low") %>%
  subset(KOD_CZNUTS3 == "CZ020")

stc_high <- kraje("high") %>%
  subset(KOD_CZNUTS3 == "CZ020")

expect_equal(st_area(stc_low), st_area(stc_high), tolerance = 1/100)

# Jihočeský kraj je jeden polygon
expect_equal(length(st_geometry(kraje("low")[kraje("low")$KOD_CZNUTS3 == "CZ031", ])), 1)
expect_equal(length(st_geometry(kraje("high")[kraje("low")$KOD_CZNUTS3 == "CZ031", ])), 1)
expect_equal(length(st_geometry(kraje()[kraje("low")$KOD_CZNUTS3 == "CZ031", ])), 1)

context("okresy")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(okresy(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(okresy(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(okresy()))
expect_true(is.data.frame(okresy("low")))
expect_true(is.data.frame(okresy("high")))

expect_s3_class(okresy(), "sf")
expect_s3_class(okresy("high"), "sf")
expect_s3_class(okresy("low"), "sf")

expect_equal(nrow(okresy()), 77)
expect_equal(nrow(okresy("low")), 77)
expect_equal(nrow(okresy("high")), 77)

expect_equal(st_crs(okresy("low"))$input, "EPSG:4326")
expect_equal(st_crs(okresy("high"))$input, "EPSG:4326")

expect_true(all(st_is_valid(okresy("high"))))
expect_true(all(st_is_valid(okresy("low"))))

# sloupce se nerozbily...
expect_equal(colnames(okresy()), c("KOD_OKRES", "KOD_LAU1", "NAZ_LAU1", "KOD_KRAJ",
                                   "KOD_CZNUTS3", "NAZ_CZNUTS3", "GeneralizovaneHranice"))

expect_error(okresy("bflm")) # neznámé rozlišení - očekávám high(default) / low

# low res je menší než high res
expect_true(object.size(okresy("low")) < object.size(okresy("high")))

context("ORP")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(orp_polygony(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(orp_polygony(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(orp_polygony()))

expect_s3_class(orp_polygony(), "sf")

expect_equal(nrow(orp_polygony()), 206) # 205 "skutečných" ORP + Praha

expect_equal(st_crs(orp_polygony())$input, "EPSG:4326")

expect_true(all(st_is_valid(orp_polygony())))

# sloupce se nerozbily...
expect_equal(colnames(orp_polygony()), c("KOD_ORP", "NAZ_ORP", "KOD_KRAJ", "KOD_CZNUTS3", "NAZ_CZNUTS3", "GeneralizovaneHranice"))


context("obce body")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(obce_body(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(obce_body(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(obce_body()))

expect_s3_class(obce_body(), "sf")

expect_equal(nrow(obce_body()), 6258)

expect_equal(st_crs(obce_body())$input, "EPSG:4326")

expect_true(all(st_is_valid(obce_body())))

# sloupce se nerozbily...
expect_equal(colnames(obce_body()), c("KOD_OBEC", "NAZ_OBEC", "KOD_POU", "NAZ_POU",
                                         "KOD_ORP", "NAZ_ORP", "KOD_OKRES", "KOD_LAU1", "NAZ_LAU1",
                                         "KOD_KRAJ", "KOD_CZNUTS3", "NAZ_CZNUTS3", "DefinicniBod"))


context("obce polygony")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(obce_polygony(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(obce_polygony(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(obce_polygony()))

expect_s3_class(obce_polygony(), "sf")

expect_equal(nrow(obce_polygony()), 6258)

expect_equal(st_crs(obce_polygony())$input, "EPSG:4326")

expect_true(all(st_is_valid(obce_polygony())))

# sloupce se nerozbily...
expect_equal(colnames(obce_polygony()), c("KOD_OBEC", "NAZ_OBEC", "KOD_POU", "NAZ_POU",
                                      "KOD_ORP", "NAZ_ORP", "KOD_OKRES", "KOD_LAU1", "NAZ_LAU1",
                                      "KOD_KRAJ", "KOD_CZNUTS3", "NAZ_CZNUTS3", "GeneralizovaneHranice"))


context("městské části")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(casti(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(casti(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(casti()))

expect_s3_class(casti(), "sf")

expect_equal(nrow(casti()), 142)

expect_equal(st_crs(casti())$input, "EPSG:4326")

expect_true(all(st_is_valid(casti())))

# sloupce se nerozbily...
expect_equal(colnames(casti()), c("KOD", "NAZEV", "KOD_OBEC", "NAZ_OBEC", "OriginalniHranice"))


context("vodní plochy")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(plochy(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(plochy(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(plochy()))

expect_s3_class(plochy(), "sf")

expect_equal(nrow(plochy()), 480)

expect_equal(st_crs(plochy())$input, "EPSG:4326")

expect_true(all(st_is_valid(plochy())))

# sloupce se nerozbily...
expect_equal(colnames(plochy()), c("TYP", "NAZEV", "NAZEV_ASCII", "VYSKA", "geometry", "Major"))


context("řeky")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(reky(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(reky(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_error(reky(NA)) # parametr je povinný
expect_error(reky("bflm")) # neznámý scope
expect_error(reky(c("Praha", "Brno"))) # moc řek...

expect_true(is.data.frame(reky()))
expect_true(is.data.frame(reky("global")))
expect_true(is.data.frame(reky("Praha")))
expect_true(is.data.frame(reky("Brno")))

expect_s3_class(reky(), "sf")
expect_s3_class(reky("global"), "sf")
expect_s3_class(reky("Praha"), "sf")
expect_s3_class(reky("Brno"), "sf")

expect_equal(nrow(reky()), 6198)
expect_equal(nrow(reky("global")), 6198)
expect_equal(nrow(reky("Praha")), 1)
expect_equal(nrow(reky("Brno")), 2)

expect_equal(st_crs(reky())$input, "EPSG:4326")
expect_equal(st_crs(reky("global"))$input, "EPSG:4326")
expect_equal(st_crs(reky("Praha"))$input, "EPSG:4326")
expect_equal(st_crs(reky("Brno"))$input, "EPSG:4326")

expect_true(all(st_is_valid(reky())))
expect_true(all(st_is_valid(reky("Praha"))))
expect_true(all(st_is_valid(reky("Brno"))))

# sloupce se nerozbily...
expect_equal(colnames(reky()), c("TYP", "NAZEV", "NAZEV_ASCII", "geometry", "Major"))


context("silnice")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(silnice(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(silnice(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(silnice()))

expect_s3_class(silnice(), "sf")

expect_equal(nrow(silnice()), 18979)

expect_equal(st_crs(silnice())$input, "EPSG:4326")

expect_true(all(st_is_valid(silnice())))

# sloupce se nerozbily...
expect_equal(colnames(silnice()), c("TRIDA", "CISLO_SILNICE", "MEZINARODNI_OZNACENI", "geometry"))


context("železnice")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(zeleznice(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(zeleznice(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(zeleznice()))

expect_s3_class(zeleznice(), "sf")

expect_equal(nrow(zeleznice()), 3525)

expect_equal(st_crs(zeleznice())$input, "EPSG:4326")

expect_true(all(st_is_valid(zeleznice())))

# sloupce se nerozbily...
expect_equal(colnames(zeleznice()), c("ELEKTRIFIKACE","KATEGORIE", "KOLEJNOST", "ROZCHODNOST", "geometry"))


context("chráněná území")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(chr_uzemi(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(chr_uzemi(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(chr_uzemi()))

expect_s3_class(chr_uzemi(), "sf")

expect_equal(nrow(chr_uzemi()), 2677)

expect_equal(st_crs(chr_uzemi())$input, "EPSG:4326")

expect_true(all(st_is_valid(chr_uzemi())))


# sloupce se nerozbily...
expect_equal(colnames(chr_uzemi()), c("TYP", "NAZEV", "PLOCHA", "geometry"))


context("lesy")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(lesy(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(lesy(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(lesy()))

expect_s3_class(lesy(), "sf")

expect_equal(nrow(lesy()), 2366)

expect_equal(st_crs(lesy())$input, "EPSG:4326")

expect_true(all(st_is_valid(lesy())))

# sloupce se nerozbily...
expect_equal(colnames(lesy()), c("geometry"))


context("faunistické čtverce")

expect_true(is.data.frame(KFME_grid()))

expect_s3_class(KFME_grid(), "sf")

expect_equal(nrow(KFME_grid()), 26 * 42) # čtverce jsou všechny
expect_equal(nrow(KFME_grid("low")), 26 * 42) # čtverce jsou všechny
expect_equal(nrow(KFME_grid("high")), 4 * 26 * 42) # čtverce jsou všechny

expect_equal(KFME_grid("low")$ctverec %>% unique() %>% length(), 26 * 42) # názvy jsou unikátní
expect_equal(KFME_grid("high")$ctverec %>% unique() %>% length(), 4 * 26 * 42) # názvy jsou unikátní

expect_equal(st_crs(KFME_grid())$input, "EPSG:4326")
expect_equal(st_crs(KFME_grid("high"))$input, "EPSG:4326")
expect_equal(st_crs(KFME_grid("low"))$input, "EPSG:4326")

expect_true(all(st_is_valid(KFME_grid())))
expect_true(all(st_is_valid(KFME_grid("high"))))
expect_true(all(st_is_valid(KFME_grid("low"))))

expect_error(KFME_grid("bflm")) # neznámé rozlišení - očekávám high(default) / low

telc <- geocode("Telč") %>% # známý bod Telč
  filter(typ == "Obec")

hrcava <- geocode("Hrčava") %>% # známý bod Hrčava
  filter(typ == "Obec")

cernousy <- geocode("Černousy") %>% # známý bod Černousy
  filter(typ == "Obec")

expect_equal(sf::st_intersection(KFME_grid("low"), telc)$ctverec, 6858) # bod Telč je ve velkém čtverci 6858
expect_equal(sf::st_intersection(KFME_grid("high"), telc)$ctverec, "6858b") # bod Telč je v malém čtverci 6858b

expect_equal(sf::st_intersection(KFME_grid("low"), hrcava)$ctverec, 6479) # bod Hrčava je ve velkém čtverci 6479
expect_equal(sf::st_intersection(KFME_grid("high"), hrcava)$ctverec, "6479c") # bod Hrčava je v malém čtverci 6479c

expect_equal(sf::st_intersection(KFME_grid("low"), cernousy)$ctverec, 4956) # bod Černousy je ve velkém čtverci 4956
expect_equal(sf::st_intersection(KFME_grid("high"), cernousy)$ctverec, "4956c") # bod Černousy je v malém čtverci 4956c


context("reliéf")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(vyskopis(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(vyskopis(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_s4_class(vyskopis(), "RasterLayer")
expect_s4_class(vyskopis("actual"), "RasterLayer")
expect_s4_class(vyskopis("rayshaded"), "RasterLayer")

# test velikosti
expect_equal(vyskopis()@ncols, 5084) # sloupce jsou všechny
expect_equal(vyskopis("actual")@ncols, 5084) # sloupce jsou všechny
expect_equal(vyskopis("rayshaded")@ncols, 5084) # sloupce jsou všechny

expect_equal(vyskopis()@nrows, 3403) # řádky jsou všechny
expect_equal(vyskopis("actual")@nrows, 3403) # řádky jsou všechny
expect_equal(vyskopis("rayshaded")@nrows, 3403) # řádky jsou všechny

# test projekce - WGS84 pure & unadultered
expect_equal(projection(crs(vyskopis())), "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
expect_equal(projection(crs(vyskopis("actual"))), "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
expect_equal(projection(crs(vyskopis("rayshaded"))), "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")

# očekávaná chyba
expect_error(vyskopis("bflm")) # neznámé rozlišení - očekávám actual / rayshaded

context("obvody senátu")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(senat_obvody(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(senat_obvody(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(senat_obvody()))
expect_true(is.data.frame(senat_obvody("low")))
expect_true(is.data.frame(senat_obvody("high")))

expect_s3_class(senat_obvody(), "sf")
expect_s3_class(senat_obvody("high"), "sf")
expect_s3_class(senat_obvody("low"), "sf")

expect_equal(nrow(senat_obvody()), 81)
expect_equal(nrow(senat_obvody("low")), 81)
expect_equal(nrow(senat_obvody("high")), 81)

expect_equal(st_crs(senat_obvody("low"))$input, "EPSG:4326")
expect_equal(st_crs(senat_obvody("high"))$input, "EPSG:4326")

expect_true(all(st_is_valid(senat_obvody("high"))))
expect_true(all(st_is_valid(senat_obvody("low"))))

# sloupce se nerozbily...
expect_equal(colnames(senat_obvody()), c("OBVOD", "SIDLO", "NAZEV_VO", "geometry"))
expect_equal(colnames(senat_obvody("high")), c("OBVOD", "SIDLO", "NAZEV_VO", "geometry"))
expect_equal(colnames(senat_obvody("low")), c("OBVOD", "SIDLO", "NAZEV_VO", "geometry"))

expect_error(senat_obvody("bflm")) # neznámé rozlišení - očekávám high(default) / low

# low res je menší než high res
expect_true(object.size(senat_obvody("low")) < object.size(senat_obvody("high")))

context("volební okrsky")

Sys.setenv("NETWORK_UP" = FALSE)
expect_message(volebni_okrsky(), "internet") # zpráva o chybějícím internetu
Sys.setenv("NETWORK_UP" = TRUE)

Sys.setenv("AWS_UP" = FALSE)
expect_message(volebni_okrsky(), "source") # zpráva o spadlém AWS
Sys.setenv("AWS_UP" = TRUE)

expect_true(is.data.frame(volebni_okrsky()))
expect_true(is.data.frame(volebni_okrsky("low")))
expect_true(is.data.frame(volebni_okrsky("high")))

expect_s3_class(volebni_okrsky(), "sf")
expect_s3_class(volebni_okrsky("high"), "sf")
expect_s3_class(volebni_okrsky("low"), "sf")

expect_equal(nrow(volebni_okrsky()), 14761)
expect_equal(nrow(volebni_okrsky("low")), 14761)
expect_equal(nrow(volebni_okrsky("high")), 14761)

expect_equal(st_crs(volebni_okrsky("low"))$input, "EPSG:4326")
expect_equal(st_crs(volebni_okrsky("high"))$input, "EPSG:4326")

expect_true(all(st_is_valid(volebni_okrsky("high"))))
expect_true(all(st_is_valid(volebni_okrsky("low"))))

# sloupce se nerozbily...
expect_equal(colnames(volebni_okrsky()), c("Kod", "Cislo", "ObecKod", "MomcKod", "OriginalniHranice"))
expect_equal(colnames(volebni_okrsky("high")), c("Kod", "Cislo", "ObecKod", "MomcKod", "OriginalniHranice"))
expect_equal(colnames(volebni_okrsky("low")), c("Kod", "Cislo", "ObecKod", "MomcKod", "OriginalniHranice"))

expect_error(volebni_okrsky("bflm")) # neznámé rozlišení - očekávám high(default) / low

# low res je menší než high res
expect_true(object.size(volebni_okrsky("low")) < object.size(volebni_okrsky("high")))

context("dopady 51/2020 Sb.")

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
