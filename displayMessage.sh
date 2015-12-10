#!/bin/bash

INPUTMESSAGE=/tmp/displayMessage.sh.$$

trap "rm $INPUTMESSAGE; exit" SIGHUP SIGINT SIGTERM

dialog --clear \
	--begin 10 30 \
	--backtitle "Bibliothèque" \
	--title $1 \
	--msgbox $2 10 20
