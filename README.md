![PiNode-DOGE logo](https://github.com/shermand100/pinode-doge/blob/main/Images/pinode-doge-banner.png)

# Quick Start Guide v0.10.21

### This page will give a quick overview to get you started. A complete and comprehensive manual will be added to the Wiki later

# Project Overview

PiNode-DOGE is a completely free and open source suite of tools to help a user run their own Dogecoin node with ease. PiNode-DOGE is designed for use with single board computers (SBC) such as the Raspberry Pi, and later the Pine64 or Odroid hardware to allow for very cheap node setup and minimal 24/7 running costs due to low power usage.

After setup, normal interaction is available through a built in web interface accessible from any device on your local network.

## Hardware

[See this project wiki page for info on supported hardware](https://github.com/shermand100/pinode-doge/wiki/Hardware)

## One-line Install
### Raspberry Pi OS (Raspian)
Flash your storage media with Raspberry Pi OS (lite) 32 or 64 Bit in your normal way. SSH into your fresh Pi, then it's as simple as running the one line below.

`wget -O - https://raw.githubusercontent.com/shermand100/pinode-doge/main/Install-PiNode-DOGE.sh | bash`

Once installed you can interact with your node via the Web-UI from another device on the same network at http://pinodedoge.local or http://device-ip-of-node

*Did you know the Raspberry models Pi3 and above support boot from USB? Thats right, no more need for slow MicroSD, flash your OS straight to USB storage for USB3 speeds!
https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#usb-mass-storage-boot

### Armbian Ubuntu Jammy
Flash your storage media with [Armbian Ubuntu Jammy for your device](https://www.armbian.com/download/) (lite if available) in your normal way. SSH into your device as `root` with password `1234`. Create user `pinodedoge` but remain logged in as `root` Then run the one line below:

`wget -O - https://raw.githubusercontent.com/shermand100/pinode-doge/main/Install-PiNode-DOGE.sh | bash`

Once installed you can interact with your node via the Web-UI from another device on the same network at http://pinodedoge.local or http://device-ip-of-node

For best performance consider booting your device from USB rather than MicroSD cards.

## Screenshots:
---
### Index

Home landing page

![PiNode-DOGE Index](https://github.com/shermand100/pinode-doge/blob/main/Images/screenshots/index.png)
---
### Node Status

Node service status, sync status, connections, mempool and network. Some basic hardware (storage, memory and CPU temp) shown.

![PiNode-DOGE Status](https://github.com/shermand100/pinode-doge/blob/main/Images/screenshots/nodeStatus.png)
---
### Node Control Page

Start/Stop/Restart your node. System shutdown and control of your additional 2GB Swap memory for older devices.

![PiNode-DOGE Control](https://github.com/shermand100/pinode-doge/blob/main/Images/screenshots/nodeControl.png)
---
### Node Log

The debug.log of dogecoind to help diagnose any issues.

![PiNode-DOGE Log](https://github.com/shermand100/pinode-doge/blob/main/Images/screenshots/log.png)
---
#### Development Donation
DJbZLqmCEZejQBoTfg6faYrXPQ9BhLNEjd
