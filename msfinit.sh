#!/usr/bin/env bash

#NOTIFICATION COLORS
LCYAN="\033[1;36m"
FIUSCHA="\033[0;35m"
LGREEN="\033[1;32m"
RED="\033[0;31m"
ORANGE="\033[0;33m"
DGRAY="\033[1;30m"
LGRAY="\033[0;37m"
CYAN="\033[0;36m"


clear

function hack(){
	echo -e "$ORANGE"
	echo -e "Launch Metasploit by running 'msfconsole'"
	echo -e "Make sure to run 'db_status' to check connection to database\nHappy Hacking... :)\n"
}

function dbPort(){
	local port=`ss -natp |  awk '/5432/ { split($4,array,":"); printf "%s ", array[2]} END{print ""}'''`
	echo -e "$FIUSCHA$port"
}

function startDB(){
	echo -e "\n $LGREEN Starting PostgreSQL Database"
	service postgresql start
}

function resume(){
	echo -e "$RED"
	read -sn 1 -p "Press any key to continue..."
	sleep 2
}


function metInit(){
	echo -e "\n $LGREEN Initializing the Metasploit PostgreSQL Database"
	sleep 2
	msfdb init
}

echo -e "$LCYAN Setting up things for Metasploit Framework"

if [ $UID -ne 0 ]; then

	echo -e "$RED You need to be root to run script"
	exit 1

else

	startDB
	state=$?

	if [ $state -eq 0 ] ; then
		echo -e "$ORANGE OK! :) Database running on port $(dbPort)"
	fi

	resume

	metInit

fi

hack

exit 0
