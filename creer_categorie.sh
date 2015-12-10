#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

## Choix d'une activit�
while true; do

        dialog --clear \
        --backtitle "Biblioth�que" \
        --title "Cr�er une cat�gorie" \
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

# if [[ -f $INPUT ]]; then
#	rm $INPUT
# fi

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

########################################################
if [[ -f liste.txt ]]; then
	rm liste.txt
fi

# V�rification & S�curisation : Si aucun m�dia n'existe dans l'activit� s�lectionn�e
DOSSIER_VIDE=$(ls -a ./Activites/$ACTIVITE/ | sed -e "/\.$/d" | wc -l)
if [ $DOSSIER_VIDE -eq 0 ]; then
        bash displayMessage.sh "M�dia inexistant" "Aucun m�dia n'existe dans cette cat�gorie. Vous devez tout d'abord cr�er un m�dia dans cette cat�gorie."
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

## Choix du m�dia
while true; do
	#################################################################
        dialog --clear \
        --backtitle "Biblioth�que" \
        --title "Cr�er une cat�gorie" \
        --menu "Choisissez un m�dia :" 14 48 5 ${command} 2> "${INPUT}"
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

## Cr�ation d'une cat�gorie
OUTPUT="/tmp/output.txt"

touch $OUTPUT

trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

dialog --clear \
--backtitle "Biblioth�que" \
--title "Cr�er une cat�gorie" \
--inputbox "Nom de la cat�gorie : " 8 60 2> $OUTPUT

reponse=$?
CATEGORIE=$(<$OUTPUT)

case $reponse in
	0) mkdir -p Activites/$ACTIVITE/$MEDIA/$CATEGORIE; break;;
	*) exit;;
esac
