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
docker build -t nginx .
docker run -d -p 8080:80 nginx

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