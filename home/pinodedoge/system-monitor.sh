#!/bin/sh

(
	echo -n "This report generated " & date;
	echo -n "Status Fetcher: " && sudo systemctl status statusOutputs.service | sed -n '3'p | cut -c11-;
	echo -n "Dogecoin Node: " && sudo systemctl status dogecoind-start.service | sed -n '3'p | cut -c11-;
	) > /var/www/html/iamrunning_version.txt