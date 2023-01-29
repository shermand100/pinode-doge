#!/bin/bash
#Download

ARCH=$(uname -m)

if [ "$ARCH" = "armv7l" ]; then
  echo -e "\e[32mThis is ARMv7 architecture.\e[0m"
  ##Get DOGECOIN
	echo "Download Dogecoin ARM package" >>debug.log
#Download
wget https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-arm-linux-gnueabihf.tar.gz
#Unpack
tar -zxvf dogecoin-1.14.6-arm-linux-gnueabihf.tar.gz
#For consistancy between versions, rename directory
mv ~/dogecoin-1.14.6 ~/dogecoin
#Delete obsolete package
rm dogecoin-1.14.6-arm-linux-gnueabihf.tar.gz
else
  echo -e "\e[32mThis is aarch64 architecture.\e[0m"
  ##Get DOGECOIN
	echo "Download Dogecoin aarch64 package" >>debug.log
#Download
wget https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-aarch64-linux-gnu.tar.gz
#Unpack
tar -zxvf dogecoin-1.14.6-aarch64-linux-gnu.tar.gz
#For consistancy between versions, rename directory
mv ~/dogecoin-1.14.6 ~/dogecoin
#Delete obsolete package
rm dogecoin-1.14.6-aarch64-linux-gnu.tar.gz
fi
sleep 3
