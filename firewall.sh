#!/bin/bash
iptables -F

iptables -A INPUT -p tcp --dport 443 -j ACCEPT

sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config

iptables -A INPUT -j DROP

iptables-save > /etc/iptables.up.rules

cat << EOF > /etc/network/if-pre-up.d/iptables
#!/bin/sh
/sbin/iptables-restore < /etc/iptables.up.rules
EOF

chmod +x /etc/network/if-pre-up.d/iptables

#service ssh restart
sudo systemctl restart sshd

echo "Firewall bol nastavený a SSH port zmenený na 2222."