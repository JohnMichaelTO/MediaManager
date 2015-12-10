#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

## Choix d'une activité
while true; do

        dialog --clear \
        --backtitle "Bibliothèque" \
        --title "Créer une catégorie" \
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

# if [[ -f $INPUT ]]; then
#	rm $INPUT
# fi

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

########################################################
if [[ -f liste.txt ]]; then
	rm liste.txt
fi

# Vérification & Sécurisation : Si aucun média n'existe dans l'activité sélectionnée
DOSSIER_VIDE=$(ls -a ./Activites/$ACTIVITE/ | sed -e "/\.$/d" | wc -l)
if [ $DOSSIER_VIDE -eq 0 ]; then
        bash displayMessage.sh "Média inexistant" "Aucun média n'existe dans cette catégorie. Vous devez tout d'abord créer un média dans cette catégorie."
fi

cd Activites/$ACTIVITE/
i=1
for file in *; do
	echo $file $i >> ../../liste.txt
	i=$((i+1))
done

cd ../../

command=`cat liste.txt`
#######################################################

## Choix du média
while true; do
	#################################################################
        dialog --clear \
        --backtitle "Bibliothèque" \
        --title "Créer une catégorie" \
        --menu "Choisissez un média :" 14 48 5 ${command} 2> "${INPUT}"
	#################################################################
	
        choixmenu=$(<"${INPUT}")
	
	case $choixmenu in
		[A-Za-z0-9_\-]*) MEDIA=$choixmenu; break;;
		*) exit;;
	esac
done

if [[-f $INPUT]]; then
        rm $INPUT
fi

## Création d'une catégorie
OUTPUT="/tmp/output.txt"

touch $OUTPUT

trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

dialog --clear \
--backtitle "Bibliothèque" \
--title "Créer une catégorie" \
--inputbox "Nom de la catégorie : " 8 60 2> $OUTPUT

reponse=$?
CATEGORIE=$(<$OUTPUT)

case $reponse in
	0) mkdir -p Activites/$ACTIVITE/$MEDIA/$CATEGORIE; break;;
	*) exit;;
esac
