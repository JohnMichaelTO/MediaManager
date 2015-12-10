#!/bin/bash

INPUT=/tmp/restore.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

########################################################
if [[ -f backup_liste.txt ]]; then
	rm backup_liste.txt
fi

# Vérification & Sécurisation : Si aucune sauvegarde n'existe
DOSSIER_VIDE=$(ls -a ./Backups/ | sed -e "/\.$/d" | wc -l)
if [ $DOSSIER_VIDE -eq 0 ]; then
        bash displayMessage.sh "Sauvegarde inexistant" "Il n'y a aucune sauvegarde de la bibliothèque."
fi

cd Backups/
i=1
for file in *; do
	echo $file $i >> ../backup_liste.txt
	i=$((i+1))
done

cd ../

command=`cat backup_liste.txt`
#######################################################

## Choix d'une sauvegarde
while true; do
	#################################################################
        dialog --clear \
        --backtitle "Bibliothèque" \
        --title "Restaurer une sauvegarde" \
        --menu "Choisissez une sauvegarde :" 14 48 5 ${command} 2> "${INPUT}"
	#################################################################

        choixmenu=$(<"${INPUT}")

	case $choixmenu in
		[A-Za-z0-9_\-\.]*) bash restoreBackup.sh $choixmenu; break;;
		*) exit;;
	esac
done

if [[-f $INPUT]]; then
        rm $INPUT
fi
