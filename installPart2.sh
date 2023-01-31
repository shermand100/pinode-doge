#!/bin/bash

whiptail --title "PiNodeDOGE Continue Armbian Ubuntu Jammy Installer" --msgbox "Your PiNode-DOGE is taking shape...\n\nThis next part should only take a couple of minutes\n\nSelect ok to continue setup" 16 60

#Create debug file for handling install errors:
touch debug.log
echo "
####################
" >>debug.log
echo "Start installPart2.sh script $(date)" >>debug.log
echo "
####################
" >>debug.log

##Update and Upgrade system
echo -e "\e[32mReceiving and applying Armbian updates to latest versions\e[0m"
sleep 3
sudo apt update 2> >(tee -a debug.log >&2) && sudo apt upgrade -y 2> >(tee -a debug.log >&2) && sudo apt install armbian-config -y 2> >(tee -a debug.log >&2)

##Installing dependencies for --- Web Interface
	echo "Installing dependencies for --- Web Interface" >>debug.log
echo -e "\e[32mInstalling dependencies for --- Web Interface\e[0m"
sleep 3
sudo apt install apache2 shellinabox php php-common -y 2> >(tee -a debug.log >&2)
sleep 3

##Checking all dependencies are installed for --- miscellaneous (security tools - fail2ban-ufw, menu tool-dialog, screen)
	echo "Installing dependencies for --- miscellaneous" >>debug.log
echo -e "\e[32mChecking all dependencies are installed for --- Miscellaneous\e[0m"
sleep 3
sudo apt install git screen exfat-fuse fail2ban ufw dialog ntfs-3g avahi-daemon -y 2> >(tee -a debug.log >&2)

##Clone PiNode-DOGE to device from git
	echo "Clone PiNode-DOGE to device from git" >>debug.log
echo -e "\e[32mDownloading PiNode-DOGE files\e[0m"
sleep 3
git clone -b Armbian-Debian --single-branch https://github.com/shermand100/pinode-doge.git 2> >(tee -a debug.log >&2)

##Configure ssh security. Allows only user 'pinodedoge'. Also 'root' login disabled via ssh, restarts config to make changes
	echo "Configure ssh security" >>debug.log
echo -e "\e[32mConfiguring SSH security\e[0m"
sleep 3
sudo mv /home/pinodedoge/pinode-doge/etc/ssh/sshd_config /etc/ssh/sshd_config 2> >(tee -a debug.log >&2)
sudo chmod 644 /etc/ssh/sshd_config 2> >(tee -a debug.log >&2)
sudo chown root /etc/ssh/sshd_config 2> >(tee -a debug.log >&2)
sudo /etc/init.d/ssh restart 2> >(tee -a debug.log >&2)
echo -e "\e[32mSSH security config complete\e[0m"
sleep 3


##Enable PiNode-DOGE on boot
	echo "Enable PiNode-DOGE on boot" >>debug.log
echo -e "\e[32mEnable PiNode-DOGE on boot\e[0m"
sleep 3
sudo mv /home/pinodedoge/pinode-doge/etc/rc.local /etc/rc.local 2> >(tee -a debug.log >&2)
sudo chmod 755 /etc/rc.local 2> >(tee -a debug.log >&2)
sudo chown root /etc/rc.local 2> >(tee -a debug.log >&2)
echo -e "\e[32mSuccess\e[0m"
sleep 3

##Add PiNode-DOGE systemd services
	echo "Add PiNode-DOGE systemd services" >>debug.log
