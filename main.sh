#!/bin/bash

# nespustat script ako root
if [ "$(id -u)" = 0 ]; then
    echo "Ste prihlaseny ako root, ukoncujem instalaciu."
    exit 1
else 
    echo -e "\nSte prihlaseny ako non-root user, pokracujeme v instalácii.\n"
fi


# skontrolujte pripojenie na internet pingnutim google
if ping -q -c 2 -W 5 www.google.com >/dev/null; then
    echo -e "Mate stabilne pripojenie na internet. Zacina sa instalacia\n"
else
    echo -e "Nemate pripojenie na internet. Skript konci.\n"
    exit 1
fi

echo -e "\nNastavil sa lokalny cas pre nasu casovu zonu.\n"
sudo timedatectl set-timezone Europe/Bratislava

echo -e "\nPred spustenim skriptu je potrebny update.\n"
sudo apt update -y && sudo apt upgrade -y
# apt update

# vsetky subory su nastavenne ako spustitelne
for subor in *.sh; do
    if [ -f "$subor" ]; then
        sudo chmod +x "$subor"
    fi
done
echo -e "\nVsetky sucasti celkoveho skriptu boli uspesne nastavene na spustitelne!\n"

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/instalacia_softverov.sh