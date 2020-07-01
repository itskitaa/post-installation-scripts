#!/usr/bin/env bash

#Declare variables

VMName="PWNShop"
vNet=
osType=Ubuntu_64
diskSize=10240
memSize=512
form="VHD"
varian="Fixed"

#create the VM

echo -e "\n [+] Creating Virtual Machine \n"
VBoxManage createvm --name $VMName --ostype $osType --register

echo -e "\n [+] Setting Up Storage media \n"
VBoxManage createmedium disk --filename "/home/`whoami`/VirtualBox VMs/$VMName/$VMName.vhd" --size $diskSize --format $form --variant $varian

echo -e "\n [+] Add SATA Storage Controllers for VM HDD \n"
VBoxManage storagectl $VMName --name SATA --add SATA --controller IntelAhci

echo -e "\n [+] Attach SATA Storage Controller \n"
VBoxManage storageattach $VMName --storagectl SATA --port 0 --device 0 --type hdd --medium "/home/`whoami`/VirtualBox VMs/$VMName/$VMName.vhd"

echo -e "\n [+] Add IDE Storage Controllers for DVD Drive \n"
VBoxManage storagectl $VMName --name IDE --add ide

echo -e "\n [+] Attach ISO File to IDE Storage Controller \n"
VBoxManage storageattach $VMName --storagectl IDE --port 0 --device 0 --type dvddrive --medium "/home/kitaa/Downloads/iso/ubuntu-18.04.4-server-amd64.iso"

echo -e "\n [+] Allocate RAM and nvram \n"
VBoxManage modifyvm $VMName  --memory $memSize --vram 16

echo -e "\n [+] Enable IO APIC \n"
VBoxManage modifyvm $VMName --ioapic on

echo -e "\n [+] Disable USB USB2.0, USB3.0 controllers \n"
VBoxManage modifyvm $VMName --usb off
VBoxManage modifyvm $VMName --usbehci off
VBoxManage modifyvm $VMName --usbxhci off

echo -e "\n [+] Setting Up Display Graphics Controller \n"
VBoxManage modifyvm  $VMName --graphicscontroller vmsvga

echo -e "\n [+] Specify boot order, 1st: dvd \n"

VBoxManage modifyvm $VMName --boot1 dvd --boot2 disk --boot3 none --boot4 none

echo -e "\n [+] Setting Up Networking \n"

echo -e "\n [+] Available Host Only Interfaces \n"

VBoxManage list hostonlyifs | grep -w "Name:" | awk '{print$2}'

echo -e "\n [+] Creating new interface \n"

vNet=$(VBoxManage hostonlyif create > /tmp/intf; grep -o 'vboxnet[[:alnum:]]' < /tmp/intf; rm /tmp/intf)
echo  "Interface created: $vNet"

VBoxManage hostonlyif ipconfig $vNet --ip 192.168.100.1

echo -e "\n [+] Adding Interfaces to VM \n"

VBoxManage modifyvm $VMName --nic2 nat --nic1 hostonly --hostonlyadapter1 $vNet

echo -e "\n [+] Setting Up DHCP Server for created Host Only Network \n"
VBoxManage dhcpserver add --interface=$vNet --server-ip=192.168.100.2 --netmask=255.255.255.0 --lower-ip=192.168.100.100 --upper-ip 192.168.100.200 --enable --global --vm=$VMName --fixed-address=192.168.100.96


echo -e "\n [+] Installing OS in VM \n"

VBoxManage unattended install $VMName --full-user-name="Alex Kyalo" --user="kitaa" --password="p@s5w0rd" --locale=en_US --country=KE --time-zone=EAT --hostname="pwnshop.kitaa.com" --iso="/home/kitaa/Downloads/iso/ubuntu-18.04.4-server-amd64.iso" --install-additions --additions-iso="/home/kitaa/.config/VirtualBox/VBoxGuestAdditions_6.1.8.iso"  --post-install-command="shutdown -r now"

echo -e "\n [+] Start $VMName VM \n"
VBoxManage startvm $VMName --type headless

echo -e "\n [+] Wait for installation to finish \n"

echo -e "Running VMs"

VBoxManage list runningvms | grep $VMName




