#!/bin/bash

INPUT=/tmp/menu.sh.$$

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

## Choix d'une activité
while true; do

        dialog --clear \
        --backtitle "Bibliothèque" \
        --title "Créer une fiche" \
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

# trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

## Choix du média ########################################################
if [[ -f liste.txt ]]; then
	rm liste.txt
fi

# Vérification & Sécurisation : Si aucun média existe dans l'activité sélectionnée
DOSSIER_VIDE=$(ls -a ./Activites/$ACTIVITE/ | sed -e "/\.$/d" | wc -l)
if [ $DOSSIER_VIDE -eq 0 ]; then
	bash displayMessage.sh "Média inexistant" "Aucun média n'existe dans cette activité. Vous devez tout d'abord créer un média dans cette activité."
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
        --backtitle "Bibliothèque" \
        --title "Créer une fiche" \
        --menu "Choisissez un média :" 14 48 5 ${command} 2> "${INPUT}"

        choixmenu=$(<"${INPUT}")

	case $choixmenu in
		[A-Za-z0-9_\-]*) MEDIA=$choixmenu; break;;
		*) exit;;
	esac
done

if [ -f $INPUT ]; then
        rm $INPUT
fi
## Choix du média ########################################################

## Choix de la catégorie #################################################
if [[ -f liste.txt ]]; then
        rm liste.txt
fi

# Vérification & Sécurisation : Si aucune catégorie existe dans l'activité sélectionnée
$DOSSIER_VIDE=$(ls -a ./Activites/$ACTIVITE/$MEDIA/ | sed -e "/\.$/d" | wc -l)
if [ $DOSSIER_VIDE -eq 0 ]; then
        bash displayMessage.sh "Catégorie inexistante" "Aucune catégorie n'existe dans ce média. Vous devez tout d'abord créer une catégorie dans ce média."
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
        --backtitle "Bibliothèque" \
        --title "Créer une fiche" \
        --menu "Choisissez une catégorie :" 14 48 5 ${command} 2> "${INPUT}"

        choixmenu=$(<"${INPUT}")

        case $choixmenu in
                [A-Za-z0-9_\-]*) CATEGORIE=$choixmenu; break;;
                *) exit;;
        esac
done

if [[-f $INPUT]]; then
        rm $INPUT
fi
## Choix de la catégorie #################################################

## Création d'une fiche ##################################################

# Nom de la fiche temporaire : timestamp unix
FICHE=$(date +%s)
CREATION="Activites/$ACTIVITE/$MEDIA/$CATEGORIE"

if [ -e $CREATION ]; then
	## Lancement de la création d'une fiche sous un modèle particulier #######
	if [ "$ACTIVITE" == "Lire" ]; then
		bash creer_fiche_lecture.sh $CREATION $FICHE
	elif [ "$ACTIVITE" == "Voir" ]; then
		bash creer_fiche_film.sh $CREATION $FICHE
	else
		bash creer_fiche_musique.sh $CREATION $FICHE
	fi
	## Lancement de la création d'une fiche sous un modèle particulier #######
fi
## Création d'une fiche ##################################################
