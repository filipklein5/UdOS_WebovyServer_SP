#!/bin/bash

# vytvorenie uzivatelskeho uctu pre administratora serveru
vytvorAdmina() {
    echo "Zadajte meno pre admina: "
    read -r admin_meno

    # vytvorenie admina
    useradd -m -s /bin/bash "$admin_meno"

    # nastavenie hesla pre admina
    echo "Nastavenie hesla pre užívateľa $admin_meno: "
    passwd "$admin_meno"

    usermod -aG sudo "$admin_meno"
}

# vytvorenie uzivatelskeho uctu pre spravcu webovej aplikacie
vytvorSpravcuWebu() {
    echo "Zadajte meno pre správcu webovej aplikácie: "
    read -r spravca_webu_meno

    # vytvorenie uzivatela
    useradd -m -s /bin/bash "$spravca_webu_meno"

    # Nastavení hesla pre uzivatela
    echo "Nastavenie hesla pre užívateľa $spravca_webu_meno: "
    passwd "$spravca_webu_meno"
}

# vytvorenie adminovskeho uctu
vytvorAdmina

# vytvorenie uctu pre spravcu webovej aplikacie...
vytvorSpravcuWebu

echo "Vytvorenie užívateľských účtov bolo úspešne dokončené."