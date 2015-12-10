#!/bin/bash
CREATION=$1
FICHE=$2
NOM_FICHIER=$3

i=1
while read line
do
	if [ $i -eq 1 ]; then VAR="titre"
	elif [ $i -eq 2 ]; then VAR="interprete"
	elif [ $i -eq 3 ]; then VAR="description"
	elif [ $i -eq 4 ]; then VAR="site"
	elif [ $i -eq 5 ]; then VAR="label"
	else VAR="duree"; fi

	echo "$VAR=$line" >> "$CREATION/$NOM_FICHIER"
	i=$(($i+1))
done < "$CREATION/$FICHE"

# Suppression du fichier temporaire si le fichier sous le nom du hash
# md5 existe
if [ -e "$CREATION/$NOM_FICHIER" ]; then
	rm "$CREATION/$FICHE"
fi
