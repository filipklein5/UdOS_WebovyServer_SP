#!/bin/bash

# nespustat script ako root
if [ "$(id -u)" = 0 ]; then
    echo "Ste prihlásený ako root. Pokračujeme v inštalácií"
else 
    echo "Skript musíte spustiť ako root. Skript končí."
    exit 1
fi


# skontrolujte pripojenie na internet pingnutim Google servera
if ping -q -c 1 -W 5 www.google.com >/dev/null; then
    echo "Máte stabilné pripojenie na internet. Začína sa inštalácia"
else
    echo "Nemáte pripojenie na internet. Skript končí."
    exit 1
fi

echo "Pred pustením skriptu je potrebný update"
apt update -y && apt upgrade -y
# apt update

# adresar s webovou aplikaciou
webovyServerDir="/var/www/html/SP_udos_webserver"

for subor in *.sh; do
    if [ -f "$subor" ]; then
        chmod +x "$subor"
    fi
done
echo "Všetky súbory v priečinku boli úspešne nastavené na spustiteľné."

# nastavenie opravneni pre adresar aplikacie
chown -R www-data:www-data "$webovyServerDir"
chmod -R 755 "$webovyServerDir"

# prechod na dalsi skript
# TODO: skusit ci to funguje
source $HOME/UdOS_WebovyServer_SP/instalacia_softverov.sh