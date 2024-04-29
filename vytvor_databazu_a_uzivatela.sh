#!/bin/bash

# adresar s webovou aplikaciou
web_app_dir="/var/www/html/myapp"

# stiahnutie alebo aktualizacia zdrojovych kodov aplikacie
if [ -d "$web_app_dir" ]; then
    echo "Aktualizácia zdrojových kódov aplikácie..."
    cd "$web_app_dir" || exit
    git pull origin master || { echo "Aktualizácia sa nepodarila"; exit 1; }
else
    echo "Sťahovanie zdrojových kódov aplikácie..."
    git clone https://github.com/user/myapp.git "$web_app_dir" || { echo "Sťahovanie sa nepodarilo"; exit 1; }
fi

# nastavenie opravneni pre adresar aplikacie
chown -R www-data:www-data "$web_app_dir"
chmod -R 755 "$web_app_dir"

echo "Nasadenie webovej aplikácie dokončené."