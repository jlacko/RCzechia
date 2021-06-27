# digest silnice & železnice

library(sf)
library(dplyr)

raw_silnice <- st_read("./data-raw/komunikace/SilniceDalnice.shp")

ciselnik_silnice <- data.frame(DATA50_K = c('2400000',
                                            '2410000',
                                            '2420000',
                                            '2430000',
                                            '2440000',
                                            '2540100',
                                            '2540200',
                                            '2540300',
                                            '2540400',
                                            '2540500',
                                            '2450000'),
                               popis = c('dálnice',
                                         'silnice pro motorová vozidla',
                                         'silnice I. třídy',
                                         'silnice II. třídy',
                                         'silnice III. třídy',
                                         'nájezd, větev křižovatky na dálnici',
                                         'nájezd, větev křižovatky na silnici pro motorová vozidla',
                                         'nájezd, větev křižovatky na silnici I. třídy',
                                         'nájezd, větev křižovatky na silnici II. třídy',
                                         'nájezd, větev křižovatky na silnici III. třídy',
                                         'silnice neevidovaná'))
clean_silnice <- raw_silnice %>%
  st_transform(4326) %>%
  inner_join(ciselnik_silnice, by = "DATA50_K") %>%
  select(CISLO_SILNICE = NAZEV, TRIDA = popis)


raw_zeleznice <- st_read("./data-raw/komunikace/ZeleznicniTrat.shp")


ciselnik_zeleznice <- data.frame(DATA50_K = c('2010000',
                                              '2020000',
                                              '2030000',
                                              '2040000',
                                              '2050000'),
                                 popis = c('železnice normálně rozchodná neelektrizovaná jednokolejná',
                                           'železnice normálně rozchodná neelektrizovaná dvou a vícekolejná',
                                           'železnice normálně rozchodná elektrizovaná jednokolejná',
                                           'železnice normálně rozchodná elektrizovaná dvou a vícekolejná',
                                           'železnice úzkorozchodná'),
                                 ELEKTRIFIKACE = c(F, F, T, T, NA),
                                 KOLEJNOST = c('jednokolejní', 'dvou a více kolejní',
                                               'jednokolejní', 'dvou a více kolejní',
                                               NA),
                                 ROZCHODNOST = c('normální', 'normální',
                                                 'normální', 'normální',
                                                 'úzkokolejka'))

clean_zeleznice <- raw_zeleznice %>%
  st_transform(4326) %>%
  inner_join(ciselnik_zeleznice, by = "DATA50_K") %>%
  select(ELEKTRIFIKACE, KOLEJNOST, ROZCHODNOST)


saveRDS(clean_silnice, "./data-backup/Silnice-D50-2021-07.rds")
saveRDS(clean_zeleznice, "./data-backup/Zeleznice-D50-2021-07.rds")
