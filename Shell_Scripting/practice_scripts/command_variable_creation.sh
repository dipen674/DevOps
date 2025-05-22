#!/bin/bash
#set -x
#To create a command subtitute variable:
#the command should be written in `Between these slash ` or we can alos write command using $(We can also write command here)
echo
ipadd=`ip -4 addr show`
echo $ipadd
echo
echo
ip=$(hostname -I | awk -F " " '{print $1}')
echo $ip
disk=`df -h`
echo $disk
diskusage=`du -sh *`
echo $diskusage
echo
echo
echo 
apachestatus=`cat /var/log/dpkg.log | grep apache2-data`
sleep 5s
echo $apachestatus
