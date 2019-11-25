#!/usr/bin/env bash

#NOTIFICATION COLORS
ORANGE="\033[0;33m"
RED="\033[0;31m"
LGREEN="\033[1;32m"
LRED="\033[1;31m"
DGRAY="\033[1;30m"


clear

echo ""

echo ""

echo ""

function pause(){
	echo -e "$RED"
	read -sn 1 -p "Press any key to continue..."
	sleep 2
}

addKey(){
	echo -e "\n$LGREEN Adding Sublime Text PGP key"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
}

addRepo(){
	echo -e "$LGREEN Adding repository to the /etc/apt/sources.list.d folder\n"
	echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list
	# echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
}

subInstall(){
	echo -e "$LRED Do you want to install sublime-text? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]]; then
		echo -e "$LGREEN Installing..."
		apt-get -qq update && apt-get -qq install sublime-text
		state=$?
		if [[ $state -eq 0 ]]; then
			echo -e "$LGREEN Installation Complete"
		else
			echo "$RED Something wrong happened!! :("
		fi
	fi
	

}

echo -e "$DGRAY Sublime Text installation Script\n"

if [ $UID -ne 0 ]; then

	echo -e "$RED You need to be root to run Script"
	exit 1
fi 

pause

addKey
state=$?

if [[ $state -eq 0 ]]; then
	addRepo
fi

subInstall

echo -e "\t\t$ORANGE Launch by running 'subl' Happy Hacking... :)"

exit 0




