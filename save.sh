#!/bin/bash

OUTPUT="/tmp/save.txt"

touch $OUTPUT

trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

dialog --clear \
--backtitle "Biblioth�que" \
--title "Sauvegarder la biblioth�que" \
--inputbox "Nom de la sauvegarde : " 8 60 2> $OUTPUT

reponse=$?
nom=$(<$OUTPUT)

case $reponse in
	0) bash saveInArchive.sh "$nom";;
	*) exit;;
esac
