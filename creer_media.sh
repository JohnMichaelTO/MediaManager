#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

while true; do

        dialog --clear \
        --backtitle "Bibliothèque" \
        --title "Créer un média" \
        --menu "Choisissez une activité :" 15 55 5 \
        1 "Lire" \
        2 "Voir" \
        3 "Ecouter" 2> "${INPUT}"

        choixmenu=$(<"${INPUT}")

        case $choixmenu in
                1) ACTIVITE=Lire; break;;
                2) ACTIVITE=Voir; break;;
                3) ACTIVITE=Ecouter; break;;
                *) exit;;
        esac
done

if [[-f $INPUT]]; then
        rm $INPUT
fi

OUTPUT="/tmp/output.txt"

touch $OUTPUT

trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

dialog --clear \
--backtitle "Bibliothèque" \
--title "Créer un média" \
--inputbox "Nom du média : " 8 60 2> $OUTPUT

reponse=$?
media=$(<$OUTPUT)

case $reponse in
	0) mkdir -p Activites/${ACTIVITE}/${media};;
	*) exit;;
esac
