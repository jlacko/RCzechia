docker run \
 -e DISABLE_AUTH=true \
 -v $(pwd)/../:/home/rstudio/ \
 --rm \
 -p 8787:8787 \
 ozymandias
