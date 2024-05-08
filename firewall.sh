#!/bin/bash

# Allow incoming traffic on ports 443 and 2222
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 2222 -j ACCEPT

# Set default policy to DROP
iptables -P INPUT DROP

systemctl enable netfilter-persistent

systemctl restart netfilter-persistent

#service ssh restart
sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
systemctl restart sshd

echo -e "\nFirewall bol nastavený a SSH port zmenený na 2222.\n"