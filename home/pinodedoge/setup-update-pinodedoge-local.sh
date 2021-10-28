#!/bin/bash


wget https://raw.githubusercontent.com/shermand100/pinode-doge/main/new-ver-pi.sh -O /home/pinodedoge/new-ver-pi.sh


#Permission Setting
chmod 755 /home/pinodedoge/current-ver-pi.sh
chmod 755 /home/pinodedoge/new-ver-pi.sh
#Load Variables
. /home/pinodedoge/current-ver-pi.sh
. /home/pinodedoge/new-ver-pi.sh
echo "Version Info file received:"
echo "Current Version: $CURRENT_VERSION_PI "
echo "Latest Version: $NEW_VERSION_PI "

sleep "3"
	if [ $CURRENT_VERSION_PI -lt $NEW_VERSION_PI ]; then
					if (whiptail --title "PiNode-DOGE Updater" --yesno "An update has been found for your PiNode-DOGE. To continue will install it now.\n\nWould you like to Continue?" 12 78); then
					
	wget -O - https://raw.githubusercontent.com/shermand100/pinode-doge/Armbian-Debian/update-pinodedoge.sh | bash

					else
					rm /home/pinodedoge/new-ver-pi.sh
					. /home/pinodedoge/setup.sh
					fi

else
		if (whiptail --title "PiNode-DOGE Update" --yesno "This device thinks it's running the latest version of PiNode-DOGE.\n\nIf you think this is incorrect you may force an update below.\n\n*Note that a force update can also be used as a reset tool if you think your version is not functioning properly" --yes-button "Force PiNode-DOGE Update" --no-button "Return to Main Menu"  14 78); then

	wget -O - https://raw.githubusercontent.com/shermand100/pinode-doge/Armbian-Debian/update-pinodedoge.sh | bash
		
									else
									whiptail --title "PiNode-DOGE Update" --msgbox "Returning to Main Menu. No changes have been made." 12 78;
									rm /home/pinodedoge/new-ver-pi.sh
									. /home/pinodedoge/setup.sh
									fi
	fi
	
#clean up
rm /home/pinodedoge/new-ver-pi.sh
#Return to menu
./setup.sh