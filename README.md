# Inštalácia a stiahnutie skriptov na VM

Pre nainštalovanie skriptov je potrebné najskôr naklonovať tento repozitár.
Po naklonovaní repozitára je potrebné prejsť do priečinka, kde sa repozitár naklonoval.
Nakoniec je potrebné skriptu `main.sh` priradiť práva, aby bol nastavený ako executable a spustiť ho.

```bash
git clone https://github.com/filipklein5/UdOS_WebovyServer_SP
cd UdOS_WebovyServer_SP
chmod u+x main.sh
./main.sh
```

Ak všetko prebehlo úspešne, tak sa začal proces vytvárania Web servera.

Najprv nainstalovat apache
zistit, odkial bude brat html subory pri pristupe na stranku
vytvorit admina, cloveka ktory moze editovat html subory (danu stranku) a zaroven musi mať pristup ku databaze
typ padom treba userom pridat ako groupy/opravnenia

1. pri instalacii sa vytvori ucet ako admin
2. bud skript spustim cez roota alebo cez vytvoreneho usera
3. ak sa to bude spustat cez roota, tak prec sudo, inak opacne
4. alebo pri instalacii vytvorim root usera a obycajneho usera, a potom v skripte sa random user odstrani

NAJLEPSIE riesenie

1. pri instalaci rootovi nedat heslo - vypnut ho

2. pocas instalacie VM sa vytvori admin ucet, bude sucast groupy sudo a po spusteni skriptu mozme dat to, ze sa bud dalsi admin vytvori alebo nie
