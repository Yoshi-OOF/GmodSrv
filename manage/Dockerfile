FROM nginx:latest

RUN apt-get update && \
    apt-get install -y php8.2-fpm lib32gcc-s1 curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copie du dossier Gmod
COPY ../srv /gmod
RUN chmod +x /gmod/srcds_run

# Copie du code HTML/PHP
COPY html /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Script d'entrée
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
CMD ["/docker-entrypoint.sh"]
