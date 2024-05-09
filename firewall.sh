#!/bin/bash

# povolit ip trafiku na tieto porty...
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2222 -j ACCEPT

sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Set default policy to DROP
sudo iptables -P INPUT DROP

sudo systemctl enable netfilter-persistent

sudo systemctl restart netfilter-persistent

#service ssh restart
sudo sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo -e "\nFirewall bol nastavený a SSH port zmenený na 2222.\n"