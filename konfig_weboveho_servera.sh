#!/bin/bash

# nastavenie virtualneho hosta pre Apache
configure_virtual_host() {
    local domain_name=$1
    local document_root=$2
    local config_file="/etc/apache2/sites-available/$domain_name.conf"

    cat << EOF > "$config_file"
<VirtualHost *:80>
    ServerAdmin webmaster@$domain_name
    ServerName $domain_name
    DocumentRoot $document_root
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

    # povolenie virtualneho hosta
    a2ensite "$domain_name"
    systemctl reload apache2
}

# nastavenie pristupovych prav pre adresare
set_directory_permissions() {
    local document_root=$1
    chown -R www-data:www-data "$document_root"
    chmod -R 755 "$document_root"
}

# konfiguracia virtualneho hosta pre localhost
configure_virtual_host "localhost" "/var/www/html/example"

# nastavenie pristupovych prav pre adresare
set_directory_permissions "/var/www/html/example"

echo "Nastavenie webového servera bolo dokončené."