#!/bin/bash

echo -e "\n------FIREWALL------\n"
# povolit ip trafiku na tieto porty...
if ! sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT; then
    echo "Chyba pri nastavovani iptables pre port 443"
    exit 1
fi

if ! sudo iptables -A INPUT -p tcp --dport 2222 -j ACCEPT; then
    echo "Chyba pri nastavovani iptables pre port 2222"
    exit 1
fi

if ! sudo iptables -P INPUT DROP; then
    echo "Chyba pri nastavovani iptables pre DROP"
    exit 1
fi

if ! sudo systemctl enable netfilter-persistent; then
    echo "Chyba pri nastavovani netfilter-persistent"
    exit 1
fi

if ! sudo systemctl restart netfilter-persistent; then
    echo "Chyba pri restartovani netfilter-persistent"
    exit 1
fi

if ! sudo sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config; then
    echo "Chyba pri nastavovani sshd_config"
    exit 1
fi

if ! sudo systemctl restart sshd; then
    echo "Chyba pri restartovani SSH"
    exit 1
fi

echo -e "\nFirewall bol nastaveny a SSH port sa zmenil na 2222!\n"