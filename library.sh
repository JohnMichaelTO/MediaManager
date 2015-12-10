#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

while true; do

	dialog --clear \
	--backtitle "Biblioth�que" \
	--title "Menu principal" \
	--menu "Choisissez une action :" 15 55 6 \
	1 "Cr�er" \
	2 "Rechercher puis Consulter" \
	3 "Rechercher puis modifier/supprimer" \
	4 "Emprunter/Consulter la liste des pr�ts" \
	5 "Sauvegarde/Restauration" \
	6 "Quitter la biblioth�que" 2> "${INPUT}"

	choixmenu=$(<"${INPUT}")

	case $choixmenu in
		1) bash creer.sh;;
		2) bash rechercherConsulter.sh;;
		3) bash rechercherModifierSupprimer.sh;;
		4) bash liste_emprunt.sh;;
		5) bash backup.sh;;
		*) exit;;
	esac
done

if [[-f $INPUT]]; then
	rm $INPUT
fi
