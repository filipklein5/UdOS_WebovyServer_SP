#!/bin/bash

# vytvorenie uzivatelskeho uctu pre administratora serveru
echo -e "\n------VYTVORENIE UCTOV------\n"
vytvorAdmina() {
    echo "Zadajte meno pre admina: "
    read -r admin_meno

    # vytvorenie admina
    sudo useradd -m -s /bin/bash "$admin_meno"

    # nastavenie hesla pre admina
    echo "Nastavenie hesla pre uzivatela $admin_meno: "
    sudo passwd "$admin_meno"

    sudo usermod -aG sudo "$admin_meno"
}

# vytvorenie uzivatelskeho uctu pre spravcu webovej aplikacie
vytvorSpravcuWebu() {
    echo "Zadajte meno pre spravcu webovej aplikacie: "
    read -r spravca_webu_meno

    # vytvorenie uzivatela
    sudo useradd -m -s /bin/bash "$spravca_webu_meno"

    # Nastavení hesla pre uzivatela
    echo "Nastavenie hesla pre uzivatela $spravca_webu_meno: "
    read -rs spravca_webu_heslo
    echo "$spravca_webu_heslo" | sudo passwd --stdin "$spravca_webu_meno" > /dev/null 2>&1

    # ulozenie mena a hesla spravcu do suborov
    echo "$spravca_webu_meno" > spravca_webu.txt
    echo "$spravca_webu_heslo" > spravca_webu_heslo.txt

    # vytvorenie priecinka /udos_webserver/
    sudo mkdir -p /var/www/html/udos_webserver/

    #nakopirovanie defaultnej HTML stranky do vytvoreneho priecinka
    sudo cp index.html /var/www/html/udos_webserver/

    #nastavenie pristupu do /var/www/html/udos_webserver/
    sudo chown "$spravca_webu_meno":www-data /var/www/html/udos_webserver/

    # nastavenie chroot pre spravcu
    {
    echo "Match User $spravca_webu_meno";
    echo "    ChrootDirectory %h";
    echo "    AllowTCPForwarding no";
    echo "    X11Forwarding no";
    } | sudo tee -a /etc/ssh/sshd_config >/dev/null
}

# hlavna funkcia
vytvorUcty() {
    vytvorSpravcuWebu

    PS3='Chcete okrem vytvoreneho admin uctu vytvorit dalsi? '
    options=("ano" "nie")
    select opt in "${options[@]}"
    do
        case $opt in
            "ano")
                vytvorAdmina
                break
                ;;
            "nie")
                break
                ;;
            *) echo "Neplatna volba $REPLY";;
        esac
    done
}

# vytvorenie uctov
vytvorUcty

echo -e "\nVytvorenie uzivatelskych uctov bolo uspesne dokoncene.\n"

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/konfig_web_servera.sh