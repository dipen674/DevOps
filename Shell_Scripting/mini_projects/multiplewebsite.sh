#!/bin/bash
echo
set -x
#sudo apt purge apache2 -y
#sudo apt autoremove -y
if [ -f /var/run/apache2/apache2.pid ]; then
        echo "Apache 2 is installed and is running state"
else
        echo "Not Installed"
        sudo apt install -y apache2
        echo "Service installed"
        sudo systemctl start apache2
        echo "Service Started"
        sudo systemctl enable apache2
        echo "service enabled"
fi



sudo mkdir -p /srv/www


#for waso_strategy
wget https://www.tooplate.com/zip-templates/2130_waso_strategy.zip

unzip 2130_waso_strategy.zip

sudo cp -r /home/dipen/shell_scripting/2130_waso_strategy /srv/www/

sudo chown -R www-data:www-data /srv/www/2130_waso_strategy

sudo tee /etc/apache2/sites-available/wasostrategy.conf <<EOF
        <VirtualHost *:80>
	ServerName waso.local
          DocumentRoot /srv/www/2130_waso_strategy
          <Directory /srv/www/2130_waso_strategy>
              Options Indexes FollowSymLinks
              AllowOverride All
              Require all granted
          </Directory>
        </VirtualHost>
EOF

#for another website
wget https://www.tooplate.com/zip-templates/2119_gymso_fitness.zip
unzip 2119_gymso_fitness.zip
sudo cp -r /home/dipen/shell_scripting/2119_gymso_fitness /srv/www/
sudo chown -R www-data:www-data /srv/www/2119_gymso_fitness
sudo tee /etc/apache2/sites-available/gymsofitness.conf <<EOF
        <VirtualHost *:80>
	ServerName gymso.local
	DocumentRoot /srv/www/2119_gymso_fitness
          <Directory /srv/www/2119_gymso_fitness>
              Options Indexes FollowSymLinks
              AllowOverride All
		Require all granted
          </Directory>
        </VirtualHost>
EOF




sudo a2ensite wasostrategy
sudo a2ensite gymsofitness
sudo systemctl reload apache2

sudo a2enmod rewrite

sudo systemctl restart apache2

sudo a2dissite 000-default
sudo systemctl reload apache2


cd /home/dipen/shell_scripting


rm -r 2130_waso_strategy 2130_waso_strategy.zip


rm -r 2119_gymso_fitness.zip 2119_gymso_fitness


if ! grep "waso.local" /etc/hosts; then
    echo "Adding waso.local to /etc/hosts"
     echo "127.0.0.1 waso.local" | sudo tee -a /etc/hosts
fi


if ! grep -q "gymso.local" /etc/hosts; then
    echo "Adding gymso.local to /etc/hosts"
    echo "127.0.0.1 gymso.local" | sudo tee -a /etc/hosts
fi
