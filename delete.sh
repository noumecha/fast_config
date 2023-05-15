
echo "Deleting the site $1 \r"
sleep .1
sudo rm -r /siteweb/$1
echo "######################## (50%)"
sleep .1
echo "################################################ (100%)"
sleep .1
sudo rm -r /etc/apache2/sites-available/$1.conf
sleep .1