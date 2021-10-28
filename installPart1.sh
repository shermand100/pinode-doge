#!/bin/bash

#Welcome
if (whiptail --title "PiNode-DOGE Armbian Bullseye Installer" --yesno "To install PiNode-DOGE using this installer the following conditions are required\n\n* You have logged in as 'root'\n* You created a user called 'pinodedoge'\n* You are still logged in as 'root' now\n\nWould you like to continue?" 12 60); then

		whiptail --title "PiNode-DOGE Armbian Bullseye Installer" --msgbox "Thanks for confirming\n\nPermissions and Hostnames will now be configured, this will only take a few seconds." 12 78

##Replace file /etc/sudoers to set global sudo permissions/rules
echo -e "\e[32mDownload and replace /etc/sudoers file\e[0m"
sleep 3
wget https://raw.githubusercontent.com/shermand100/pinode-doge/Armbian-Debian/etc/sudoers
sudo chmod 0440 ~/sudoers
sudo chown root ~/sudoers
sudo mv ~/sudoers /etc/sudoers
echo -e "\e[32mGlobal permissions changed\e[0m"
sleep 3

##Change system hostname to PiNodeDOGE
echo -e "\e[32mChanging system hostname to 'PiNodeDOGE'\e[0m"
sleep 3
echo 'PiNodeDOGE' | sudo tee /etc/hostname
#sudo sed -i '6d' /etc/hosts
echo '127.0.0.1       PiNodeDOGE' | sudo tee -a /etc/hosts
sudo hostname PiNodeDOGE

##Disable IPv6 (confuses Dogecoin start script if IPv6 is present)
echo -e "\e[32mDisable IPv6\e[0m"
sleep 3
echo 'net.ipv6.conf.all.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.lo.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf

#Download stage 2 Install script
echo -e "\e[32mDownloading stage 2 Installer script\e[0m"
sleep 3
wget https://raw.githubusercontent.com/shermand100/pinode-doge/Armbian-Debian/installPart2.sh
sudo mv /root/installPart2.sh /home/pinodedoge/
sudo chown pinodedoge /home/pinodedoge/installPart2.sh
sudo chmod 755 /home/pinodedoge/installPart2.sh

##make script run when user logs in
echo '. /home/pinodedoge/installPart2.sh' | sudo tee -a /home/pinodedoge/.profile

##Configure Swap file if needed
if (whiptail --title "PiNode-DOGE Armbian Installer" --yesno "For Dogecoin to sync its blockchain from scratch, 2GB of RAM is required.\n\nIf your device does not have 2GB RAM it can be artificially created with a swap file\n\nDo you have 2GB RAM on this device?\n\n* YES\n* NO - I do not have 2GB RAM (create a swap file)" 18 60); then
	echo -e "\e[32mSwap file unchanged\e[0m"
	sleep 3
		else
			echo -e "\e[32mConfiguring 2GB Swap file (required for Dogecoin build)\e[0m"
			yes n | sudo apt install dphys-swapfile -y
			sleep 3
			wget https://raw.githubusercontent.com/shermand100/pinode-doge/Armbian-Debian/etc/dphys-swapfile
			sudo mv /root/dphys-swapfile /etc/dphys-swapfile
			sudo chmod 664 /etc/dphys-swapfile
			sudo chown root /etc/dphys-swapfile
			sudo dphys-swapfile setup
			sleep 5
			sudo dphys-swapfile swapon
			echo -e "\e[32mSwap file of 2GB Configured and enabled\e[0m"
			sleep 3
fi

whiptail --title "PiNode-DOGE Continue Install" --msgbox "I've installed everything I can as user 'root'\n\nThe system now requires a reboot for changes to be made, allow 5 minutes then login as 'pinodedoge'\n\nSelect ok to continue with reboot" 16 60

echo -e "\e[32m****************************************\e[0m"
echo -e "\e[32m****************************************\e[0m"
echo -e "\e[32m**********PiNode-DOGE rebooting**********\e[0m"
echo -e "\e[32m**********Reminder:*********************\e[0m"
echo -e "\e[32m**********User: 'pinodedoge'*************\e[0m"
echo -e "\e[32m****************************************\e[0m"
echo -e "\e[32m****************************************\e[0m"
sudo reboot

else
exit 0
fi


