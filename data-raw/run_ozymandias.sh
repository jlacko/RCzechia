# run the docker
docker run \
 -e DISABLE_AUTH=true \
 -v $(pwd)/../:/home/rstudio/ \
 --rm \
 -p 8787:8787 \
 ghcr.io/jlacko/rczechia:latest

# clean up detritus...
rm -rf ../.config
rm -rf ../.local
