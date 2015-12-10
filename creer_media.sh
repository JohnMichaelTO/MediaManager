#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

while true; do

        dialog --clear \
        --backtitle "Biblioth�que" \
        --title "Cr�er un m�dia" \
        --menu "Choisissez une activit� :" 15 55 5 \
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
--backtitle "Biblioth�que" \
--title "Cr�er un m�dia" \
--inputbox "Nom du m�dia : " 8 60 2> $OUTPUT

reponse=$?
media=$(<$OUTPUT)

case $reponse in
	0) mkdir -p Activites/${ACTIVITE}/${media};;
	*) exit;;
esac
