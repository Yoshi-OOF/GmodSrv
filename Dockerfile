FROM php:8.2-fpm

# Copier le répertoire `/srv` vers `/gmod`
COPY /srv /gmod

RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6

RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y lib32gcc-s1 lib32stdc++6

# Donner les permissions d'exécution au script `srcds_run`
RUN chmod +x /gmod/srcds_run /gmod/srcds_linux