#!/bin/bash

###Begin

##User pinodedoge creation
echo -e "\e[32mStep 1: produce user 'pinodedoge'\e[0m" 
sleep 3
sudo adduser pinodedoge --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo -e "\e[32mUser 'pinodedoge' created\e[0m"
sleep 3

#Set pinodedoge password 'PiNodeDOGE'
echo "pinodedoge:PiNodeDOGE" | sudo chpasswd
echo -e "\e[32mpinodedoge password changed to 'PiNodeDOGE'\e[0m"
sleep 3

##Replace file /etc/sudoers to set global sudo permissions/rules
echo -e "\e[32mDownload and replace /etc/sudoers file\e[0m"
sleep 3
wget https://raw.githubusercontent.com/shermand100/pinode-doge/Raspberry-Pi-OS/etc/sudoers
sudo chmod 0440 /home/pi/sudoers
sudo chown root /home/pi/sudoers
sudo mv /home/pi/sudoers /etc/sudoers
echo -e "\e[32mGlobal permissions changed\e[0m"
sleep 3

##Download part2 installer script and put in home directory to continue
wget https://raw.githubusercontent.com/shermand100/pinode-doge/Raspberry-Pi-OS/installPart2.sh
sudo mv /home/pi/installPart2.sh /home/pinodedoge/
sudo chown pinodedoge /home/pinodedoge/installPart2.sh
sudo chmod 755 /home/pinodedoge/installPart2.sh

##Change system hostname to PiNodeDOGE
echo -e "\e[32mChanging system hostname to 'PiNodeDOGE'\e[0m"
sleep 3
echo 'PiNodeDOGE' | sudo tee /etc/hostname
#sudo sed -i '6d' /etc/hosts
echo '127.0.0.1       PiNodeDOGE' | sudo tee -a /etc/hosts
sudo hostname PiNodeDOGE

##make script run when user logs in
echo '. /home/pinodedoge/installPart2.sh' | sudo tee -a /home/pinodedoge/.profile
whiptail --title "PiNode-DOGE Continue Install" --msgbox "I've installed everything I can as user 'pi'\n\nSystem will reboot, then login as 'pinodedoge' to continue using password 'PiNodeDOGE'\n\nSelect ok to continue with reboot" 16 60
echo -e "\e[32m****************************************\e[0m"
echo -e "\e[32m**********PiNode-DOGE rebooting**********\e[0m"
echo -e "\e[32m**********Reminder:*********************\e[0m"
echo -e "\e[32m**********User: 'pinodedoge'*************\e[0m"
echo -e "\e[32m**********Password: 'PiNodeDOGE'*********\e[0m"
echo -e "\e[32m****************************************\e[0m"
sleep 5
#reboot for hostname changes. Continue as pinodedoge
sudo reboot

#End of script as user 'pi'. Continues in directory /home/pinodedoge