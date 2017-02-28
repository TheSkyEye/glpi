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
#mysql -u root -p
#GRANT all privileges ON glpi.* TO glpi@localhost IDENTIFIED BY 'glpi';
#glpi/glpi for the administrator account
