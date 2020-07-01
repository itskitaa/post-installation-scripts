#!/usr/bin/env bash

#NOTIFICATION COLORS
GREEN="\033[0;32m"
ORANGE="\033[0;33m"
LGREEN="\033[1;32m"

echo -e "$GREEN VirtualBox installation Script"


echo -e "$LGREEN[+] Importing VirtualBox repository Key"

addKey(){
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
}

echo "$LGREEN[+] Adding VirtualBox repository"

addRepo(){
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian buster contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
}

echo "$LGREEN[+] Performing system update"

doUpdate(){
sudo apt-get update
}

echo "$LGREEN[+] Install packages dkms, virtualbox & virtualbox-ext-pack (Packages to extend VirtualBox Functionality)"

installPackage(){
sudo apt-get install -y dkms virtualbox virtualbox-ext-pack
}

echo "$ORANGE[+] You can launch VirtualBox in terminal $RED root@kali:-$ virtualbox'"
echo "$ORANGE[+] Happy Hacking :-)"
