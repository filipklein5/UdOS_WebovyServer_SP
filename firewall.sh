#!/bin/bash

echo -e "\n------FIREWALL------\n"
# povolit ip trafiku na tieto porty...
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -P INPUT DROP

sudo systemctl enable netfilter-persistent
sudo systemctl restart netfilter-persistent

sudo sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo -e "\nFirewall bol nastaveny a SSH port sa zmenil na 2222!\n"