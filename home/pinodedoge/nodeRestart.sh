#!/bin/bash
	#This works by commanding Dogecoind to safely stop outside of the scope of systemd. Systemd should see it as a crash and so reboot the Dogecoid service after 30 seconds.
#Restart Dogecoind
cd /home/pinodedoge/dogecoin/bin/dogecoin-cli stop
