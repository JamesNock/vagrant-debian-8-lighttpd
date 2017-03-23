#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='password'
PROJECTFOLDER='/var/www/html/'

# create project folder
if [ ! -d "${PROJECTFOLDER}" ]; then
sudo mkdir "${PROJECTFOLDER}"
fi

# add extra sources so that we can get php 7 - only needed first-time box is built
sudo echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
sudo echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
sudo wget https://www.dotdeb.org/dotdeb.gpg
sudo apt-key add dotdeb.gpg
# cat /etc/apt/sources.list

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install apache 2.5 and php 5.5
#sudo apt-get install -y apache2
sudo apt-get install -y lighttpd
sudo apt-get install -y php7.0

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
sudo apt-get install php7.0-mysql

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

# install curl
sudo apt-get -y install curl

# setup hosts file
# VHOST=$(cat <<EOF
# <VirtualHost *:80>
#     DocumentRoot "${PROJECTFOLDER}"
#     <Directory "${PROJECTFOLDER}">
#         AllowOverride All
#         Require all granted
#     </Directory>
# </VirtualHost>
# EOF
# )
# echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
# sudo a2enmod rewrite

# restart apache
# service apache2 restart

# install git
sudo apt-get -y install git

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer