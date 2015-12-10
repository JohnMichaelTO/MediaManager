#!/bin/bash

INPUT=/tmp/consulter.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

cat $1 | cut -d '=' -f 2 > consultation.txt

## Enregistrement dans un fichier historique de l'action
DATE_ACTION=$(date)
echo "[CONSULTATION - $DATE_ACTION] : $1" >> historique.txt

while true; do
	dialog --begin 2 5 --backtitle "Bibliothèque" \
	--title "Consultation d'une fiche" \
	--textbox consultation.txt 20 60 2> "${INPUT}"

	choixmenu=$(<"${INPUT}")

	case $choixmenu in
		*) exit;;
	esac
done
