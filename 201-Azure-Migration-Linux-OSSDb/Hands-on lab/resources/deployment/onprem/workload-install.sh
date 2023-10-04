# https://phpipam.net/phpipam-installation-on-centos-7/


# username="demouser"
pwd="demo\!pass123"



### INSTALL PHPIPAM ###

echo "LC_ALL=en_US.utf-8" >> /etc/environment
echo "LANG=en_US.utf-8" >> /etc/environment

sudo yum install -y httpd mariadb-server php php-cli php-gd php-common php-ldap php-pdo php-pear php-snmp php-xml php-mbstring git
sudo yum install php-mysqlnd -y
sudo yum install php-gmp -y

# Update /etc/httpd/conf/httpd.conf
cd /etc/httpd/conf/
rm -f httpd.conf
wget https://raw.githubusercontent.com/microsoft/MCW-Building-the-business-migration-case-with-Linux-and-OSS-DB-to-Azure/main/Hands-on%20lab/resources/deployment/onprem/httpd.conf


# Start Apache
sudo systemctl start httpd
sudo systemctl enable httpd

sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --permanent --add-port=3306/tcp
sudo firewall-cmd --reload


# Install MySQL
sudo dnf install mysql-server --allowerasing -y

# Start MySQL
sudo systemctl start mysqld.service
sudo systemctl enable mysqld.service

echo "bind-address=*" | sudo tee --append /etc/my.cnf.d/mysql-server.cnf 
sudo systemctl restart mysqld.service

# Configure MySQL
# sudo yum install expect -y
# SECURE_MYSQL=$(expect -c "
# set timeout 10
# spawn mysql_secure_installation
# expect \"Enter current password for root (enter for none):\"
# send \"\r\"
# expect \"Switch to unix_socket authentication\"
# send \"n\r\"
# expect \"Change the root password?\"
# send \"n\r\"
# expect \"Remove anonymous users?\"
# send \"y\r\"
# expect \"Disallow root login remotely?\"
# send \"n\r\"
# expect \"Remove test database and access to it?\"
# send \"y\r\"
# expect \"Reload privilege tables now?\"
# send \"y\r\"
# expect eof
# ")

sudo mysql -uroot -e "CREATE DATABASE phpipam;"
sudo mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'demopass123';"
sudo mysql -uroot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'demopass123';"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON mysql.* TO 'root'@'%' WITH GRANT OPTION;"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON phpipam.* TO 'root'@'%' WITH GRANT OPTION;"
sudo mysql -uroot -e "FLUSH PRIVILEGES;"

#sudo mysql -uroot -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('demopass123');"
#sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* to 'root'@'%' IDENTIFIED BY 'demopass123' with grant option;"
## sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON mysql.* TO 'root'@'%' IDENTIFIED BY 'demopass123';"
#sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON phpipam.* TO 'root'@'%' IDENTIFIED BY 'demopass123'; FLUSH PRIVILEGES;"




# Install phpipam
# Download phpipam release
cd /var/www/html/
wget https://github.com/phpipam/phpipam/releases/download/v1.5.0/phpipam-v1.5.0.zip
unzip phpipam-v1.5.0.zip
mv ./phpipam/* ./
rm -rfv phpipam

sudo chown apache:apache -R /var/www/html/
sudo chcon -t httpd_sys_content_t /var/www/html/

cd /var/www/html/
find . -type f -exec chmod 0644 {} \;
find . -type d -exec chmod 0755 {} \;

sudo chcon -t httpd_sys_rw_content_t app/admin/import-export/upload/ -R
sudo chcon -t httpd_sys_rw_content_t app/subnets/import-subnet/upload/ -R
sudo chcon -t httpd_sys_rw_content_t css/images/logo/ -R

cp config.dist.php config.php
echo "\$allow_untested_php_versions=true;" >> /var/www/html/config.php

sudo sed -i "s/^\(\$db\['host'\]\s*=\s*\).*\$/\1'localhost';/" config.php
sudo sed -i "s/^\(\$db\['user'\]\s*=\s*\).*\$/\1'root';/" config.php
sudo sed -i "s/^\(\$db\['pass'\]\s*=\s*\).*\$/\1'demopass123';/" config.php
sudo sed -i "s/^\(\$db\['webhost'\]\s*=\s*\).*\$/\1'%';/" config.php
# sed -i "s/^\(\$db\['name'\]\s*=\s*\).*\$/\1'ipam';/" config.php


cd /var/www
sudo wget https://raw.githubusercontent.com/microsoft/MCW-Building-the-business-migration-case-with-Linux-and-OSS-DB-to-Azure/main/Hands-on%20lab/resources/deployment/onprem/phpipam-create.sql
sudo mysql -uroot -pdemopass123 -e "source /var/www/phpipam-create.sql"

# default phpipam login
# username: Admin
# password: ipamadmin
