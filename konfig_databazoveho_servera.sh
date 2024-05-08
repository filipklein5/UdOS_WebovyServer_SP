#!/bin/bash

# funkcia pre vytvorenie databázy a užívateľa
vytvor_databazu_uzivatela() {
    echo -e "\nZadajte meno správcu webového servera:"
    read -r uzivatel_db

    echo -e "\nZadajte heslo správcu webového servera:"
    read -rs heslo_db

    echo -e "\nZadajte názov databázy:"
    read -r nazov_db

    # vytvorenie databázy
    mysql -u "$uzivatel_db" -p"$heslo_db" -e "CREATE DATABASE IF NOT EXISTS $nazov_db;"

    # vytvorenie užívateľa a pridelenie oprávnení pre databázu
    mysql -u "$uzivatel_db" -p"$heslo_db" -e "CREATE USER '$uzivatel_db'@'localhost' IDENTIFIED BY '$heslo_db';"
    mysql -u "$uzivatel_db" -p"$heslo_db" -e "GRANT ALL PRIVILEGES ON $nazov_db.* TO '$uzivatel_db'@'localhost';"
    mysql -u "$uzivatel_db" -p"$heslo_db" -e "FLUSH PRIVILEGES;"
}

# nastavenie databázy pre webovú aplikáciu
vytvor_databazu_uzivatela

echo "Nastavenie a vytvorenie databázy bolo dokončené a úspešné."

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/firewall.sh