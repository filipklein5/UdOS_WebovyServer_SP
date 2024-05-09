#!/bin/bash

echo -e "\n------SKRIPT KONFIG_DATABAZY------\n"
# funkcia pre vytvorenie databázy a užívateľa
vytvor_databazu_uzivatela() {
    # načítanie mena a hesla správcu z textových súborov
    read -r uzivatel_db < spravca_webu.txt
    read -r heslo_db < spravca_webu_heslo.txt

    echo -e "\nZadajte nazov databazy:"
    read -r nazov_db

    # vytvorenie databázy
    sudo mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS $nazov_db;"

    # vytvorenie užívateľa a pridelenie oprávnení pre databázu
    sudo mysql -u root -p -e "CREATE USER '$uzivatel_db'@'localhost' IDENTIFIED BY '$heslo_db';"
    echo -e "\nUcet s menom $uzivatel_db bol zapisany do databazy.\n"
    sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON $nazov_db.* TO '$uzivatel_db'@'localhost';"
    echo -e "Uzivatel $uzivatel_db ma teraz vsetky opravnenia v databaze $nazov_db.\n"
}

# nastavenie databázy pre webovú aplikáciu
vytvor_databazu_uzivatela

echo -e "\nNastavenie a vytvorenie databazy bolo dokoncene a uspesne!\n"

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/firewall.sh