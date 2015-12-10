#!/bin/bash

OUTPUT="/tmp/output.txt"

touch $OUTPUT

trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

dialog --clear \
--backtitle "Biblioth�que" \
--title "Rechercher puis modifier/supprimer" \
--inputbox "Recherche : " 8 60 2> $OUTPUT

reponse=$?
recherche=$(<$OUTPUT)

case $reponse in
        0) bash rechercher.sh "Modifier/Supprimer" $recherche;;
        *) exit;;
esac
