#!/usr/bin/env bash

echo "Updating"
sudo apt-get update

echo "Installing Packages"
sudo apt-get install -y git-core php5 php5-cgi zip unzip nginx php5-fpm

echo "Setting up nginx"
sudo rm /etc/nginx/sites-enabled/default >> /dev/null
sudo cp /vagrant/vagrant/codiad.conf /etc/nginx/sites-enabled/codiad
sudo cp /vagrant/vagrant/www.conf /etc/php5/fpm/pool.d/

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
sudo chown -R www-data:www-data /vagrant
sudo chown www-data:www-data /var/run/php5-fpm.sock

echo "Restarting nginx and php5-fpm"
sudo service nginx restart
sudo service php5-fpm restart

echo "Installmongodb"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install mongodb-org

echo "Install node"
sudo apt-get install -y npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable

echo "Install git"
sudo apt-get install -y git

echo "Install bower"
sudo npm install -g bower

echo "Install grunt"
sudo npm install -g grunt-cli

echo "Install meteor"
curl https://install.meteor.com/ | sh

#Meteor conf
# run this command before starting meteor 
# =========================================================
# export MONGO_URL=mongodb://localhost:27017/dbname
# =========================================================

echo "Complete."
