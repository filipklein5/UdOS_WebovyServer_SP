#!/bin/bash

# Nespustat script ako root
if [ "$(id -u)" = 0 ]; then
    echo "You are root. exiting script."
    exit 1
fi
sudo apt update -y && sudo apt upgrade -y
# apt update

# adresar s webovou aplikaciou
webovyServerDir="/var/www/html/SP_udos_webserver"

for subor in *.sh; do
    if [ -f "$subor" ]; then
        chmod +x "$subor"
    fi
done
echo "Všetky súbory v priečinku boli úspešne nastavené na spustiteľné."

# adresar s webovou aplikaciou
webovyServerDir="/var/www/html/SP_udos_webserver"

# nastavenie opravneni pre adresar aplikacie
chown -R www-data:www-data "$webovyServerDir"
chmod -R 755 "$webovyServerDir"

# prechod na dalsi skript
# TODO: skusit ci to funguje
source ./instalacia_softverov.sh
#bash instalacia_softverov.sh