#!/usr/bin/env bash


ANDROID_SDK_FILENAME=android-sdk_r24.2-linux.tgz
ANDROID_SDK=http://dl.google.com/android/$ANDROID_SDK_FILENAME
MONGODB_NAME=dbname


echo "Updating"
sudo apt-get update

echo "Install utils"
sudo apt-get install -y git-core git zip unzip lib32stdc++6 lib32z1 openjdk-7-jdk ant expect

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

echo "Install Android SDK"
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
sudo chown -R vagrant ~/.android

echo "export MONGO_URL=mongodb://localhost:27017/$MONGODB_NAME" >> /home/vagrant/.bashrc

#Meteor conf
# run this command before starting meteor 
# =========================================================
# export MONGO_URL=mongodb://localhost:27017/dbname
# =========================================================

echo "Complete."
