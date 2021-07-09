 # syntax=docker/dockerfile:1
FROM rocker/rstudio:4.1.0

# the big three - cruel & unusual versions from source (takes about forever; should be on top of the dockerfile)

# PROJ
RUN cd \
	&& wget http://download.osgeo.org/proj/proj-4.9.3.tar.gz \
	&& tar zxvf proj-4.9.3.tar.gz  \
	&& cd proj-4.9.3/ \
	&& ./configure \
	&& make \
	&& make install

# GDAL	
RUN	cd \
	&& wget http://download.osgeo.org/gdal/2.2.3/gdal-2.2.3.tar.gz \
	&& tar zxvf gdal-2.2.3.tar.gz  \
	&& cd gdal-2.2.3 \
	&& ./configure \
	&& make \
	&& make install
	
# GEOS
RUN	cd \
	&& wget http://download.osgeo.org/geos/geos-3.6.2.tar.bz2 \
	&& bunzip2  geos-3.6.2.tar.bz2  \
	&& tar xvf geos-3.6.2.tar  \
	&& cd geos-3.6.2 \
	&& ./configure \
	&& make \
	&& make install

# other required packages; standard versions suffice...
RUN apt-get update
RUN apt-get -y install libudunits2-dev libxml2-dev libv8-dev libjq-dev libprotobuf-dev protobuf-compiler
RUN ldconfig

# and finally! set up R packages / frozen in time to keep consistent
RUN R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2021-06-30')); install.packages(c('devtools', 'dplyr', 'sp', 'lwgeom'))"
RUN R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2021-06-30')); install.packages(c('sf', 'czso', 'nngeo', 'rmapshaper'))"

# this home serves no useful purpose...
RUN rm -rf /home/rstudio
  
 
