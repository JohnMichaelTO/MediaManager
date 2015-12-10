#!/bin/bash

TIMESTAMP=$(date +%s)
DESTINATION="Backups/"
NOM_ARCHIVE="$1_$TIMESTAMP.tar.gz"

tar -czvf $NOM_ARCHIVE Activites/ > /dev/null
mv $NOM_ARCHIVE $DESTINATION

bash displayMessage.sh "Sauvegarde effectu�e" "La sauvegarde de la biblioth�que a �t� sauvegard�e sous le nom $NOM_ARCHIVE avec succ�s."
