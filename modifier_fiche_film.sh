#!/bin/bash

NOM_FICHIER=`echo $1 | cut -d '/' -f 5`

# Regénération du chemin vers le dossier
DOSSIER=""
i=1
for i in `seq 1 4`
do
	CUT=`echo $1 | cut -d '/' -f $i`
	DOSSIER="$DOSSIER$CUT/"
done

# Retrait des variables de la fiche dans un fichier temporaire
cat $1 | cut -d '=' -f 2 > modification.txt

# Récupération des données de la fiche dans des variables
i=1
while read line
do
        if [ $i -eq 1 ]; then titre=$line
        elif [ $i -eq 2 ]; then realisateur=$line
        elif [ $i -eq 3 ]; then acteurs=$line
        elif [ $i -eq 4 ]; then duree=$line
	elif [ $i -eq 5 ]; then format-image=$line
	elif [ $i -eq 6 ]; then langue=$line
        else sous-titre=$line; fi

        i=$(($i+1))
done < modification.txt

exec 3>&1

MODIFIER=$(dialog --ok-label "Confirmer" --clear \
        --backtitle "Bibliothèque" \
        --title "Modifier une fiche vidéo" \
	--form "\nModifier les informations de la fiche vidéo " 25 60 50 \
        "Titre :"       1 1 "$titre"	   		1 11 50 30      \
        "Réalisateur :" 2 1 "$realisateur"    		2 11 50 30      \
        "Acteurs principaux :"  3 1 "$acteurs"  	3 11 50 30      \
        "Durée :"       4 1 "$duree"            	4 11 50 30      \
        "Format de l'image :" 5 1 "$format-image"       5 11 50 30      \
        "Langue :"      6 1 "$langue"            	6 11 50 30      \
        "Sous-titre : " 7 1 "$sous-titre"        	7 11 50 30      \
	2>&1 1>&3)

exec 3>&-

echo "$MODIFIER" > $DOSSIER$NOM_FICHIER

# Nouveau nom du fichier par son hash md5
NOM_MODIF=$(md5sum $DOSSIER$NOM_FICHIER | cut -d ' ' -f 1)

touch "$DOSSIER$NOM_MODIF"
HISTORIQUE=$DOSSIER$NOM_MODIF
bash addVariablesFicheFilm.sh $DOSSIER $NOM_FICHIER $NOM_MODIF

## Enregistrement dans un fichier historique de l'action
DATE_ACTION=$(date)
echo "[MODIFICATION FICHE FILM - $DATE_ACTION] : $HISTORIQUE" >> historique.txt
