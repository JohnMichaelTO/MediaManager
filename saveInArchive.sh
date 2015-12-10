#!/bin/bash

TIMESTAMP=$(date +%s)
DESTINATION="Backups/"
NOM_ARCHIVE="$1_$TIMESTAMP.tar.gz"

tar -czvf $NOM_ARCHIVE Activites/ > /dev/null
mv $NOM_ARCHIVE $DESTINATION

bash displayMessage.sh "Sauvegarde effectuée" "La sauvegarde de la bibliothèque a été sauvegardée sous le nom $NOM_ARCHIVE avec succès."
