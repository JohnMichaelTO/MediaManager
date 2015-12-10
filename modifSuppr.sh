#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

ACTIVITE=`echo $1 | cut -d '/' -f 2`

# Détection de l'activité pour choisir un script de modification
if [ $ACTIVITE == "Lire" ]; then SCRIPT="modifier_fiche_lecture.sh"
elif [ $ACTIVITE == "Ecouter" ]; then SCRIPT="modifier_fiche_musique.sh"
else SCRIPT="modifier_fiche_film.sh"; fi

while true; do

	dialog --clear \
	--backtitle "Bibliothèque" \
	--title "Modifier/Supprimer une fiche" \
	--menu "Choisissez une action :" 15 55 5 \
	1 "Modifier la fiche" \
	2 "Supprimer la fiche" 2> "${INPUT}"

	choixmenu=$(<"${INPUT}")

	case $choixmenu in
		1) bash $SCRIPT $1; break;;
		2) bash supprimerFiche.sh $1; break;;
		*) exit;;
	esac
done

if [[-f $INPUT]]; then
	rm $INPUT
fi
