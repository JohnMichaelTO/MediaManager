#!/bin/bash
CREATION=$1
FICHE=$2

exec 3>&1

CREER=$(dialog --ok-label "Confirmer" --clear \
        --backtitle "Biblioth�que" \
        --title "Cr�er une fiche" \
        --form "\nSaisissez les informations de la fiche de lecture" 25 80 50 \
	"Titre :" 	1 1 "Titre du livre" 	1 11 50 30 	\
	"Auteur :"	3 1 "Auteur du livre" 	3 11 50 30 	\
	"Editeur :" 	5 1 "Editeur du livre" 	5 11 50 30 	\
	"Nb pages :" 	7 1 "Nombre de pages"	7 11 50 30	\
	"R�sum� :" 	9 1 "R�sum� du livre" 	10 0 100 100 	\
	2>&1 1>&3)

exec 3>&-

echo "$CREER" > $CREATION/$FICHE

# Nouveau nom du fichier par son hash md5
NOM_FICHIER=$(md5sum $CREATION/$FICHE | cut -d ' ' -f 1)
## mv $CREATION/$FICHE $CREATION/$NOM_FICHIER
## echo $NOM_FICHIER

touch "$CREATION/$NOM_FICHIER"
HISTORIQUE=$CREATION/$NOM_FICHIER
bash addVariablesFicheLecture.sh $CREATION $FICHE $NOM_FICHIER

## Enregistrement dans un fichier historique de l'action
DATE_ACTION=$(date)
echo "[CREATION FICHE LECTURE - $DATE_ACTION] : $HISTORIQUE" >> historique.txt
