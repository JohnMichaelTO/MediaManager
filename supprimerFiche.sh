#!/bin/bash

dialog  --clear \
	--backtitle "Biblioth�que" \
	--title "Suppression d'une fiche" \
	--yesno "Etes-vous s�r de vouloir supprimer la fiche $1 ?" 7 60

response=$?
case $response in
   0) rm $1; bash displayMessage.sh "Suppression d'une fiche" "La fiche $1 a �t� supprim�e avec succ�s.";;
   *) exit;;
esac
