#!/bin/bash
CREATION=$1
FICHE=$2

exec 3>&1

CREER=$(dialog --ok-label "Confirmer" --clear \
        --backtitle "Bibliothèque" \
        --title "Créer une fiche" \
        --form "\nSaisissez les informations de la fiche audio" 25 60 50 \
	"Titre :" 	1 1 "Titre du contenu" 	1 15 50 30 	\
	"Interprète :"	3 1 "Interprète" 	3 15 50 30 	\
	"Description :"	5 1 "Description" 	6 0 200 100 	\
	"Site web :" 	7 1 "Site web" 		7 15 50 30	\
	"Label :"	8 1 "Label"		8 15 50 30	\
	"Durée :"	9 1 "Durée"		9 15 50 30	\
	2>&1 1>&3)

exec 3>&-

echo "$CREER" > $CREATION/$FICHE

# Nouveau nom du fichier par son hash md5
NOM_FICHIER=$(md5sum $CREATION/$FICHE | cut -d ' ' -f 1)
## mv $CREATION/$FICHE $CREATION/$NOM_FICHIER
## echo $NOM_FICHIER

touch "$CREATION/$NOM_FICHIER"
HISTORIQUE=$CREATION/$NOM_FICHIER
bash addVariablesFicheMusique.sh $CREATION $FICHE $NOM_FICHIER

## Enregistrement dans un fichier historique de l'action
DATE_ACTION=$(date)
echo "[CREATION FICHE MUSIQUE - $DATE_ACTION] : $HISTORIQUE" >> historique.txt
