#!/bin/bash
apt-get install -y php5-imap php5-ldap php5-curl php5-mysql mysql-server mysql-client
wget --no-check-certificate https://github.com/glpi-project/glpi/releases/download/9.1.2/glpi-9.1.2.tgz
tar xvf glpi-9.1.2.tgz
mv glpi /var/www/
chmod -R 777 /var/www/glpi/
/etc/init.d/apache2 reload
