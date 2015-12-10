#!/bin/bash

INPUT=/tmp/creer.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

while true; do

	dialog --clear \
	--backtitle "Biblioth�que" \
	--title "Menu cr�er" \
	--menu "Choisissez une action :" 15 55 5 \
	1 "Cr�er un m�dia" \
	2 "Cr�er une cat�gorie" \
	3 "Cr�er une fiche" 2> "${INPUT}"

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
