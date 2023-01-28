#!/bin/bash
##To run me on cmd line wget -O - https://raw.githubusercontent.com/shermand100/pinode-doge/main/Install-PiNode-DOGE.sh | bash
echo -e "\e[32mPreparing Menu...\e[0m"
sleep 2
#Check user has whiptail - required to display menu
sudo apt-get install whiptail -y

CHOICE=$(
whiptail --title "Welcome to the PiNode-DOGE Project" --menu "For correct installation select your OS" 20 60 5 \
	"1)" "Raspberry Pi OS" \
	"2)" "Armbian Debian Bullseye" \
	"3)" "Exit"  3>&2 2>&1 1>&3
)

case $CHOICE in
	"1)")
		#Commands for Raspberry Pi OS
		echo -e "\e[32mDownloading data for install\e[0m"
		sleep 3
		wget https://raw.githubusercontent.com/shermand100/pinode-doge/Raspberry-Pi-OS/installPart1.sh
		echo -e "\e[32mPiNode-DOGE RaspbianRaspberry Pi OS configuration file received\e[0m"
		echo -e "\e[32mStarting Installation\e[0m"
		sudo chmod 755 /home/pi/installPart1.sh
		sleep 2
		./installPart1.sh
		exit 1
		;;

	"2)")   
		#Commands for Armbian Jammy (latest)
		echo -e "\e[32mDownloading data for install\e[0m"
		sleep 3
		wget https://raw.githubusercontent.com/shermand100/pinode-doge/Armbian-Debian/installPart1.sh
		echo -e "\e[32mPiNode-DOGE Armbian Debian Bullseye OS configuration file received\e[0m"
		echo -e "\e[32mStarting Installation\e[0m"
		sudo chmod 755 ~/installPart1.sh
		sleep 2
		./installPart1.sh
		exit 1
    	;;	

	"3)") exit
        ;;
esac
exit
