#!/bin/bash

# aktualizacia zoznamu balickov
apt update
apt upgrade -y 

for subor in *.sh; do
    if [ -f "$subor" ]; then
        chmod +x "$subor"
    fi
done
echo "Všetky súbory v priečinku boli úspešne nastavené na spustiteľné."

#source instalacia_softverov.sh
bash instalacia_softverov.sh