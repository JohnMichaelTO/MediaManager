#!/bin/bash

INPUT=/tmp/creer.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

while true; do

	dialog --clear \
	--backtitle "Bibliothèque" \
	--title "Menu créer" \
	--menu "Choisissez une action :" 15 55 5 \
	1 "Créer un média" \
	2 "Créer une catégorie" \
	3 "Créer une fiche" 2> "${INPUT}"

	choixmenu=$(<"${INPUT}")

	case $choixmenu in
		1) bash creer_media.sh;;
		2) bash creer_categorie.sh;;
		3) bash creer_fiche.sh;;
		*) exit;;
	esac
done

if [[-f $INPUT]]; then
	rm $INPUT
fi
