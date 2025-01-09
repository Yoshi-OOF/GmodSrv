
FROM php:8.2-apache

RUN apt-get update && \
    apt-get install -y lib32gcc-s1 curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copie du dossier Gmod
COPY ../srv /gmod
RUN chmod +x /gmod/srcds_run

# Copie du code PHP
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Copie du script d'entrée
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
CMD ["/docker-entrypoint.sh"]