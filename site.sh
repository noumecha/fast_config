sudo usermod -a -G www-data $USER
sudo mkdir /siteweb/$1
sudo chmod +x /siteweb/$1 && sudo chmod 777 /siteweb/$1
sudo chmod -R 777 /siteweb
sudo chgrp www-data /siteweb
sudo chmod g+rwxs  /siteweb
sudo touch /etc/apache2/sites-available/$1.conf
sudo chmod +x /etc/apache2/sites-available/$1.conf
sudo chmod 777 /etc/apache2/sites-available/$1.conf
sudo mkdir /siteweb/$1/logs
sudo ln -s /siteweb/$1 /var/www/
sudo echo "<VirtualHost *:80>
        ServerAdmin noonenome@sheet.bl
        ServerName $1.local
        ServerAlias www.$1.local
        DocumentRoot /var/www/$1/public/web
        <Directory /var/www/$1/public/webs>
                Options Indexes FollowSymLinks
                AllowOverride All
                Order Deny,Allow
                Allow from all
        </Directory>
    # preciser la version de PHP
    #   <FilesMatch \".+\.ph(ar|p|tml)$\">
    #           # SetHandler \"proxy:unix:/run/php/php7.0-fpm.sock|fcgi://php70.localhost\"
    #           # SetHandler \"proxy:unix:/run/php/php7.4-fpm.sock|fcgi://php74.localhost\"
    #           SetHandler \"proxy:unix:/run/php/php7.4-fpm.sock|fcgi://php74.localhost\"
    #   </FilesMatch>
        ErrorLog /var/www/$1/logs/error.log
        CustomLog /var/www/$1/logs/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/$1.conf
sudo sed -i "2i\127.0.0.1	$1.local" /etc/hosts
sudo a2ensite $1.conf
