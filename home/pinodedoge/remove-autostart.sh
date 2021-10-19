#!/bin/sh
#On stopping node, revert "boot status" to mode 2. This allows the status script to return prints of --system idle--.
	echo "#!/bin/sh
BOOT_STATUS=2" > /home/pinodedoge/bootstatus.sh
