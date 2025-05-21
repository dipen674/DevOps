#!/bin/bash
sudo mkdir -p /srv/www
echo "Dir created"

sudo chown www-data: /srv/www
echo "Ownership change"
sleep 2s

curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
echo "Word press is downloaded successfully and files are places in /srv/www"
