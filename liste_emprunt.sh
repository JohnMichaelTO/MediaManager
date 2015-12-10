#!/bin/bash

INPUT=/tmp/liste_emprunt.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

if [[ -f liste.txt ]]; then
        rm liste.txt
fi

find Activites/ -name "*" -exec grep -H "titre" {} \; | sed 's/ /_/g' | sed 's/:[a-z\-]*=/ /g' > liste.txt

# Comparaison des hash md5 pour n'afficher que les éléments disponibles à l'emprunt
##############################################################################################
#while read line
#do
#	while read hash
#	do
#		CUT=`echo $line | cut -d ' ' -f 1`
#		CUT2=`echo $hash | cut -d ':' -f 1`
#		if [ $CUT == $CUT2 ]; then
#			echo $line >> listeAffichee.txt
#		fi
#	done < listeElementsPretes.txt
#done < liste.txt
###############################################################################################

command=`cat liste.txt`
#######################################################

## Liste des éléments
while true; do
        #################################################################
        dialog --clear \
        --backtitle "Bibliothèque" \
        --title "Liste des éléments" \
        --menu "Eléments :" 14 150 5 ${command} 2> "${INPUT}"
        #################################################################

        choixmenu=$(<"${INPUT}")

        case $choixmenu in
                [A-Za-z0-9_\-\\]*) bash $SCRIPT $choixmenu; break;;
                *) exit;;
        esac
done
