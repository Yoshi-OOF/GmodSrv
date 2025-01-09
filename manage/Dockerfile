FROM php:8.2-apache

RUN apt-get update && \
    apt-get install -y lib32gcc-s1 curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copie du dossier Gmod
COPY ../srv /gmod
RUN chmod +x /gmod/srcds_run

# Copie du code PHP
COPY . /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/www/html

# RUN echo "Hello from GmodSrv" > /var/www/html/index.html

# Copie du script d'entrée
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
CMD ["/docker-entrypoint.sh"]