echo -e "\e[32mAdd PiNode-DOGE systemd services\e[0m"
sleep 3
sudo mv /home/pinodedoge/pinode-doge/etc/systemd/system/*.service /etc/systemd/system/ 2> >(tee -a debug.log >&2)
sudo chmod 644 /etc/systemd/system/*.service 2> >(tee -a debug.log >&2)
sudo chown root /etc/systemd/system/*.service 2> >(tee -a debug.log >&2)
sudo systemctl daemon-reload 2> >(tee -a debug.log >&2)
sudo systemctl start statusOutputs.service 2> >(tee -a debug.log >&2)
sudo systemctl enable statusOutputs.service 2> >(tee -a debug.log >&2)
echo -e "\e[32mSuccess\e[0m"
sleep 3

#Configure apache server for access to dogecoin log file
	sudo mv /home/pinodedoge/pinode-doge/etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf 2> >(tee -a debug.log >&2)
sudo chmod 777 /etc/apache2/sites-enabled/000-default.conf 2> >(tee -a debug.log >&2)
sudo chown root /etc/apache2/sites-enabled/000-default.conf 2> >(tee -a debug.log >&2)
sudo /etc/init.d/apache2 restart 2> >(tee -a debug.log >&2)

echo -e "\e[32mSuccess\e[0m"
sleep 3

##Setup local hostname
	echo "Setup local hostname" >>debug.log
sudo mv /home/pinodedoge/pinode-doge/etc/avahi/avahi-daemon.conf /etc/avahi/avahi-daemon.conf 2> >(tee -a debug.log >&2)
sudo /etc/init.d/avahi-daemon restart 2> >(tee -a debug.log >&2)

##Copy PiNode-DOGE scripts to home folder
echo -e "\e[32mMoving PiNode-DOGE scripts into position\e[0m"
sleep 3
mv /home/pinodedoge/pinode-doge/home/pinodedoge/* /home/pinodedoge/ 2> >(tee -a debug.log >&2)
mv /home/pinodedoge/pinode-doge/home/pinodedoge/.profile /home/pinodedoge/ 2> >(tee -a debug.log >&2)
sudo chmod 777 -R /home/pinodedoge/*	2> >(tee -a debug.log >&2) #Read/write access needed by www-data to action php port, address customisation
echo -e "\e[32mSuccess\e[0m"
sleep 3

##Configure Web-UI
	echo "Configure Web-UI" >>debug.log
echo -e "\e[32mConfiguring Web-UI\e[0m"
sleep 3
#First move hidden file specifically .htaccess file then entire directory
sudo mv /home/pinodedoge/pinode-doge/HTML/.htaccess /var/www/html/ 2> >(tee -a debug.log >&2)
sudo mv /home/pinodedoge/pinode-doge/HTML/*.* /var/www/html/ 2> >(tee -a debug.log >&2)
sudo mv /home/pinodedoge/pinode-doge/HTML/images /var/www/html 2> >(tee -a debug.log >&2)
sudo chown www-data -R /var/www/html/ 2> >(tee -a debug.log >&2)
sudo chmod 777 -R /var/www/html/ 2> >(tee -a debug.log >&2)

##Get DOGECOIN
	echo "Download Dogecoin ARM package" >>debug.log
#Download
wget https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-aarch64-linux-gnu.tar.gz
#Unpack
tar -zxvf dogecoin-1.14.6-aarch64-linux-gnu.tar.gz
#For consistancy between versions, rename directory
mv ~/dogecoin-1.14.6 ~/dogecoin
#Delete obsolete package
rm dogecoin-1.14.6-aarch64-linux-gnu.tar.gz

##Create .dogecoin and debug.log to set read permission for www-data user
mkdir /home/pinodedoge/.dogecoin
touch /home/pinodedoge/.dogecoin/debug.log
sudo chmod 755 /home/pinodedoge/.dogecoin/debug.log

##Install crontab
		echo "Install crontab" >>debug.log
echo -e "\e[32mSetup crontab\e[0m"
sleep 3
crontab /home/pinodedoge/pinode-doge/var/spool/cron/crontabs/pinodedoge 2> >(tee -a debug.log >&2)
echo -e "\e[32mSuccess\e[0m"
sleep 3

##Set Swappiness lower
		echo "Set RAM Swappiness lower" >>debug.log
sudo sysctl vm.swappiness=10 2> >(tee -a debug.log >&2)

## Remove left over files from git clone actions
	echo "Remove left over files from git clone actions" >>debug.log
echo -e "\e[32mCleanup leftover directories\e[0m"
sleep 3
sudo rm -r /home/pinodedoge/pinode-doge/ 2> >(tee -a debug.log >&2)

##Change log in menu to 'main'
#Delete line 28 (previous setting)
wget -O ~/.profile https://raw.githubusercontent.com/shermand100/pinode-doge/Armbian-Debian/home/pinodedoge/.profile 2> >(tee -a debug.log >&2)

##End debug log
echo "
####################
" >>debug.log
echo "End installPart2.sh script $(date)" >>debug.log
echo "
####################
" >>debug.log

## Install complete
whiptail --title "PiNode-DOGE Install Complete" --msgbox "Your PiNode-DOGE is ready\n\nInstall complete. When you log in after the reboot use the menu to change your passwords and other features.\n\nEnjoy your Dogecoin Full Node\n\nSelect ok to reboot" 16 60
echo -e "\e[32m****************************************\e[0m"
echo -e "\e[32m****************************************\e[0m"
echo -e "\e[32m**********PiNode-DOGE rebooting*********\e[0m"
echo -e "\e[32m**********Reminder:*********************\e[0m"
echo -e "\e[32m**********User: 'pinodedoge'************\e[0m"
echo -e "\e[32m****************************************\e[0m"
echo -e "\e[32m*****Will also reboot a second time*****\e[0m"
echo -e "\e[32m*************after login****************\e[0m"
echo -e "\e[32m****************************************\e[0m"
sleep 10
sudo reboot
