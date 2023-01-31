#!/bin/bash
#Create/ammend debug file for handling update errors:
touch debug.log
echo "
####################
" >>debug.log
echo "Start update-pinodedoge.sh script $(date)" >>debug.log
echo "
####################
" >>debug.log
sleep 1	
##Update and Upgrade system
	echo "Update and Upgrade system" >>debug.log
echo -e "\e[32mReceiving and applying Raspbian updates to latest versions\e[0m"
sleep 3
sudo apt update 2> >(tee -a debug.log >&2) && sudo apt upgrade -y 2> >(tee -a debug.log >&2)

##Checking all dependencies are installed for --- Web Interface
	echo "Update dependencies for Web interface" >>debug.log
echo -e "\e[32m##Checking all dependencies are installed for --- Web Interface\e[0m"
sleep 3
sudo apt install git apache2 shellinabox php php-common -y 2> >(tee -a debug.log >&2)
echo -e "\e[32mSuccess\e[0m"
sleep 3

##Installing dependencies for --- miscellaneous (security tools-fail2ban-ufw, menu tool-dialog, screen, mariadb)
	echo "Installing dependencies for --- miscellaneous" >>debug.log
echo -e "\e[32mInstalling dependencies for --- Miscellaneous\e[0m"
sleep 3
sudo apt install screen exfat-fuse exfat-utils fail2ban ufw dialog jq -y 2> >(tee -a debug.log >&2)

sleep 3

		#Download update files

##Replace file /etc/sudoers to set global sudo permissions/rules (required to add new permissions to www-data user for interface buttons)
echo -e "\e[32mDownload and replace /etc/sudoers file\e[0m"
sleep 3
wget https://raw.githubusercontent.com/shermand100/pinode-doge/Raspberry-Pi-OS/etc/sudoers
sudo chmod 0440 /home/pinodedoge/sudoers
sudo chown root /home/pinodedoge/sudoers
sudo mv /home/pinodedoge/sudoers /etc/sudoers
echo -e "\e[32mGlobal permissions changed\e[0m"
sleep 3


##Clone PiNode-DOGE to device from git
	echo "Clone PiNode-DOGE to device from git" >>debug.log
echo -e "\e[32mDownloading PiNode-DOGE files\e[0m"
sleep 3

