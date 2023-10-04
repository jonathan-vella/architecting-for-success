# https://phpipam.net/phpipam-installation-on-centos-7/

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
sudo firewall-cmd --reload


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

sudo sed -i "s/^\(\$db\['ssl'\]\s*=\s*\).*\$/\1true;/" config.php
sudo sed -i "s/^\(\$db\['webhost'\]\s*=\s*\).*\$/\1'%';/" config.php
