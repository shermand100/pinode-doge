#!/bin/bash
#Load boot status - has node run before
. /home/pinodedoge/bootstatus.sh

if [ $BOOT_STATUS -lt 1 ]
then
	sudo raspi-config --expand-rootfs
	sleep "120"
	echo "#!/bin/sh
BOOT_STATUS=2" > /home/pinodedoge/bootstatus.sh
	sleep "2"
	sudo reboot
	
else
. /home/pinodedoge/df-h.sh
. /home/pinodedoge/init.sh	
fi


