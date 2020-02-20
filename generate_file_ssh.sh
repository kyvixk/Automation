BACKUP='/etc/ssh'
BACKUP_DEST='/backup'

read -p " Veuillez précisez le chemin de votre fichier csv :" csv

read -p " Veuillez précisez le chemin destination de votre fichier :" destination

# Met en mémoire le fichier a traité + le chemin dans lequel vous voulez le déplacer

trap echo "Control-C ne peut plus etre utilise" 2

# Bloque le signal SIGINT donc l'input Ctrl C devient inutilisable

backup_file () {

        if [ ! -e $BACKUP_DEST ]
	then
		echo "Création du répertoire en cours..." && sleep 1 
		mkdir -p $BACKUP_DEST
		cd $BACKUP
		echo " Le répertoire $BACKUP_DEST vient d'être créer avec succès !"
		backup_file
	else
		echo "Backup en cours..."
		cd $BACKUP
		tar -zcvpf /backup/back$(date -u +'%H-%M').tar.gz --directory=/etc/ssh/ .

	fi
}

list_backups () {
	
	for files in $(ls $BACKUP_DEST)
	do
		echo $files
	done 
}

test_generate () {

validate_file

cat $csv | while read line
do
        Host=$(echo $line | cut -d ';' -f1)
        HostName=$(echo $line | cut -d ';' -f2)
        pem=$(echo $line | cut -d ';' -f3)
        User=$(echo $line | cut -d ';' -f4)
        Port=$(echo $line | cut -d ';' -f5)
        echo "Host $Host"
        echo "  HostName $HostName"
        echo "  IdentifyFile $pem"
        echo "  User $User"
        echo "  Port $Port"
        echo "  ProxyCommand ssh bastion -vv nc %h %p"
        echo " "
        echo " "

# Ici il lit tous les champs du fichier csv et les déclare en tant que variables puis génère les lignes du fichier ssh_config

done
}


generate_file () {
	validate_file
        test_generate >>$destination

# Si l'option No est choisi il redirigera la sortie standard dans le fichier préalablement renseigné $destination

}


quit () {

	echo "Bye ! " ; exit 0 
}

clear 

function validate_file () {

# La fonction validate_file() permet de valider l'extension du fichier si celui ci ne comporte pas l extension csv ou txt il break

case "$csv" in

*.txt | *.csv )
        echo "Extension.... "Yes"" && sleep 1
        echo "Lecture du fichier.... "Yes"" && sleep 1
        ;;

*)
        echo -e "\e[31mFailed to load the Program due to extension of the file $csv\e[0m"
        ;;

esac

}
# execution de la validation du fichier


while true 

do

if [ $? -eq 0 ]
then

for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo

echo -e "\t MENU GENERATION SSH "

echo -e "\t G -- \t Générer fichier ssh_config"

echo -e "\t T -- \t Test de la génération du fichier"

echo -e "\t B -- \t Backup Réperoire SSH"

echo -e "\t L -- \t Lister le(s) Backup(s)"

echo -e "\t Q -- \t QUIT (Quitter le menu) "


echo "Entrez une lettre (parmi les choix possibles) "

echo -e "puis tapez RETURN \n"

for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo

read answer

case "$answer" in

[bB]*)
	backup_file
        ;;
[tT]*)
        test_generate
        ;;
[gG]*)
        generate_file
        ;;

[lL]*)
        list_backups
        ;;

[qQ]*)
        quit
        ;;

*)
        echo "Veuillez entrez une des options du menu !"
        ;;


esac
fi
done

