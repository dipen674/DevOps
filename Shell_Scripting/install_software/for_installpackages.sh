#!/bin/sh


pkgs="wget curl git apache2"
for x in $pkgs
do
	echo "Installing package $x"
	sudo apt update
	sleep 3s
done

