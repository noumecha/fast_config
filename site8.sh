echo 'give user access for www-data'
sudo usermod -a -G www-data $USER
sleep .1
echo '## (10%)\r'
sleep .1

echo 'creating the site directory'
sudo mkdir /siteweb/$1
sleep .1
echo '### (15%)\r'
sleep .1

echo 'give writing access to the site directory'
sudo chmod +x /siteweb/$1 && sudo chmod 777 /siteweb/$1
sudo chmod -R 777 /siteweb
sudo chgrp www-data /siteweb
sudo chmod g+rwxs  /siteweb
sleep .1
echo '##### (20%)\r'
sleep .1

echo 'creating the configurations files'
sudo touch /etc/apache2/sites-available/$1.conf
sleep .1
echo '######### (25%)\r'
sleep .1

sudo chmod +x /etc/apache2/sites-available/$1.conf
sleep .1
echo '############# (30%)\r'
sleep .1

sudo chmod 777 /etc/apache2/sites-available/$1.conf
sleep .1
echo '################# (45%)\r'
sleep .1

echo 'creating the logs directory for log errors and connections'
sudo mkdir /siteweb/$1/logs
sleep .1
echo '######################## (50%)\r'
sleep .1

echo 'creating the dynamic links'
sudo ln -s /siteweb/$1 /var/www/
sleep .1
echo '########################### (60%)\r'
sleep .1

echo 'Setting up the virtual host configuration'
sudo echo "
<VirtualHost *:80>
        ServerAdmin noumechaivan@gmail.com
        ServerName $1.local
        ServerAlias www.$1.local
        DocumentRoot /var/www/$1/public/web
        <Directory /var/www/$1/public/web>
                Options Indexes FollowSymLinks
                AllowOverride All
                Order Deny,Allow
                Allow from all
        </Directory>
        # preciser la version de PHP
        <FilesMatch \".+\.php$\">
               SetHandler \"proxy:unix:/var/run/php/php8.1-fpm.sock|fcgi://localhost\"
        </FilesMatch>
        ErrorLog /var/www/$1/logs/error.log
        CustomLog /var/www/$1/logs/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/$1.conf
sleep .1
echo '############################# (75%)\r'
sleep .1

echo 'setting up the local adress for hosts'
sudo sed -i "2i\127.0.0.1	$1.local" /etc/hosts
sleep .1
echo '####################################### (80%)\r'
sleep .1

echo 'enable configuration'
sudo a2ensite $1.conf
sleep .1
echo '############################################ (95%)\r'
sleep .1

echo 'reload apache configuration'
sudo systemctl reload apache2
sleep .1
echo '################################################ (100%)\r'
sleep .1
echo '\033[0;32mYour website configuration is now OK ...\033[m'
SITE="http://$1.local"
echo "you can check it at : $SITE"