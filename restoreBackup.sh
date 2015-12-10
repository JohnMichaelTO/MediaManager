#!/bin/bash

DESTINATION="./"
NOM_ARCHIVE="$1"

# Suppression de la bibliothèque
rm -rf ./Activites

# Copie de la sauvegarde pour effectuer la restauration
cp ./Backups/$NOM_ARCHIVE ./

# Extraction de la sauvegarde pour la restauration
tar -xzvf $NOM_ARCHIVE > /dev/null

# Suppression de l'archive copiée
rm $NOM_ARCHIVE

bash displayMessage.sh "Restauration effectuée" "La restauration de l'archive $NOM_ARCHIVE a été effectuée avec succès."
