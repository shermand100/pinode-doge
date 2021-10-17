#!/bin/sh

#Dependencies
sudo apt-get install udftools coreutils vim-common -y 

TITLE=$(lsblk --nodeps | sed -n 1p)
LINE1=$(lsblk --nodeps | sed -n 2p)
LINE2=$(lsblk --nodeps | sed -n 3p)
LINE3=$(lsblk --nodeps | sed -n 4p)
LINE4=$(lsblk --nodeps | sed -n 5p)
LINE5=$(lsblk --nodeps | sed -n 6p)
#whiptail --title "PiNode-DOGE Storage" --msgbox "$LSBLK" 10 78

	CHOICE=$(whiptail --backtitle "Storage Setup" --title "PiNode-DOGE Storage" --menu "\nSelect device for blockchain storage\n" 20 80 10 \
	"__" "$TITLE" \
	"1)" "$LINE1" \
    "2)" "$LINE2" \
	"3)" "$LINE3" \
	"4)" "$LINE4" \
	"5)" "$LINE5" 2>&1 >/dev/tty)
	
	case $CHOICE in
	
		"__") . /home/pinodedoge/setup-usb-select-device.sh
		;;
		
		"1)") DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 2p)
		echo "#!/bin/sh
DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 2p)" > /home/pinodedoge/setup-usb-path.sh
				sudo /home/pinodedoge/setup-usb.sh /dev/$DEVICE_TO_CONFIGURE DOGEBLOCKCHAIN
		;;
				
		"2)")DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 3p)
		echo "#!/bin/sh
DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 3p)" > /home/pinodedoge/setup-usb-path.sh
				sudo /home/pinodedoge/setup-usb.sh /dev/$DEVICE_TO_CONFIGURE DOGEBLOCKCHAIN
		;;
		
		"3)")DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 4p)
		echo "#!/bin/sh
DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 4p)" > /home/pinodedoge/setup-usb-path.sh
				sudo /home/pinodedoge/setup-usb.sh /dev/$DEVICE_TO_CONFIGURE DOGEBLOCKCHAIN
		;;
		
		"4)")DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 5p)
		echo "#!/bin/sh
DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 5p)" > /home/pinodedoge/setup-usb-path.sh
				sudo /home/pinodedoge/setup-usb.sh /dev/$DEVICE_TO_CONFIGURE DOGEBLOCKCHAIN
		;;

		"5)")DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 6p)
		echo "#!/bin/sh
DEVICE_TO_CONFIGURE=$(lsblk --nodeps -o name | sed -n 6p)" > /home/pinodedoge/setup-usb-path.sh
				sudo /home/pinodedoge/setup-usb.sh /dev/$DEVICE_TO_CONFIGURE DOGEBLOCKCHAIN
		;;
	esac
		./setup.sh
		exit 0
	