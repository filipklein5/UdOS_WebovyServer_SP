#!/bin/bash

# nespustat script ako root
if [ "$(id -u)" = 0 ]; then
    echo "Ste prihlásený ako root, ukončujem inštaláciu."
    exit 1
else 
    echo -e "\nSte prihlásený ako non-root user, pokračujeme v inštalácií.\n"
fi


# skontrolujte pripojenie na internet pingnutim Google servera
if ping -q -c 2 -W 5 www.google.com >/dev/null; then
    echo -e "Máte stabilné pripojenie na internet. Začína sa inštalácia\n"
else
    echo -e "Nemáte pripojenie na internet. Skript končí.\n"
    exit 1
fi

echo -e "\nNastavil sa lokálny čas pre našu časovú zónu.\n"
sudo timedatectl set-timezone Europe/Bratislava

echo -e "\nPred pustením skriptu je potrebný update.\n"
sudo apt update -y && sudo apt upgrade -y
# apt update

# vsetky subory su nastavenne ako spustitelne
for subor in *.sh; do
    if [ -f "$subor" ]; then
        sudo chmod +x "$subor"
    fi
done
echo -e "\nVšetky súčasti celkového skriptu boli úspešne nastavené na spustiteľné.\n"

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/instalacia_softverov.sh