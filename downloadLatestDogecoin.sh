#!/bin/bash
#Download
wget https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-arm-linux-gnueabihf.tar.gz
#Unpack
tar -zxvf dogecoin-1.14.6-arm-linux-gnueabihf.tar.gz
#For consistancy between versions, rename directory
mv ~/dogecoin-1.14.6 ~/dogecoin
#Delete obsolete package
rm dogecoin-1.14.6-arm-linux-gnueabihf.tar.gz
