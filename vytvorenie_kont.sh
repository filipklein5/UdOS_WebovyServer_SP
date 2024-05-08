#!/bin/bash

# vytvorenie uzivatelskeho uctu pre administratora serveru
vytvorAdmina() {
    echo "Zadajte meno pre admina: "
    read -r admin_meno

    # vytvorenie admina
    sudo useradd -m -s /bin/bash "$admin_meno"

    # nastavenie hesla pre admina
    echo "Nastavenie hesla pre užívateľa $admin_meno: "
    sudo passwd "$admin_meno"

    sudo usermod -aG sudo "$admin_meno"
}

# vytvorenie uzivatelskeho uctu pre spravcu webovej aplikacie
vytvorSpravcuWebu() {
    echo "Zadajte meno pre správcu webovej aplikácie: "
    read -r spravca_webu_meno

    # vytvorenie uzivatela
    sudo useradd -m -s /bin/bash "$spravca_webu_meno"

    # Nastavení hesla pre uzivatela
    echo "Nastavenie hesla pre užívateľa $spravca_webu_meno: "
    sudo passwd "$spravca_webu_meno"
}

# vytvorenie adminovskeho uctu
vytvorAdmina

# vytvorenie uctu pre spravcu webovej aplikacie...
vytvorSpravcuWebu

echo "Vytvorenie užívateľských účtov bolo úspešne dokončené."

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/konfig_web_servera.sh