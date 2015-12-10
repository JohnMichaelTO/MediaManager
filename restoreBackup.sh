#!/bin/bash

DESTINATION="./"
NOM_ARCHIVE="$1"

# Suppression de la biblioth�que
rm -rf ./Activites

# Copie de la sauvegarde pour effectuer la restauration
cp ./Backups/$NOM_ARCHIVE ./

# Extraction de la sauvegarde pour la restauration
tar -xzvf $NOM_ARCHIVE > /dev/null

# Suppression de l'archive copi�e
rm $NOM_ARCHIVE

bash displayMessage.sh "Restauration effectu�e" "La restauration de l'archive $NOM_ARCHIVE a �t� effectu�e avec succ�s."
