
#!/bin/bash

# Démarrer le serveur Gmod en arrière-plan
/gmod/srcds_run -game garrysmod +maxplayers 16 +map gm_construct >> /gmod/gmod_console.log 2>&1 &

# Lancer Nginx en premier plan
# exec nginx -g 'daemon off;'