git clone -b Raspberry-Pi-OS --single-branch https://github.com/shermand100/pinode-doge.git 2> >(tee -a debug.log >&2)


				#Backup User values
						echo "Backup variables" >>debug.log
					echo -e "\e[32mCreating backups of any settings you have customised\e[0m"
					echo -e "\e[32m*****\e[0m"					
					echo -e "\e[32mIf a setting did not exist on your previous version you may see some errors here for missing files, these can safely be ignored\e[0m"					
					echo -e "\e[32m*****\e[0m"						
					sleep 8
					mv /home/pinodedoge/bootstatus.sh /home/pinodedoge/bootstatus_retain.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/current-ver-doge.sh /home/pinodedoge/current-ver-doge_retain.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/current-ver-pi.sh /home/pinodedoge/current-ver-pi_retain.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/error.log /home/pinodedoge/error_retain.log 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/in-peers.sh /home/pinodedoge/in-peers_retain.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/out-peers.sh /home/pinodedoge/out-peers_retain.sh 2> >(tee -a debug.log >&2)					
					mv /home/pinodedoge/limit-rate-down.sh /home/pinodedoge/limit-rate-down_retain.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/limit-rate-up.sh /home/pinodedoge/limit-rate-up_retain.sh 2> >(tee -a debug.log >&2)

					echo -e "\e[32mUser-set configuration saved\e[0m"					
					
				#Remove old html images (prevents error when trying to overwrite non-empty directory)
				rm -R /var/www/html/images
				
				#Install Update
					echo -e "\e[32mInstalling update\e[0m"
					sleep 2
					
				##Add PiNode-DOGE systemd services
						echo "Update services" >>debug.log
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

				##Updating PiNode-DOGE scripts in home directory
						echo "Update PiNodeDOGE scripts" >>debug.log
					echo -e "\e[32mUpdating PiNode-DOGE scripts in home directory\e[0m"
					sleep 3
					mv /home/pinodedoge/pinode-doge/home/pinodedoge/* /home/pinodedoge/ 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/pinode-doge/home/pinodedoge/.profile /home/pinodedoge/ 2> >(tee -a debug.log >&2)
					sudo chmod 777 -R /home/pinodedoge/* 2> >(tee -a debug.log >&2)
					echo -e "\e[32mSuccess\e[0m"
					sleep 3
					
				##Add PiNode-DOGE php settings
						echo "Update php settings" >>debug.log
					sleep 3
					#Configure apache server for access to dogecoind log file
					sudo mv /home/pinodedoge/pinode-doge/etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf 2> >(tee -a debug.log >&2)
					sudo chmod 777 /etc/apache2/sites-enabled/000-default.conf 2> >(tee -a debug.log >&2)
					sudo chown root /etc/apache2/sites-enabled/000-default.conf 2> >(tee -a debug.log >&2)
					sudo /etc/init.d/apache2 restart 2> >(tee -a debug.log >&2)

					echo -e "\e[32mSuccess\e[0m"
					sleep 3
					
				##Setup local hostname
						echo "Update hostname (avahi)" >>debug.log
					echo -e "\e[32mEnable local hostname pinodedoge.local\e[0m"
					sleep 3				
					sudo mv /home/pinodedoge/pinode-doge/etc/avahi/avahi-daemon.conf /etc/avahi/avahi-daemon.conf 2> >(tee -a debug.log >&2)
					sudo /etc/init.d/avahi-daemon restart 2> >(tee -a debug.log >&2)
					echo -e "\e[32mSuccess\e[0m"					
					
				##Update html template
						echo "Update html template" >>debug.log	
					echo -e "\e[32mConfiguring Web-UI template with PiNode-DOGE pages\e[0m"
					sleep 3
					#First move hidden file specifically .htaccess file then entire directory
					sudo mv /home/pinodedoge/pinode-doge/HTML/.htaccess /var/www/html/ 2> >(tee -a debug.log >&2)
					sudo mv /home/pinodedoge/pinode-doge/HTML/*.* /var/www/html/ 2> >(tee -a debug.log >&2)
					sudo mv /home/pinodedoge/pinode-doge/HTML/images /var/www/html 2> >(tee -a debug.log >&2)
					sudo chown www-data -R /var/www/html/ 2> >(tee -a debug.log >&2)
					sudo chmod 777 -R /var/www/html/ 2> >(tee -a debug.log >&2)

				#Restore User Values
						echo "Restore user variables" >>debug.log	
					echo -e "\e[32mRestoring your personal settings\e[0m"
					sleep 2
					mv /home/pinodedoge/bootstatus_retain.sh /home/pinodedoge/bootstatus.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/current-ver-doge_retain.sh /home/pinodedoge/current-ver.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/current-ver-pi_retain.sh /home/pinodedoge/current-ver-pi.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/error_retain.log /home/pinodedoge/error.log 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/in-peers_retain.sh /home/pinodedoge/in-peers.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/limit-rate-down_retain.sh /home/pinodedoge/limit-rate-down.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/limit-rate-up_retain.sh /home/pinodedoge/limit-rate-up.sh 2> >(tee -a debug.log >&2)
					mv /home/pinodedoge/out-peers_retain.sh /home/pinodedoge/out-peers.sh 2> >(tee -a debug.log >&2)

					echo -e "\e[32mUser configuration restored\e[0m"
					
				##Set Swappiness lower
						echo "Set swappiness" >>debug.log
					echo -e "\e[32mDecreasing swappiness\e[0m"
					sleep 3				
					sudo sysctl vm.swappiness=10 2> >(tee -a debug.log >&2)
					echo -e "\e[32mSuccess\e[0m"
					sleep 3				

				##Update crontab
						echo "Update crontabs" >>debug.log
					echo -e "\e[32mUpdating crontab tasks\e[0m"
					sleep 3
					crontab /home/pinodedoge/pinode-doge/var/spool/cron/crontabs/pinodedoge 2> >(tee -a debug.log >&2)
					echo -e "\e[32mSuccess\e[0m"
					sleep 3
					
				#Update system version number to new one installed
				echo "Update PiNodeDOGE version number" >>debug.log
					wget https://raw.githubusercontent.com/shermand100/pinode-doge/Raspberry-Pi-OS/new-ver-pi.sh -O /home/pinodedoge/new-ver-pi.sh 2> >(tee -a debug.log >&2)
					chmod 755 /home/pinodedoge/new-ver-pi.sh 2> >(tee -a debug.log >&2)
					. /home/pinodedoge/new-ver-pi.sh 2> >(tee -a debug.log >&2)
					echo -e "\e[32mUpdate system version number\e[0m"
					echo "#!/bin/bash
CURRENT_VERSION_PI=$NEW_VERSION_PI" > /home/pinodedoge/current-ver-pi.sh 2> >(tee -a debug.log >&2)
					echo -e "\e[32mSuccess\e[0m"
					sleep 2
								
				#Clean up files
				echo "Cleanup leftover files" >>debug.log
					echo -e "\e[32mCleanup leftover directories\e[0m"
					sleep 2

					sudo rm -r /home/pinodedoge/pinode-doge/ 2> >(tee -a debug.log >&2)
					rm /home/pinodedoge/new-ver-pi.sh 2> >(tee -a debug.log >&2)
					echo -e "\e[32mSuccess\e[0m"
					sleep 2

				##End debug log
echo "
####################
" >>debug.log
echo "End update-pinodedoge.sh script $(date)" >>debug.log
echo "
####################
" >>debug.log
					
					whiptail --title "PiNode-DOGE Updater" --msgbox "\n\nYour PiNode-DOGE has been updated" 12 78
					


#Return to menu
./setup.sh
