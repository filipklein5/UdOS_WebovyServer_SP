# Inštalácia a stiahnutie skriptov na VM
Pre nainštalovanie skriptov je potrebné najskôr naklonovať tento repozitár.
Po naklonovaní repozitára je potrebné prejsť do priečinka, kde sa repozitár naklonoval.
Nakoniec je potrebné skriptu `main.sh` priradiť práva, aby bol nastavený ako executable a spustiť ho.

```bash
git clone https://github.com/filipklein5/UdOS_WebovyServer_SP.git
cd UdOS_WebovyServer_SP
chmod u+x main.sh
./main.sh
```

Ak všetko prebehlo úspešne, tak sa začal proces vytvárania Web servera. \
TODO: zmenit poradie scriptu, najprv vytvorit admin a pridat ho ako Sudo usera (visudo)\
TODO: Firewall (iptables) povolit iba porty 443, zmenit port pre ssh 