docker run \
 -e  USER=jindra -e PASSWORD=Montana \
 -v /home/jindra/Documents/RCzechia/data-raw:/home/jindra/data-raw \
 -v /home/jindra/Documents/RCzechia/data-backup:/home/jindra/data-backup \
 --rm \
 -p 8787:8787 \
 ozymandias
