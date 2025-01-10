FROM php:8.2-fpm

# Copier le répertoire `/srv` vers `/gmod`
COPY /srv /gmod

# Donner les permissions d'exécution au script `srcds_run`
RUN chmod +x /gmod/srcds_run