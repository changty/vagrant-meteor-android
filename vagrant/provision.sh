#!/usr/bin/env bash


ANDROID_SDK_FILENAME=android-sdk_r24.2-linux.tgz
ANDROID_SDK=http://dl.google.com/android/$ANDROID_SDK_FILENAME

echo "Updating"
sudo apt-get update

echo "Install utils"
sudo apt-get install -y git-core git zip unzip lib32stdc++6 lib32z1

# echo "Installing Packages"
# sudo apt-get install -y git-core php5 php5-cgi zip unzip nginx php5-fpm

# echo "Setting up nginx"
# sudo rm /etc/nginx/sites-enabled/default >> /dev/null
# sudo cp /vagrant/vagrant/codiad.conf /etc/nginx/sites-enabled/codiad
# sudo cp /vagrant/vagrant/www.conf /etc/php5/fpm/pool.d/

# if [ ! -d "/var/www" ]; then
#     echo "Making /var/www"
#     sudo mkdir /var/www
# else
#     echo "/var/www already exists"
# fi

# if [ ! -d "/var/www/codiad" ]; then
#     echo "Cloning Codiad"
#     git clone https://github.com/Codiad/Codiad.git /var/www/codiad
# else
#     echo "/var/www/codiad already exists. Ignoring."
# fi


# echo "Setting Codiad permissions to www-data:www-data"
# sudo chown -R www-data:www-data /var/www/codiad
# sudo chown -R www-data:www-data /var/www/codiad

# sudo chown -R www-data:www-data /vagrant/www/codiad/wor
# sudo chown www-data:www-data /var/run/php5-fpm.sock

# echo "Restarting nginx and php5-fpm"
# sudo service nginx restart
# sudo service php5-fpm restart

echo "Install mongodb"
sudo echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
export LC_ALL=C

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

# sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
sudo apt-get update
sudo apt-get install --yes openjdk-7-jdk ant expect


curl -O $ANDROID_SDK
tar -xzvf $ANDROID_SDK_FILENAME
sudo chown -R vagrant android-sdk-linux/


echo "ANDROID_HOME=~/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /home/vagrant/.bashrc
echo "PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/vagrant/.bashrc

expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all --filter platform-tool,android-22,build-tools-22.0.1
expect { 
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'
sudo chown root:vagrant /home/vagrant/android-sdk-linux/platform-tools/adb
sudo chmod 4550 /home/vagrant/android-sdk-linux/platform-tools/adb

# sudo apt-get install -y ubuntu-make
# umake android


#Meteor conf
# run this command before starting meteor 
# =========================================================
# export MONGO_URL=mongodb://localhost:27017/dbname
# =========================================================

echo "Complete."
