#!/bin/bash
#Download

ARCH=$(uname -m)

if [ "$ARCH" = "armv7l" ]; then
  echo -e "\e[32mThis is ARMv7 architecture.\e[0m"
  ##Get DOGECOIN
        echo "Download Dogecoin ARM package" >>debug.log
#Download
wget https://github.com/dogecoin/dogecoin/releases/download/v1.14.8/dogecoin-1.14.8-arm-linux-gnueabihf.tar.gz
#Unpack
tar -zxvf dogecoin-1.14.8-arm-linux-gnueabihf.tar.gz

#For consistancy between versions, remove previous and rename directory
rm -rf dogecoin
mv ~/dogecoin-1.14.8 ~/dogecoin
#Delete obsolete package
rm dogecoin-1.14.8-arm-linux-gnueabihf.tar.gz
else
  echo -e "\e[32mThis is aarch64 architecture.\e[0m"
  ##Get DOGECOIN
        echo "Download Dogecoin aarch64 package" >>debug.log
#Download
wget https://github.com/dogecoin/dogecoin/releases/download/v1.14.8/dogecoin-1.14.8-aarch64-linux-gnu.tar.gz
#Unpack
tar -zxvf dogecoin-1.14.8-aarch64-linux-gnu.tar.gz
#For consistancy between versions, rename directory
rm -rf dogecoin
mv ~/dogecoin-1.14.8 ~/dogecoin
#Delete obsolete package
rm dogecoin-1.14.8-aarch64-linux-gnu.tar.gz
fi
sleep 3

#Reboot the system

echo -e "\e[32mYour System will now Reboot...\e[0m"
sudo reboot now
