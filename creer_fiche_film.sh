#!/bin/bash
CREATION=$1
FICHE=$2

exec 3>&1

CREER=$(dialog --ok-label "Confirmer" --clear \
        --backtitle "Bibliothèque" \
        --title "Créer une fiche" \
        --form "\nSaisissez les informations de la fiche vidéo " 25 60 50 \
	"Titre :" 	1 1 "Titre du média" 	1 22 50 30 	\
	"Réalisateur :"	2 1 "Réalisateur" 	2 22 50 30 	\
	"Acteurs principaux :" 	3 1 "Acteur1, Acteur2" 	3 22 50 30 \
	"Durée :" 	4 1 "Durée" 		4 22 50 30 	\
	"Format de l'image :" 5 1 "Format"	5 22 50 30	\
	"Langue :"	6 1 "Langue"		6 22 50 30	\
	"Sous-titre : " 7 1 "Sous-titre"	7 22 50 30	\
	2>&1 1>&3)

exec 3>&-

echo "$CREER" > $CREATION/$FICHE

# Nouveau nom du fichier par son hash md5
NOM_FICHIER=$(md5sum $CREATION/$FICHE | cut -d ' ' -f 1)
## mv $CREATION/$FICHE $CREATION/$NOM_FICHIER
## echo $NOM_FICHIER

touch "$CREATION/$NOM_FICHIER"
HISTORIQUE=$CREATION/$NOM_FICHIER
bash addVariablesFicheFilm.sh $CREATION $FICHE $NOM_FICHIER

## Enregistrement dans un fichier historique de l'action
DATE_ACTION=$(date)
echo "[CREATION FICHE FILM - $DATE_ACTION] : $HISTORIQUE" >> historique.txt
