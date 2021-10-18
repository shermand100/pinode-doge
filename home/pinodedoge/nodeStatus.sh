#!/bin/sh

# use temp file 
_temp="./dialog.$$"


#Define status functions

	#Sync status
	syncStatus () {
	
	#Load boot status - what condition was node last run
	. /home/pinodedoge/bootstatus.sh

	if [ $BOOT_STATUS -eq 2 ]
then	
		#System Idle
		echo "--System Idle-- 
		Select start on the 'Node Control' page. Then allow at least 5 minutes for stats to appear here. "  > /var/www/html/Node_Status.txt
fi	
	
	
	if [ $BOOT_STATUS -eq 3 ]
then	
		#Node Status
		NODE_STATUS="$(dogecoin/bin/dogecoin-cli getblockchaininfo | jq -Mr {"Network:.chain, Current_Block_height:.blocks, Sync_Progress_percent:((.verificationprogress)*100+0.0001|floor), Initial_block_download:.initialblockdownload, Approx_Size_on_Disk_GB:((.size_on_disk)/10000000|floor/100.0)"} | tr -d '{}"')" && echo "$NODE_STATUS"> /var/www/html/Node_Status.txt
		#Time stamps added temporarily to better identify most recent stats, (not frozen/old data from browser cache).
				date >> /var/www/html/Node_Status.txt
fi
		sleep 20
	}

	#connectionStatus function
	connectionStatus () {

	#Load boot status - what condition was node last run
	. /home/pinodedoge/bootstatus.sh

	if [ $BOOT_STATUS -eq 2 ]
then	
		#System Idle
		echo "--System Idle--" > /var/www/html/print_cn.txt
fi	
	
	
	if [ $BOOT_STATUS -eq 3 ]
then	
		#Connection Status
	PRINT_CN="$(dogecoin/bin/dogecoin-cli getnetworkinfo | jq -Mr {"This_Node_Running_Version:.subversion, Connected_Peer_Count:.connections, Available_Networks:.networks"} | tr -d '{}"')" && echo "$PRINT_CN" > /var/www/html/print_cn.txt
	date >> /var/www/html/print_cn.txt
fi	

		sleep 20
	}

	#txPoolStatus
	txPoolStatus () {

	#Load boot status - what condition was node last run
	. /home/pinodedoge/bootstatus.sh

	if [ $BOOT_STATUS -eq 2 ]
then	
		#System Idle
		echo "--System Idle--" > /var/www/html/TXPool_Status.txt
fi	
	
	if [ $BOOT_STATUS -eq 3 ]
then	
		#Node Status
		PRINT_POOL_STATS="$(dogecoin/bin/dogecoin-cli getmempoolinfo | jq -Mr {"TXs_in_Pool:.size, Pool_Size_Bytes:.bytes, Max_Pool_Size_MB:((.maxmempool)/10000000) "} | tr -d '{}"')" && echo "$PRINT_POOL_STATS" > /var/www/html/TXPool_Status.txt
		date >> /var/www/html/TXPool_Status.txt
fi	


		sleep 20
	}

	#txPoolPending
	txPoolPending () {

	#Load boot status - what condition was node last run
	. /home/pinodedoge/bootstatus.sh

			if [ $BOOT_STATUS -eq 2 ]
then	
		#System Idle
		echo "--System Idle--" > /var/www/html/TXPool-short_Status.txt
fi	
	
	if [ $BOOT_STATUS -eq 3 ]
then	
		#Node Status
		PRINT_TX_SHORT="$(dogecoin/bin/dogecoin-cli getrawmempool | tr -d '{}[]"')" && echo "$PRINT_TX_SHORT" > /var/www/html/TXPool-short_Status.txt
		date >> /var/www/html/TXPool-short_Status.txt
fi	


		sleep 20
	}

	#networkData
	networkData () {

	#Load boot status - what condition was node last run
	. /home/pinodedoge/bootstatus.sh

			if [ $BOOT_STATUS -eq 2 ]
then	
		#System Idle
		echo "--System Idle--" > /var/www/html/print_pl.txt
fi	
	
	if [ $BOOT_STATUS -eq 3 ]
then	
		#NetworkData
		networkData="$(dogecoin/bin/dogecoin-cli getpeerinfo | jq -Mr '.[] | {Connected_Peer_id:.id, Connected_Peer_IP:.addr, RelayTXs:.relaytxes, Bytes_Sent:.bytessent, Bytes_Received:.bytesrecv, Inbound_Connection:.inbound, Connection_Time:((.conntime) | strftime("%Y-%m-%d %H:%M:%S LOCAL"))}' | tr -d '{}"')" && echo "$networkData" > /var/www/html/print_pl.txt
		date >> /var/www/html/print_pl.txt
fi	

		sleep 20
	}	

#Call status functions and loop indefinately:
while true; do
syncStatus
connectionStatus
txPoolStatus
txPoolPending
networkData
done