# RCzechia  [![Travis-CI Build Status](https://travis-ci.org/jlacko/RCzechia.svg?branch=master)](https://travis-ci.org/jlacko/RCzechia)

This project creates a set of shapefiles relevant to the Czech Republic. 

As of version 1.0.1 the package moved from [`sp`](https://github.com/edzer/sp/) format to [`sf`](https://github.com/r-spatial/sf) format; the latest `sp` version is 0.1.4 - if in need of fallback run: 

```R 
devtools::install_github("jlacko/RCzechia", ref = "v0.1.4")

```  

As the package is intended mainly for domestic Czech audience the detailed description will continue in Czech language.
- - - - - 
Cílem mého snažení bylo připravit set objektů pro snazší práci s geografickými daty o České republice v rámci R. 

K dispozici sice je Arc500 (https://www.arcdata.cz/produkty/geograficka-data/arccr-500) se kterým se z Rka dá přes [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html) docela dobře pracovat, ale není to ani úplně uživatelsky vstřícné ani triviální (například způsob kódování češtiny jsem vůbec nepochopil). 

Shapefily jsem trochu upravil pro snazší práci v R a vstřícnější chování k paměti.

Souřadnicový systém je převedený z Křováka na WGS84, které se více kamarádí s google aplikacemi a `ggplot2`. Vzhledem k tomu, jak snadné je v prostředí `sf` světa obohacovat shapefily o data (viz. vignette a [popis na mém blogu](http://www.jla-data.net/cze/package-rczechia/)) jsem pro verzi 1 rychle zastarávající demografické údaje vynechal.

Package obsahuje tyto objekty:
* **republika**: hranice České republiky.
* **kraje**: 14 krajů České republiky, včetně Hlavního města Prahy.  
Klíč pro připojení dat je KOD_CZNUTS3 (kód kraje).
* **okresy**: 76 okresů České republiky + Praha (která technicky není okres). 
Klíč pro připojení dat je KOD_LAU1 (kód okresu).
* **orp_polygony** 206 obcí s rozšířenou působností (trojkové obce).  
Klíč připojení dat je KOD_ORP.
* **obce_polygony**: 6.258 obcí a vojenských újezdů České republiky.  
Klíč pro připojení dat je  KOD_OBEC, v datech jsou navíc informace o příslušné obci s pověřeným obecním úřadem (tzv. dvojkové obce - KOD_POU, respektive NAZ_POU) a příslušné obci s rozšířenou působností (tzv. trojkové obce - KOD_ORP, respektive NAZ_ORP).
* **obce_body** stejné jako obce polygony, ale pouze středy.
* **casti**: primárně 57 městských částí Hlavního města Prahy, ale části jsou i pro Brno a další města.  
Klíč pro připojení dat je KOD.
* **reky**: Řeky České republiky. Přidáním do mapy pomohou základní orientaci. 
* **plochy**: Vodní plochy České republiky. Přidáním do mapy pomohou základní orientaci.


## Příklady použití package RCzechia
<p align="center">
  <img src="https://raw.githubusercontent.com/jlacko/RCzechia/master/data-raw/tomio.png" alt="Volební výsledek xenofoba Okamury"/>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/jlacko/RCzechia/master/data-raw/haunted.png" alt="Prague Haunted Places"/>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/jlacko/RCzechia/master/data-raw/interactive.png" alt="Interactive Map"/>
</p>

Shapefily vycházejí z Arc500, ©ArcČR, ARCDATA PRAHA, ZÚ, ČSÚ, 2016

## Instalace  
``` R
install.packages("devtools")  
devtools::install_github("jlacko/RCzechia")
```

V případě, že by `sf` verze dělala problémy je k dispozici verze v `sp` formátu:
``` R
devtools::install_github("jlacko/RCzechia", ref = "v0.1.4")
```
