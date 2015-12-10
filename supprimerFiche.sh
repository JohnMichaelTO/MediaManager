#!/bin/bash

dialog  --clear \
	--backtitle "Bibliothèque" \
	--title "Suppression d'une fiche" \
	--yesno "Etes-vous sûr de vouloir supprimer la fiche $1 ?" 7 60

response=$?
case $response in
   0) rm $1; bash displayMessage.sh "Suppression d'une fiche" "La fiche $1 a été supprimée avec succès.";;
   *) exit;;
esac
