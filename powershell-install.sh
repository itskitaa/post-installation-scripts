#!/usr/bin/env bash

#NOTIFICATION COLORS
GREEN="\033[0;32m"
RED="\033[0;31m"
ORANGE="\033[0;33m"
LGRAY="\033[0;37m"
LGREEN="\033[1;32m"
LCYAN="\033[1;36m"
LRED="\033[1;31m"
YELLOW="\033[1;33m"

clear

echo ""

echo ""

echo ""

function pause(){
	echo -e "$RED"
	read -sn 1 -p "Press any key to continue..."
	sleep 2
}

checkDependencies(){
	echo -e "$GREEN Checking dependencies..."
	apt-get -qq update
	if dpkg -s curl &>/dev/null; then
		echo -e "$LGRAY curl is installed"
	else
		echo -e "$YELLOW curl not found :( Installing..."
		apt-get -qq install curl
	fi

	if dpkg -s gnupg &>/dev/null; then
		echo -e "$LGRAY gnupg is installed"
	else
		echo -e "$YELLOW gnupg not found :( Installing......"
		apt-get -qq install gnupg
	fi

	if dpkg -s apt-transport-https &>/dev/null; then
		echo -e "$LGRAY apt-transport-https  is installed"
	else
		echo -e "$YELLOW apt-transport-https not found :( Installing......"
		apt-get -qq install apt-transport-https 
	fi
}

addKey(){
	echo -e "\n$LGREEN Adding Powershell Public Repo GPG key"
	curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
	sleep 2
}

addRepo(){
	echo -e "$LGREEN Adding Powershell repository under /etc/apt/sources.list.d folder"
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/powershell.list
	state=$?
	if [ $state -eq 0 ];then
		echo -e "OK"
	else
		echo -e "$RED Something wrong...:("
	fi
	sleep 2
}

getPwsh(){
	echo -e "$LGREEN Now installing Powershell.."
	apt-get -qq update
	apt-get -qq install powershell
	sleep 2
	echo -e "$ORANGE Installation complete\nLaunch Powershell by running 'pwsh'\n Happy Hacking :)"
}

echo -e "$LCYAN Powershell Installation Script"
if [ $UID -ne 0 ]; then

	echo -e "$RED You need to be root to run Script"
	exit 1
fi 

if dpkg -s pwsh &>/dev/null; then
	echo -e "$ORANGE Powershell is installed :)"
	exit 0
else
	echo -e "$YELLOW Powershell is not installed...:("
	echo -e "$LRED Do you want to install it? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]]; then
		checkDependencies
		state=$?
		if [[ $state -eq 0 ]]; then
			pause
			addKey
			addRepo
			getPwsh
		fi
	fi
fi

#git config --list (lists configurations)
#git init
#initializes an empty repository of the current working directory
#git status
#get the status of the initialized git repository

