#!/bin/bash

# funkcia pre vytvorenie databázy a užívateľa
vytvor_databazu_uzivatela() {
    # nacitanie mena a hesla spravcu z suborov
    uzivatel_db=$(cat spravca_webu.txt)
    heslo_db=$(cat spravca_webu_heslo.txt)

    echo -e "\nZadajte názov databázy:"
    read -r nazov_db

    # vytvorenie databázy
    mysql -e "CREATE DATABASE IF NOT EXISTS $nazov_db;"

    # vytvorenie užívateľa a pridelenie oprávnení pre databázu
    mysql -e "CREATE USER '$uzivatel_db'@'localhost' IDENTIFIED BY '$heslo_db';"
    mysql -e "GRANT ALL PRIVILEGES ON $nazov_db.* TO '$uzivatel_db'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
}

# nastavenie databázy pre webovú aplikáciu
vytvor_databazu_uzivatela

echo "Nastavenie a vytvorenie databázy bolo dokončené a úspešné."

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/firewall.sh