---
title:  Administrowanie Rpi
author: TP
---


### Informacje wstępne

Instalowanie pakietów Debiana:

```
apt update
apt search
apt install
```

Swoje skrypty trzymam w katalogu `~/bin`.

Do edytowania używam vi. Wyłączam różne wodotryski
typu kolorowanie składni/parowanie nawiasów wstawiając
do `.vimrc` następujące deklaracje:

```
syntax off
set history=99
let loaded_matchparen = 1
set nohlsearch
```

### Łączenie się z Pi 

Z `pi` łączę się poleceniem `2nazwa_komputera`
(np `2nafisa`). Skrypt do łączenia jest banalny:

```
#!/bin/bash
REMOTE_HOST="nafisa"
REMOTE_PORT="22"
USER="pi"
ssh -p $REMOTE_PORT -l $USER $REMOTE_HOST
```

Żeby nafisa nie pytała się o hasło trzeba dokonać
stosownej konfiguracji. Mianowicie
na PCcie trzeba coś takiego wykonać

```
ssh-keygen -t rsa # ENTER na każde pytanie
## Powstaną takie pliki (uwaga na prawa dostępu):
ls -l ~/.ssh/
-rw------- 1 tomek tomek  1843 lut 17  2019 id_rsa
-rw-r--r-- 1 tomek tomek   409 lut 17  2019 id_rsa.pub
-rw------- 1 tomek tomek 23006 gru  2 03:08 known_hosts
```
Teraz skopiować `authorized_keys` na odległą maszynę,
np za pomocą:

```
scp ~/.ssh/id_rsa.pub username@serveraddress:~/.ssh/authorized_keys
```

albo zalogować się na odległej maszynie (nafisa)

```
vi ~/.ssh/authorized_keys
```

i wstać zawartość `id_rsa.pub` metodą kopiuj/wklej.


### Przesyłanie plików do/z odległego komputera sshfs

Najlepszy sposób przesyłania plików to wykorzystanie `sshfs`:

```
sudo apt search sshfs
sshfs/stable,now 2.10+repack-2 armhf [installed]
  filesystem client based on SSH File Transfer Protocol

## na Zulnarze już pewnie jest (patrz czy jest [installed])
## jeżeli nie jest to:
apt install sshfs
```

Teraz ja mam taki zwyczaj że mam katalog `~/Dist` (na PCcie)
a w nim wszystkie maszyny, z którym się łączę:

```
ls -l ~/Dist
razem 32
drwxr-xr-x 2 tomek tomek 4096 mar 21  2020 aisara
drwxr-xr-x 2 tomek tomek 4096 sty 18 08:51 danmarszal
drwxr-xr-x 2 tomek tomek 4096 lut 15  2020 gulnara
drwxr-xr-x 2 tomek tomek 4096 lis 23  2019 nafisa
drwxr-xr-x 2 tomek tomek 4096 lis 23  2019 neptune
drwxr-xr-x 2 tomek tomek 4096 kwi  1  2020 temp
drwxr-xr-x 2 tomek tomek 4096 lis 23  2019 umbriel
drwxr-xr-x 2 tomek tomek 4096 lip 31  2020 umida
```

Do łączenia używam skryptu np. `My-sshfs.sh`:

```
#!/bin/bash
DEFAULTUSER='pi'
SSHFS="sshfs -o follow_symlinks"
PORT=22

## Zamontuj/odmontuj:
while test $# -gt 0; do
  case "$1" in
    -u) shift;  S=~/Dist/$1 ;  fusermount -u $S &&
        echo "** OK: unmounted!" && return ;;
    nafisa*)  HOST="nafisa" ; S=~/Dist/nafisa  USER="pi" PORT="22" ;;
    gulnara*) HOST="gulnara" ; S=gulnara  USER="pi" PORT="22" ;;
  esac
  shift
done
##
$SSHFS -p $PORT "${USER}@$HOST:/" $MOUNTPT
```

Uruchomienie:

```
My-sshfs.sh zulnara
ls -l ~/Dist/zulnara/
razem 88
drwxr-xr-x 1 root root  4096 wrz 17  2019 bin
drwxr-xr-x 1 root root  3072 sty  1  1970 boot
drwxr-xr-x 1 root root  3800 lut  3 19:02 dev
## odmontowanie
My-sshfs.sh -u zulnara
ls -l ~/Dist/nafisa/
razem 0
```

### Cron

Plik konfiguracyjny `cron`a trzymam w katalogu `~/Crontab`. Na zulnarze
już jest `~/Crotab/crontab`:

```
ls -l ~/Crontab/crontab
-rw-r--r-- 1 pi pi 3326 sty 21 14:14 crontab
```

Powinny być wpisy odczytujące dane pogodowe co godzinę (lub pół godziny)
oraz wysyłające dane pogodowe raz na dzień na githuba.

### Konfigurowanie serwera www

Powiedzmy że `apache` będzie używany:

```
apt install apache2 -y
apt install php -y
apt install mariadb-server-10.0 php-mysql -y

## Uruchamianie 
sudo systemctl start apache2
## start|stop|restart
## NB tak się zarządza każdą usługą w debianie
```

Instalowanie `mysql`/`mariadb`:

```
sudo mysql_secure_installation
sudo mysql -u root -p

## wpisać
create database wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost'
  IDENTIFIED BY 'PASSWORD';

FLUSH PRIVILEGES;
## wyjść z terminala \q albo exit
```

Teraz pojawił się problem bo nie mogłem się zalogować a demon
`mysql` nie reagował na polecenia zatrzymania.
W końcu zabiłem demona za pomocą `kill -9`, a po starcie magicznie wszystko zadziałało.

```
# Żeby zabić proces przypominam
ps aux | grep mysql
mysql    14802  0.0  7.4 608988 66412 ? ...
sudo kill -9 14802
```

### Instalowanie WP

```
wget http://wordpress.org/latest.tar.gz
## rozpakowanie w katalogu głównym tj
## /var/www/html lub innym
## główny katalog deklaruje się w
## /etc/apache2/sites-available/000-default.conf
```

Konfigurowanie WP. Wpisałem z palca do `wp-config.php`

```
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'root' );
define( 'DB_PASSWORD', '????' );
```

Potem uruchomiłem `http://localhost/wp-admin` i dokończyłem konfigurację. 
Powinno działać.

CDN
