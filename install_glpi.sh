#!/bin/bash
apt-get install -y apache2 php5 libapache2-mod-php5 php5-mysql php5-gdphp5 php5-imap php5-ldap php5-curl mysql-server mysql-client
wget --no-check-certificate https://github.com/glpi-project/glpi/releases/download/9.1.2/glpi-9.1.2.tgz
tar xvf glpi-9.1.2.tgz
mv glpi /var/www/
chown -R www-data:www-data glpi/
chmod -R 777 /var/www/glpi/
touch /etc/apache2/sites-available/glpi
echo '<VirtualHost *:80>
  ServerName localhost
  DocumentRoot /var/www/glpi/
 <Directory /var/www/glpi>
        AllowOverride All
        Order allow,deny
        Options Indexes
        Allow from all
 </Directory>
</VirtualHost>' >> /etc/apache2/sites-available/glpi
a2ensite glpi
/etc/init.d/apache2 reload

read -p "Enter your MySQL root password: " rootpass
read -p "Database name: " dbname
read -p "Database username: " dbuser
read -p "Enter a password for user $dbuser: " userpass
echo "CREATE DATABASE $dbname;" | mysql -u root -p$rootpass
echo "CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$userpass';" | mysql -u root -p$rootpass
echo "GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost';" | mysql -u root -p$rootpass
echo "FLUSH PRIVILEGES;" | mysql -u root -p$rootpass
echo "New MySQL database is successfully created"
