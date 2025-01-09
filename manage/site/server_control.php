<?php
// Active l'affichage des erreurs en mode développement (à enlever en production)
error_reporting(E_ALL);
ini_set('display_errors', 1);

/**
 * Classe de gestion du serveur Gmod
 */
class GmodServer {
    private $serverPath; 
    private $logFile;    

    /**
     * Dans le constructeur, on utilise __DIR__ pour pointer vers le dossier où est ce script
     * et éviter les soucis de chemin relatifs.
     */
    public function __construct() {
        $this->serverPath = __DIR__ . '/srv';
        $this->logFile    = __DIR__ . '/srv/garrysmod/console.log';
    }

    /**
     * Lance le serveur s'il n'est pas déjà démarré.
     */
    public function start() {
        if (!$this->isRunning()) {
            // On exécute la commande srcds_run en tâche de fond et on récupère le PID
            $cmd = "cd " . escapeshellarg($this->serverPath) 
                 . " && ./srcds_run -game garrysmod +maxplayers 16 +map gm_construct >> "
                 . escapeshellarg($this->logFile) . " 2>&1 & echo $!";
            
            exec($cmd, $output, $returnVar);
            
            // On enregistre le PID dans pid.txt
            if (!empty($output[0])) {
                file_put_contents($this->serverPath . '/pid.txt', $output[0]);
            }
            return true;
        }
        return false;
    }

    /**
     * Arrête le serveur s'il est en cours d'exécution.
     */
    public function stop() {
        if ($this->isRunning()) {
            $pidFile = $this->serverPath . '/pid.txt';
            $pid = file_get_contents($pidFile);
            if (!empty($pid)) {
                // On tue le processus puis on supprime le fichier pid.txt
                exec('kill ' . intval($pid));
                @unlink($pidFile);
                return true;
            }
        }
        return false;
    }

    /**
     * Vérifie si le serveur est en cours d'exécution en consultant le fichier pid.txt
     * et en testant l'existence du répertoire /proc/PID sous Linux.
     */
    public function isRunning() {
        $pidFile = $this->serverPath . '/pid.txt';
        if (file_exists($pidFile)) {
            $pid = file_get_contents($pidFile);
            // /proc/$pid existe tant que le process tourne
            return !empty($pid) && file_exists("/proc/$pid");
        }
        return false;
    }

    /**
     * Récupère la fin du fichier console.log (50 lignes par défaut).
     */
    public function getConsole($lines = 50) {
        if (file_exists($this->logFile)) {
            // On utilise tail pour récupérer la fin du fichier
            $lines = intval($lines);
            $logContent = shell_exec("tail -n $lines " . escapeshellarg($this->logFile));
            return nl2br($logContent);
        }
        return "No logs available";
    }
}

/**
 * Point d'entrée pour traiter les actions envoyées en POST par fetch.
 */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $server = new GmodServer();
    $response = ['success' => false];  // Par défaut

    switch ($_POST['action']) {
        case 'start':
            $response['success'] = $server->start();
            break;

        case 'stop':
            $response['success'] = $server->stop();
            break;

        case 'status':
            $response['running'] = $server->isRunning();
            $response['success'] = true;
            break;

        case 'console':
            $response['console'] = $server->getConsole();
            $response['success'] = true;
            break;
    }

    header('Content-Type: application/json');
    echo json_encode($response);
    exit;
}
?>
