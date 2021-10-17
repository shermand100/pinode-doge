#!/bin/bash
#Output the currently running state
	echo "#!/bin/sh
BOOT_STATUS=3" > /home/pinodedoge/bootstatus.sh
#Start Dogecoind
cd /home/pinodedoge/dogecoin/bin/
./dogecoind -daemon