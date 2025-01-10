FROM php:8.2-fpm

# Copier le répertoire `/srv` vers `/gmod`
COPY /srv /gmod

# Installer les dépendances nécessaires pour le serveur GMod
RUN apt-get update && dpkg --add-architecture i386

RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    gdb

# Exposer les ports nécessaires
EXPOSE 27015
EXPOSE 27015/udp
EXPOSE 27005/udp

# Donner les permissions d'exécution au script et au binaire
RUN chmod 777 /gmod/srcds_run /gmod/srcds_linux

# Commande de démarrage par défaut
# CMD ["/gmod/srcds_run", "-game", "garrysmod", "+maxplayers", "16", "+map", "gm_construct"]
