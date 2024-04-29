#!/bin/bash

# funkcia pre instalaciu balickov a kontrolu uspesnosti v pripade chyb...
nainstalujBalicek() {
    local nazovBalicka=$1
    while true; do
        apt install -y "$nazovBalicka"
        if apt install -y "$nazovBalicka"; then
            echo "Balíček $nazovBalicka bol úspešne nainštalovaný."
            break
        else
            read -rp "Inštalácia balíčku $nazovBalicka zlyhala. Chcete skúsiť inštaláciu znovz? [a/n]: " moznost
            case $moznost in
                [Aa]* ) 
                    continue;;
                [Nn]* ) 
                    echo "Inštalácia balíčku $nazovBalicka byla prerušená užívateľom."; 
                    exit;;
                * ) 
                    echo "Prosím, zadajte 'a' pre pokračovanie alebo 'n' pre ukončenie."; 
                    continue;;
            esac
        fi
    done
}

# instalacia balickov
nainstalujBalicek "apache2"

# instalacia mariadb
nainstalujBalicek "mariadb-server"

# instalacia php a jeho rozsireni
nainstalujBalicek "php"
nainstalujBalicek "libapache2-mod-php"
nainstalujBalicek "php-mysql"

# restartovanie apache pre spustenie
systemctl restart apache2

echo "Inštalácia softvérov úspešne dokončená."

# prechod na dalsi skript
bash konfig_databazoveho_servera.sh
