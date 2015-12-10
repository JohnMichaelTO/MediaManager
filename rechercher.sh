#!/bin/bash

INPUT=/tmp/rechercher.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

if [[ -f liste.txt ]]; then
        rm liste.txt
fi

find Activites/ -name "*" -exec grep -H "$2" {} \; | sed 's/ /_/g' | sed 's/:[a-z\-]*=/ /g' > liste.txt

NB=$(find Activites/ -name "*" -exec grep -H "$2" {} \; | sed 's/ /_/g' | sed 's/:[a-z\-]*=/ /g' | wc -l)

if [ $NB == "0" ]; then
	bash displayMessage "Aucun résultat" "Aucun résultat ne correspond à votre recherche."
	exit
fi

if [ $1 == "Consulter" ]; then
	SCRIPT="consulter.sh"
else
	SCRIPT="modifSuppr.sh"
fi

command=`cat liste.txt`
#######################################################

## Résultat de la recherche
while true; do
        #################################################################
        dialog --clear \
	--ok-label "$1" \
        --backtitle "Bibliothèque" \
        --title "Résultat de la recherche" \
        --menu "$1 une fiche :" 14 150 5 ${command} 2> "${INPUT}"
        #################################################################

        choixmenu=$(<"${INPUT}")

        case $choixmenu in
                [A-Za-z0-9_\-\\]*) bash $SCRIPT $choixmenu; break;;
                *) exit;;
        esac
done
