#!/bin/bash

echo "PiNode-DOGE is checking for available updates"
sleep "1"
#Download update file
sleep "1"
wget -q https://raw.githubusercontent.com/shermand100/pinode-doge/main/new-ver-doge.sh -O /home/pinodedoge/doge-new-ver.sh
echo "Version Info file received:"
#Permission Setting
chmod 755 /home/pinodedoge/current-ver-doge.sh
chmod 755 /home/pinodedoge/doge-new-ver.sh
#Load boot status - what condition was node last run
. /home/pinodedoge/bootstatus.sh
#Load Variables
. /home/pinodedoge/current-ver-doge.sh
. /home/pinodedoge/doge-new-ver.sh
echo $NEW_VERSION 'New Version'
echo $CURRENT_VERSION 'Current Version'
sleep "3"
	if [ $CURRENT_VERSION -lt $NEW_VERSION ]
		then
		echo -e "\e[32mSystem will now install the latest available of Dogecoin. \e[0m"
		sleep "2"
		echo "Dogecoind stop command sent, allowing up to 2 minutes for safe shutdown"		
		sudo systemctl stop dogecoind-start.service
		sleep "5"
		echo "Deleting Old Version"
		rm -rf /home/pinodedoge/dogecoin
		sleep "2"
##Get DOGECOIN
	echo "Download Dogecoin ARM package" >>debug.log
	echo -e "\e[32mDownload Dogecoin ARM package...\e[0m"
	wget -O - https://raw.githubusercontent.com/shermand100/pinode-doge/main/downloadLatestDoegcoin.sh | bash
		
		sleep 2
		if [ $BOOT_STATUS -eq 2 ]
then
		echo "Update complete, Node ready for start. See web-ui at $(hostname -I) to select mode."
else
		echo "Update complete"
		echo "Resuming Node"
		sudo systemctl start dogecoind-start.service
fi
		#Update system version number
		echo "#!/bin/bash
		CURRENT_VERSION=$NEW_VERSION" > /home/pinodedoge/current-ver-doge.sh
		#Remove downloaded version check files
		rm /home/pinodedoge/doge-new-ver.sh
		whiptail --title "PiNode-DOGE Dogecoin Update Complete" --msgbox "Your PiNode-DOGE has completed updating to the latest version of Dogecoin" 16 60
		sleep 3
else
				
		if (whiptail --title "PiNode-DOGE Dogecoin Update" --yesno "This device thinks it's running the latest version of Dogecoin (that has been tested with PiNode-DOGE).\n\nIf you think this is incorrect or require a clean Dogecoin install you may force an update below." --yes-button "Force Dogecoin Update" --no-button "Return to Main Menu"  14 78); then

		echo -e "\e[32mSystem will now install the latest available of Dogecoin. \e[0m"
		sleep "2"
		echo "Dogecoind stop command sent, allowing up to 2 minutes for safe shutdown"		
		sudo systemctl stop dogecoind-start.service
		sleep "5"
		echo "Deleting Old Version"
		rm -rf /home/pinodedoge/dogecoin
		sleep "2"
##Get DOGECOIN
	echo "Download Dogecoin ARM package" >>debug.log
	echo -e "\e[32mDownload Dogecoin ARM package...\e[0m"
	wget -O - https://raw.githubusercontent.com/shermand100/pinode-doge/main/downloadLatestDoegcoin.sh | bash
		
		if [ $BOOT_STATUS -eq 2 ]
then
		echo "Update complete, Node ready for start. See web-ui at $(hostname -I) to select mode."
else
		echo "Update complete"
		echo "Resuming Node"
		sudo systemctl start dogecoind-start.service
fi

		#Update system version number
		echo "#!/bin/bash
		CURRENT_VERSION=$NEW_VERSION" > /home/pinodedoge/current-ver-doge.sh
		#Remove downloaded version check files
		rm /home/pinodedoge/doge-new-ver.sh
		whiptail --title "PiNode-DOGE Dogecoin Update Complete" --msgbox "Your PiNode-DOGE has completed updating to the latest version of Dogecoin" 16 60
		sleep 3
									else
										rm /home/pinodedoge/doge-new-ver.sh
									whiptail --title "PiNode-DOGE Dogecoin Update" --msgbox "Returning to Main Menu. No changes have been made." 12 78;
									. /home/pinodedoge/setup.sh
									fi

fi
./setup.sh
