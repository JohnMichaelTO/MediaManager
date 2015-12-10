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
        elif [ $i -eq 2 ]; then auteur=$line
        elif [ $i -eq 3 ]; then editeur=$line
        elif [ $i -eq 4 ]; then nbpages=$line
        else resume=$line; fi

        i=$(($i+1))
done < modification.txt

exec 3>&1

MODIFIER=$(dialog --ok-label "Confirmer" --clear \
        --backtitle "Bibliothèque" \
        --title "Modifier une fiche de lecture" \
        --form "\nModifier les informations de la fiche de lecture" 25 80 50 \
	"Titre :" 	1 1 "$titre" 		1 11 50 30 	\
	"Auteur :"	3 1 "$auteur"	 	3 11 50 30 	\
	"Editeur :" 	5 1 "$editeur"	 	5 11 50 30 	\
	"Nb pages :" 	7 1 "$nbpages"		7 11 50 30	\
	"Résumé :" 	9 1 "$resume"	 	10 0 100 100 	\
	2>&1 1>&3)

exec 3>&-

echo "$MODIFIER" > $DOSSIER$NOM_FICHIER

# Nouveau nom du fichier par son hash md5
NOM_MODIF=$(md5sum $DOSSIER$NOM_FICHIER | cut -d ' ' -f 1)

touch "$DOSSIER$NOM_MODIF"
HISTORIQUE=$DOSSIER$NOM_MODIF
bash addVariablesFicheLecture.sh $DOSSIER $NOM_FICHIER $NOM_MODIF

## Enregistrement dans un fichier historique de l'action
DATE_ACTION=$(date)
echo "[MODIFICATION FICHE LECTURE - $DATE_ACTION] : $HISTORIQUE" >> historique.txt
