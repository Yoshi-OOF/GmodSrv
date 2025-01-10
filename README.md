# README du projet GmodSrv

## Prérequis
- [Docker](https://docs.docker.com/get-docker/)  
- [Docker Compose](https://docs.docker.com/compose/install/)  
- Paquets essentiels pour la construction du serveur (p. ex. build-essential, lib32gcc1) :
    ```bash
    sudo apt-get update
    sudo apt-get install -y build-essential lib32gcc1
    ```

## ou
<!-- ```bash
docker build -t nginx .
docker run -d -p 8080:80 nginx
``` -->
## Service nginx
```bash
docker run -d \
  --name nginx_container \
  -p 80:80 \
  -v "$(pwd)/conf/nginx.conf:/etc/nginx/nginx.conf:ro" \
  -v "$(pwd)/html:/usr/share/nginx/html" \
  --link php_container:php \
  nginx:latest
```

## Service PHP (FPM)
```bash
docker run -d \
  --name php_container \
  -v "$(pwd)/html:/usr/share/nginx/html" \
  php:8.2-fpm
```

## Installation
1. Cloner le dépôt.  
2. Placer-vous dans le dossier contenant le `docker-compose.yml`.

## Utilisation
1. Construire l’image :  
        ```bash
        docker-compose build
        ```
2. Démarrer les conteneurs :  
        ```bash
        docker-compose up -d
        ```
3. Arrêter les conteneurs :  
        ```bash
        docker-compose down
        ```

Pour plus de détails ou de personnalisations, modifiez le fichier `docker-compose.yml` selon vos besoins.