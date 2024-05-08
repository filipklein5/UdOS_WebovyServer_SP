#!/bin/bash

# funkcia pre vytvorenie databázy a užívateľa
vytvor_databazu_uzivatela() {
    # načítanie mena a hesla správcu z textových súborov
    read -r uzivatel_db < spravca_webu.txt
    read -r heslo_db < spravca_webu_heslo.txt

    echo -e "\nZadajte názov databázy:"
    read -r nazov_db

    # vytvorenie databázy
    sudo mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS $nazov_db;"

    # vytvorenie užívateľa a pridelenie oprávnení pre databázu
    sudo mysql -u root -p -e "CREATE USER '$uzivatel_db'@'localhost' IDENTIFIED BY '$heslo_db';"
    sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON $nazov_db.* TO '$uzivatel_db'@'localhost';"
    sudo mysql -u root -p -e "FLUSH PRIVILEGES;"

    # kontrola oprávnení užívateľa
    echo "Kontrola oprávnení užívateľa:"
    sudo mysql -u root -p -e "SHOW GRANTS FOR '$uzivatel_db'@'localhost';"
}

# nastavenie databázy pre webovú aplikáciu
vytvor_databazu_uzivatela

echo "Nastavenie a vytvorenie databázy bolo dokončené a úspešné."

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/firewall.sh