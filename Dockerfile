FROM nginx:latest

# Mise à jour et installation des dépendances
RUN apt-get update && \
    apt-get install -y php8.2-fpm lib32gcc-s1 curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copie des fichiers nécessaires
# Assurez-vous que les fichiers existent dans le contexte de build
COPY /srv /gmod
RUN chmod +x /gmod/srcds_run

COPY /html /usr/share/nginx/html
COPY /conf/nginx.conf /etc/nginx/nginx.conf

#si non fonction commenter
# COPY ./docker-entrypoint.sh /docker-entrypoint.sh 
# RUN chmod +x /docker-entrypoint.sh

# Configuration des ports et commande par défaut
# EXPOSE 80
#si non fonction commenter
# CMD ["/docker-entrypoint.sh"]
