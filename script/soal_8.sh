#!/bin/bash

# in ulmo
apt update && apt install unzip
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O ramalan-cuaca.zip
unzip ramalan-cuaca.zip

service vsftpd start

ftp 192.216.1.1
ftp> put cuaca.txt
ftp> put mendung.jpg