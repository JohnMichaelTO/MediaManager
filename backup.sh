#!/bin/bash

INPUT=/tmp/backup.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

while true; do

	dialog --clear \
	--backtitle "Bibliothèque" \
	--title "Sauvegarde/restauration" \
	--menu "Choisissez une action :" 15 55 5 \
	1 "Sauvegarder la bibliothèque" \
	2 "Restaurer une bibliothèque" 2> "${INPUT}"

	choixmenu=$(<"${INPUT}")

	case $choixmenu in
		1) bash save.sh;;
		2) bash restore.sh;;
		*) exit;;
	esac
done

if [[-f $INPUT]]; then
	rm $INPUT
fi
