#!/bin/bash

INPUT=/tmp/backup.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

while true; do

	dialog --clear \
	--backtitle "Bibliothèque" \
	--title "Pret" \
	--menu "Choisissez une action :" 15 55 5 \
	1 "Consulter puis emprunter un élément" \
	2 "Liste des éléments empruntés" 2> "${INPUT}"

	choixmenu=$(<"${INPUT}")

	case $choixmenu in
		1) bash liste_emprunt.sh;;
		2) bash listeElementsEmpruntes.sh;;
		*) exit;;
	esac
done

if [[-f $INPUT]]; then
	rm $INPUT
fi
