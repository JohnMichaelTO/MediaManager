#!/bin/bash
CREATION=$1
FICHE=$2
NOM_FICHIER=$3

i=1
while read line
do
	if [ $i -eq 1 ]; then VAR="titre"
	elif [ $i -eq 2 ]; then VAR="realisateur"
	elif [ $i -eq 3 ]; then VAR="acteurs"
	elif [ $i -eq 4 ]; then VAR="duree"
	elif [ $i -eq 5 ]; then VAR="format-image"
	elif [ $i -eq 6 ]; then VAR="langue"
	else VAR="sous-titre"; fi

	echo "$VAR=$line" >> "$CREATION/$NOM_FICHIER"
	i=$(($i+1))
done < "$CREATION/$FICHE"

# Suppression du fichier temporaire si le fichier sous le nom du hash
# md5 existe
if [ -e "$CREATION/$NOM_FICHIER" ]; then
	rm "$CREATION/$FICHE"
fi
