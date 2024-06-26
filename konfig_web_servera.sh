#!/bin/bash

echo -e "\n------KONFIG WEBSERVERA------\n"
# zapnutie ssl
sudo a2enmod ssl

# nastavenie virtualneho hosta pre Apache, ktory pocuva na porte 443
konfiguraciaVirtualnehoHosta() {
    local domain_name=$1
    local document_root=$2
    local config_file="/etc/apache2/sites-available/$domain_name.conf"

    cat << EOF | sudo tee "$config_file" >/dev/null

<VirtualHost *:443>
    ServerAdmin webmaster@$domain_name
    ServerName $domain_name
    DocumentRoot $document_root
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
</VirtualHost>
EOF

    # povolenie virtualneho hosta
    sudo a2ensite "$domain_name" || 
    { 
        echo "Nepodarilo sa povolit virtualny host $domain_name"; 
        exit 1; 
    }
    
    sudo systemctl reload apache2 || 
    { 
        echo "Nepodarilo sa znovu nacitat konfiguraciu Apache";
        exit 1; 
    }

    #restartovanie Apachu
    sudo systemctl restart apache2
}

# nastavenie pristupovych prav pre adresare
nastavenieAdresarovychPrav() {
    local document_root=$1
    sudo chown -R www-data:www-data "$document_root"
    sudo chmod -R 755 "$document_root"
}

# konfiguracia virtualneho hosta pre localhost
konfiguraciaVirtualnehoHosta "localhost" "/var/www/html/udos_webserver/"

# nastavenie pristupovych prav pre adresare
nastavenieAdresarovychPrav "/var/www/html/udos_webserver/"

sudo systemctl reload apache2
sudo systemctl restart apache2

echo -e "\nNastavenie weboveho servera bolo dokoncene!\n"

# prechod na dalsi skript
source $HOME/UdOS_WebovyServer_SP/konfig_databazoveho_servera.sh