 # syntax=docker/dockerfile:1
FROM rocker/rstudio:4.1.0

# for GDAL use
RUN apt-get update && apt-get -y install libexpat-dev

# the big three - cruel & unusual versions from source (takes about forever; should be on top of the dockerfile)

# PROJ
RUN cd \
	&& wget http://download.osgeo.org/proj/proj-4.9.3.tar.gz \
	&& tar zxvf proj-4.9.3.tar.gz  \
	&& cd proj-4.9.3/ \
	&& ./configure \
	&& make -j $(nproc) \
	&& make install

# GDAL
RUN	cd \
	&& wget http://download.osgeo.org/gdal/2.2.3/gdal-2.2.3.tar.gz \
	&& tar zxvf gdal-2.2.3.tar.gz  \
	&& cd gdal-2.2.3 \
	&& ./configure \
	&& make -j $(nproc) \
	&& make install

# GEOS
RUN	cd \
	&& wget http://download.osgeo.org/geos/geos-3.6.2.tar.bz2 \
	&& bunzip2  geos-3.6.2.tar.bz2  \
	&& tar xvf geos-3.6.2.tar  \
	&& cd geos-3.6.2 \
	&& ./configure \
	&& make -j $(nproc)\
	&& make install

# other required packages; standard versions suffice...
# absolutely positively required on a single line (bo update a instal must be in the same keš)
RUN apt-get update && apt-get -y install libudunits2-dev
RUN apt-get update && apt-get -y install libxml2-dev
RUN apt-get update && apt-get -y install libv8-dev
RUN apt-get update && apt-get -y install libjq-dev
RUN apt-get update && apt-get -y install libprotobuf-dev
RUN apt-get update && apt-get -y install protobuf-compiler
RUN apt-get update && apt-get -y install libxtst6
RUN apt-get update && apt-get -y install libfontconfig1-dev
RUN apt-get update && apt-get -y install libharfbuzz-dev
RUN apt-get update && apt-get -y install libfribidi-dev
RUN apt-get update && apt-get -y install libfreetype6-dev
RUN apt-get update && apt-get -y install libpng-dev
RUN apt-get update && apt-get -y install libtiff5-dev
RUN apt-get update && apt-get -y install libjpeg-dev
RUN ldconfig

# and finally! set up R packages / frozen in time to keep consistent
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('devtools')) install.packages(c('devtools'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('dplyr')) install.packages(c('dplyr'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('sp')) install.packages(c('sp'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('lwgeom')) install.packages(c('lwgeom'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('sf')) install.packages(c('sf'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('czso')) install.packages(c('czso'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('BH')) install.packages(c('BH'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('data.table')) install.packages(c('data.table'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('nngeo')) install.packages(c('nngeo'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('rmapshaper')) install.packages(c('rmapshaper'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('ggplot2')) install.packages(c('ggplot2'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('usethis')) install.packages(c('usethis'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('rlang')) install.packages(c('rlang'))"
RUN R -e "options(repos = list(CRAN = 'https://packagemanager.rstudio.com/cran/2023-09-30')); if(!require('arcpullr')) install.packages(c('arcpullr'))"


# bleeding edge RCzechia, current CRAN (not really frozen in time, but under control)
RUN R -e "install.packages('RCzechia')"



