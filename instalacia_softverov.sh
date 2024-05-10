#!/bin/bash

# funkcia pre instalaciu balickov a kontrolu uspesnosti v pripade chyb...
echo -e "\n------INSTALACIA SOFTVEROV------\n"

nainstalujBalicek() {
    local nazovBalicka=$1
    while true; do
        sudo apt install -y "$nazovBalicka"
        if sudo apt install -y "$nazovBalicka"; then
            echo -e "\nBalicek $nazovBalicka bol uspesne nainstalovany.\n"
            break
        else
            read -rp "Instalacia balicku $nazovBalicka zlyhala. Chcete skusit instalaciu znova? [a/n]: " moznost
            case $moznost in
                [Aa]) 
                    continue
                    ;;
                [Nn]) 
                    echo "Instalacia balicku $nazovBalicka bola prerusena uzivatelom."
                    exit
                    ;;
                * ) 
                    echo "Prosim, zadajte 'a' pre pokracovanie alebo 'n' pre ukoncenie." 
                    continue
                    ;;
            esac
        fi
    done
}

# instalacia apache2
nainstalujBalicek "apache2"
nainstalujBalicek "mariadb-server"
nainstalujBalicek "php"
nainstalujBalicek "libapache2-mod-php"
nainstalujBalicek "php-mysql"

nainstalujBalicek "iptables"
export PATH=$PATH:/sbin
source $HOME/.bashrc
nainstalujBalicek "netfilter-persistent"

nainstalujBalicek "nodejs"

sudo systemctl reload apache2

echo -e "Instalacia softverov bola uspesne dokoncena!\n"

source $HOME/UdOS_WebovyServer_SP/vytvorenie_kont.sh
