#!/bin/bash
apt-get install -y apache2 php5 php5-imap php5-ldap php5-curl php5-mysql mysql-server mysql-client
wget --no-check-certificate https://github.com/glpi-project/glpi/releases/download/9.1.2/glpi-9.1.2.tgz
tar xvf glpi-9.1.2.tgz
mv glpi /var/www/
chmod -R 777 /var/www/glpi/
touch /etc/apache2/sites-available/glpi
echo '<VirtualHost *:80>
  ServerName glpi.domaine.fr
  DocumentRoot /var/www/glpi/
 <Directory /var/www/glpi>
        AllowOverride All
        Order allow,deny
        Options Indexes
        Allow from all
 </Directory>
</VirtualHost>' >> /etc/apache2/sites-available/glpi
a2ensite glpi
chown -R www-data:www-data /var/www/glpi
/etc/init.d/apache2 reload
#mysql -u root -p
#GRANT all privileges ON glpi.* TO glpi@localhost IDENTIFIED BY 'glpi';
