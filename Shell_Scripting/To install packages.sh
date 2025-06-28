#!/bin/bash
set -x           #To see step by step what is happening
set -e            #Exit whenever script runs into a problem
sudo apt purge apache2 -y
sudo apt autoremove -y
if [ -f /var/run/apache2/apache2.pid ];then 
#-f is to check the availability of the file
   echo "Already installed"
else
   echo "Not installed"
   sudo apt install -y apache2
   sudo systemctl start apache2
   sudo systemctl enable apache2
fi