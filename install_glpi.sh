#!/bin/bash
apt-get install -y apache2 php5 libapache2-mod-php5 php5-mysql php5-imap php5-ldap php5-curl mysql-server mysql-client
cd /var/www/html
wget --no-check-certificate https://github.com/glpi-project/glpi/releases/download/9.1.2/glpi-9.1.2.tgz
tar xvf glpi-9.1.2.tgz
chown -R www-data:www-data /var/www/html/glpi/
chmod -R 777 /var/www/html/glpi/
touch /etc/apache2/sites-available/glpi.conf
echo '<VirtualHost *:80>
  ServerName localhost
  DocumentRoot /var/www/html/glpi/
 <Directory /var/www/html/glpi>
        AllowOverride All
        Order allow,deny
        Options Indexes
        Allow from all
 </Directory>
</VirtualHost>' >> /etc/apache2/sites-available/glpi.conf
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

wget --no-check-certificate https://forge.glpi-project.org/attachments/download/2179/GLPI-dashboard_plugin-0.8.2.tar.gz
tar xzf GLPI-dashboard_plugin-0.8.2.tar.gz
mv dashboard/ /var/www/html/glpi/plugins/
wget --no-check-certificate https://github-cloud.s3.amazonaws.com/releases/39893877/82383e1a-03e7-11e7-8b54-c8a7f9f2a8b1.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAISTNZFOVBIJMK3TQ%2F20170402%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20170402T012840Z&X-Amz-Expires=300&X-Amz-Signature=e3b7f1b059c56f10848675c628bbb6237fcfb3e4c695c1d64ba607cf2743e031&X-Amz-SignedHeaders=host&actor_id=22552177&response-content-disposition=attachment%3B%20filename%3Dglpi-ocsinventoryng-1.3.3.tar.gz&response-content-type=application%2Foctet-stream
tar xzf glpi-ocsinventoryng-1.3.3.tar.gz
mv ocsinventoryng/ /var/www/html/glpi/plugins/
