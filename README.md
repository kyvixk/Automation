# Déploiement fichier ssh_config à partir d'un inventaire ansible

Doho Youness V1.0
19/02/2020

## Exécution du script :

1. Exécution du script depuis un compte local :

```
sudo ./generate_ssh_config.sh 

```
2. Exécution du script depuis un compte root :

```
./generate_ssh_config.sh

```
## Présentation du Menu du script :


         MENU GENERATION SSH
         G --    Générer fichier ssh_config     -------------> Avec cette option vous pourrez créer votre fichier de configuration ssh_config grâce au fichier csv passée en paramètre

         T --    Test de la génération du fichier   -------------> Avec cette option vous pourrez générer un Test vers la sortie standard ( Fortement Recommandé avant de lancer l'option G)

         B --    Backup Réperoire SSH   -------------> Backuper le répertoire /etc/ssh/

         L --    Lister le(s) Backup(s) -------------> Lister tous les backups du répertoire /backup crée par le script si il n'est pas déjà crée

         Q --    QUIT (Quitter le menu) -------------> Quitter le script
Entrez une lettre (parmi les choix possibles) 
puis tapez RETURN
