#!/usr/bin/env bash

echo "Updating"
sudo apt-get update

echo "Installing Packages"
sudo apt-get install -y git-core php5-dev zip unzip nginx php5-fpm

echo "Setting up nginx"
sudo rm /etc/nginx/sites-enabled/default >> /dev/null
sudo cp /vagrant/vagrant/codiad.conf /etc/nginx/sites-enabled/codiad

if [ ! -d "/var/www" ]; then
    echo "Making /var/www"
    sudo mkdir /var/www
else
    echo "/var/www already exists"
fi

if [ ! -d "/var/www/codiad" ]; then
    echo "Cloning Codiad"
    git clone https://github.com/Codiad/Codiad.git /var/www/codiad
else
    echo "/var/www/codiad already exists. Ignoring."
fi


echo "Setting Codiad permissions to www-data:www-data"
sudo chown -R www-data:www-data /var/www/codiad

echo "Restarting nginx and php5-fpm"
sudo service nginx restart
sudo service php5-fpm restart

echo "Complete."
