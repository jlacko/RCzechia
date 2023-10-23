 # syntax=docker/dockerfile:1
FROM rocker/rstudio:4.1.0

# for GDAL use
RUN apt-get update && apt-get -y install libexpat-dev

# for GEOS use
RUN apt-get update && apt-get -y install libsqlite3-dev

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

# and finally! set up R packages / frozen in time to keep consistent; source versions to align with local big 3
RUN R -e "options(warn=2); install.packages('devtools', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('dplyr', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('sp', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('lwgeom', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('sf', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('czso', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('BH', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('data.table', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('nngeo', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('rmapshaper', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('ggplot2', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('usethis', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('rlang', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"
RUN R -e "options(warn=2); install.packages('terra', repos = 'https://packagemanager.rstudio.com/cran/2022-12-01')"

# bleeding edge RCzechia, current CRAN (not really frozen in time, but under control)
RUN R -e "install.packages('RCzechia')"