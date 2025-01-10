FROM php:8.2-fpm

# Copier le répertoire `/srv` vers `/gmod`
COPY /srv /gmod

RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6

# DEPENDANCE
RUN apt-get update && apt-get -y --no-install-recommends --no-install-suggests install \
    wget lib32ncurses5 lib32gcc1 lib32stdc++6 lib32tinfo5 ca-certificates screen tar bzip2 gzip unzip gdb

# PORT 
EXPOSE 27015
EXPOSE 27015/udp
EXPOSE 27005/udp

RUN chmod +x /gmod/srcds_run /gmod/srcds_linux