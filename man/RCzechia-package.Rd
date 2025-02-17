% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RCzechia.R
\docType{package}
\name{RCzechia-package}
\alias{RCzechia}
\alias{RCzechia-package}
\title{RCzechia: Spatial Objects of the Czech Republic}
\description{
A selection of spatial objects relevant to the Czech Republic. Due to CRAN
package size requirements (5 MB) the objects are stored externally (on Amazon
S3) - and therefore could not be implemented as datasets. They are functions
returning data frames instead.
}
\details{
To save time (and bandwidth) the downloaded objects are saved locally in
\code{tempdir} directory when requested, and downloaded at most once \emph{per R
session}; out of respect to CRAN Repository Policy a more permanent caching
on user's side is not attempted by default – but it can be actively introduced
by the user either via a \code{RCzechia::set_home()} call or by setting the
value of \code{RCZECHIA_HOME} environment variable directly, either using a
\code{Sys.setenv()} call or via editing the \code{.Renviron} file.

This means that:
\itemize{
\item a working internet connection is required to use the full resolution objects
\item the first call to an object in a R session will download
the object from the internet (and thus take some time)
\item the user an has an option to create a permanent local cache of the objects
by setting the \code{RCZECHIA_HOME} environment variable in her  \code{.Renviron} file,
gaining a faster access to the objects in the future and sidestepping the
requirement of a working internet connection. Out of respect to CRAN
Repository Policy this is not default behavior.
}

For the most frequently used objects - \strong{republika}, \strong{kraje} and
\strong{okresy} - a low resolution version is also implemented. The low
resolution data sets are stored locally (and working internet connection is
not necessary to use them).

All objects are implemented as \code{sf} data frames.
}
\section{Data overview & download sizes}{


\itemize{
\item \emph{republika} - borders of the Czech Republic

source: \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 245.8 KB, low res version internal

\item \emph{kraje} - 14 regions / NUTS3 units

source: \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 982.2 KB, low res version internal
\item \emph{okresy} - 76 + 1 districts / LAU1 units

source:  \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 2.1 MB, low res version internal
\item \emph{orp_polygony} - 205 + 1 municipalities with extended powers

source: \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 3.1 MB, no low res version
\item \emph{obce_polygony} - 6.258 municipalities as polygons

source:  \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 13.3 MB, no low res version
\item \emph{obce_body} - 6.258 municipalities as centroids (points)

source: \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 252.0 KB, no low res version
\item \emph{casti} - 57 city districts (where available)

source:  \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 1.5 MB, no low res version
\item \emph{senat_obvody} - 81 senate districts

source:  \href{https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu}{Czech Statistical Office}, high res object: 10.5 MB, low res object: 50.0 KB
\item \emph{volebni_okrsky} - 14.733 general election districts

source:  \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 75.8 MB, low res object:  5.0 MB
\item \emph{katastry} - 13.076 cadastral areas of the Czech Republic

source: \href{https://cuzk.gov.cz/ruian/RUIAN.aspx}{RÚIAN / ČÚZK}, high res object: 26.1 MB, no low res version

\item \emph{zip_codes} - 2.671 ZIP code areas

source:  \href{https://www.czso.cz/csu/czso/podminky_pro_vyuzivani_a_dalsi_zverejnovani_statistickych_udaju_csu}{Czech Statistical Office}, high res object: 45.4 MB, low res object: 2.1 MB
\item \emph{reky} - rivers

source:  \href{https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?lng=EN&menu=2292&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-VODSTVO-V}{Data200}, high res object: 4.4 MB, low res object: 301.4 KB
\item \emph{plochy} - water bodies

source:  \href{https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?lng=EN&menu=2292&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-VODSTVO-V}{Data200}, high res object: 687.0 KB, no low res version
\item \emph{lesy} - woodland areas

source:  \href{https://www.arcdata.cz/cs-cz/produkty/data/arccr?rsource=https\%3A\%2F\%2Fwww.arcdata.cz\%2Fprodukty\%2Fgeograficka-data\%2Farccr-4}{ArcČR 500 v3.3}, high res object: 2.1 MB, no low res version
\item \emph{silnice} - roads

source:  \href{https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?menu=2296&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-DOPRAVA-V}{Data200}, high res object: 6.0 MB, no low res version
\item \emph{zeleznice} - railroads

source:  \href{https://geoportal.cuzk.cz/(S(ej02xjih2qfbe4ayjguzaidr))/Default.aspx?menu=2296&mode=TextMeta&side=mapy_data200&metadataID=CZ-CUZK-DATA200-DOPRAVA-V}{Data200}, high res object: 805.8 KB, no low res version
\item \emph{KFME_grid} - KFME grid cells (faunistické čtverce)

source:  own work,  internal
\item \emph{chr_uzemi} - protected natural areas

source:  \href{https://data.nature.cz/}{AOPK ČR}, high res object: 7.0 MB, no low res version
\item \emph{vyskopis} - terrain relief

source:  \href{https://land.copernicus.eu/en/products/products-that-are-no-longer-disseminated-on-the-clms-website}{Copernicus EU}, high res object: 68.8 MB, no low res version
\item \emph{geomorfo} - geomorphological divisions

source:  \href{https://www.arcgis.com/home/item.html?id=25813686a8564b0bbcdc951a5573cfa4}{CENIA / INSPIRE}, high res object: <1 MB, no low res version
\item \emph{historie} - historical admin areas and census records, download size ~ 100 KB to 3.5 MB depending on object

source: \href{https://www.historickygis.cz/}{URRlab}

}
}

\section{Utility functions}{

In addition the following utility functions are implemented to support spatial
workflow:

\itemize{
\item \emph{geocode} - geocoding (from address to coordinates)
\item \emph{revgeo} - reverse geocoding (from coordinates to address)
}
}

\references{
Lacko J (2023). “RCzechia: Spatial Objects of the Czech Republic.” Journal of Open Source Software, 8(83). doi:10.21105/joss.05082, https://joss.theoj.org/papers/10.21105/joss.05082.
}
\seealso{
Useful links:
\itemize{
  \item \url{https://rczechia.jla-data.net}
  \item Report bugs at \url{https://github.com/jlacko/RCzechia/issues}
}

}
\author{
\strong{Maintainer}: Jindra Lacko \email{jindra.lacko@gmail.com} (\href{https://orcid.org/0000-0002-0375-5156}{ORCID})

Other contributors:
\itemize{
  \item Nick Bearman (\href{https://orcid.org/0000-0002-8396-4061}{ORCID}) (Nick reviewed the package for JOSS, providing helpful comments leading to significant improvement of the package.) [reviewer]
}

}
