#!/bin/bash

# aktualizacia zoznamu balickov
apt update

# adresar s webovou aplikaciou
webovyServerDir="/var/www/html/SP_udos_webserver"

# stiahnutie alebo aktualizacia zdrojovych kodov aplikacie
if [ -d "$webovyServerDir" ]; then
    echo "Aktualizácia zdrojových kódov aplikácie..."
    cd "$webovyServerDir" || exit
    git pull origin master || { echo "Aktualizácia sa nepodarila"; exit 1; }
else
    echo "Sťahovanie zdrojových kódov aplikácie..."
    git clone https://github.com/filipklein5/UdOS_WebovyServer_SP.git "$webovyServerDir" || 
    { 
        echo "Sťahovanie sa nepodarilo"; 
        exit 1; 
    }
fi

# nastavenie opravneni pre adresar aplikacie
chown -R www-data:www-data "$webovyServerDir"
chmod -R 755 "$webovyServerDir"

echo "Stiahnutie a naklonovanie skriptov z gitu bolo dokončené."

# prechod na dalsi skript
# source instalacia_softverov.sh
bash instalacia_softverov.sh