#!/usr/bin/env bash

#NOTIFICATION COLORS
ORANGE="\033[0;33m"
RED="\033[0;31m"
LGREEN="\033[1;32m"
LRED="\033[1;31m"
LCYAN="\033[1;36m"
LGRAY="\033[0;37m"
YELLOW="\033[1;33m"

clear

echo ""

echo ""

echo ""

echo -e "$LCYAN Shodan Installation and Initialization script"


echo -e "$LGREEN Checking Dependencies..."
if hash pip 2>/dev/null;then
	echo -e "$LGRAY Pip is installed :)"
else
	echo -e "$YELLOW Pip not installed, Installing...:)"
	sudo apt-get -qq update
	sudo apt-get -qq install python3-pip
fi

echo -e "$LGREEN Installing Shodan..."
if hash shodan 2>/dev/null;then
	echo -e "$LGRAY Shodan is installed :)"
else
	echo -e "$YELLOW Installing...:)"
	sleep 3
	pip3 install shodan
fi

echo -e "$LGREEN Initializing..."

sleep 2

read -p "$LRED Paste your API KEY: " apiKey

sudo shodan init $apiKey

exit 0

if dpkg -s asciinema &>/dev/null; then
	echo -e "Asciinema is installed"
else
	echo -e "Installing...:)"
fi