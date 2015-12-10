#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

## Choix d'une activit�
while true; do

        dialog --clear \
        --backtitle "Biblioth�que" \
        --title "Cr�er une fiche" \
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

# trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

## Choix du m�dia ########################################################
if [[ -f liste.txt ]]; then
	rm liste.txt
fi

# V�rification & S�curisation : Si aucun m�dia existe dans l'activit� s�lectionn�e
DOSSIER_VIDE=$(ls -a ./Activites/$ACTIVITE/ | sed -e "/\.$/d" | wc -l)
if [ $DOSSIER_VIDE -eq 0 ]; then
	bash displayMessage.sh "M�dia inexistant" "Aucun m�dia n'existe dans cette activit�. Vous devez tout d'abord cr�er un m�dia dans cette activit�."
	exit
fi

cd Activites/$ACTIVITE/
i=1
for file in *; do
	echo $file $i >> ../../liste.txt
	i=$((i+1))
done

cd ../../

command=`cat liste.txt`

while true; do
        dialog --clear \
        --backtitle "Biblioth�que" \
        --title "Cr�er une fiche" \
        --menu "Choisissez un m�dia :" 14 48 5 ${command} 2> "${INPUT}"

        choixmenu=$(<"${INPUT}")

	case $choixmenu in
		[A-Za-z0-9_\-]*) MEDIA=$choixmenu; break;;
		*) exit;;
	esac
done

if [ -f $INPUT ]; then
        rm $INPUT
fi
## Choix du m�dia ########################################################

## Choix de la cat�gorie #################################################
if [[ -f liste.txt ]]; then
        rm liste.txt
fi

# V�rification & S�curisation : Si aucune cat�gorie existe dans l'activit� s�lectionn�e
$DOSSIER_VIDE=$(ls -a ./Activites/$ACTIVITE/$MEDIA/ | sed -e "/\.$/d" | wc -l)
if [ $DOSSIER_VIDE -eq 0 ]; then
        bash displayMessage.sh "Cat�gorie inexistante" "Aucune cat�gorie n'existe dans ce m�dia. Vous devez tout d'abord cr�er une cat�gorie dans ce m�dia."
        exit 
fi


cd Activites/$ACTIVITE/$MEDIA/
i=1
for file in *; do
        echo $file $i >> ../../../liste.txt
        i=$((i+1))
done

cd ../../../

command=`cat liste.txt`

while true; do
        dialog --clear \
        --backtitle "Biblioth�que" \
        --title "Cr�er une fiche" \
        --menu "Choisissez une cat�gorie :" 14 48 5 ${command} 2> "${INPUT}"

        choixmenu=$(<"${INPUT}")

        case $choixmenu in
                [A-Za-z0-9_\-]*) CATEGORIE=$choixmenu; break;;
                *) exit;;
        esac
done

if [[-f $INPUT]]; then
        rm $INPUT
fi
## Choix de la cat�gorie #################################################

## Cr�ation d'une fiche ##################################################

# Nom de la fiche temporaire : timestamp unix
FICHE=$(date +%s)
CREATION="Activites/$ACTIVITE/$MEDIA/$CATEGORIE"

if [ -e $CREATION ]; then
	## Lancement de la cr�ation d'une fiche sous un mod�le particulier #######
	if [ "$ACTIVITE" == "Lire" ]; then
		bash creer_fiche_lecture.sh $CREATION $FICHE
	elif [ "$ACTIVITE" == "Voir" ]; then
		bash creer_fiche_film.sh $CREATION $FICHE
	else
		bash creer_fiche_musique.sh $CREATION $FICHE
	fi
	## Lancement de la cr�ation d'une fiche sous un mod�le particulier #######
fi
## Cr�ation d'une fiche ##################################################
