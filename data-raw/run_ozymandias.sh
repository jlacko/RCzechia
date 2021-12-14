docker run \
 -e DISABLE_AUTH=true \
 -v $(pwd)/../data-backup:/home/rstudio/data-backup \
 -v $(pwd)/../data-raw:/home/rstudio/data-raw \
 --rm \
 -p 8787:8787 \
 ozymandias
