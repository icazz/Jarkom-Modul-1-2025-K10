#!/bin/bash

# in eru
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip
unzip kitab_penciptaan.zip
service vsftpd restart
ftp 192.216.1.1
# login dengan user ainur
ftp> put kitab_penciptaan.txt

# in manwe
service vsftpd restart
ftp 192.216.1.1
# login dengan user ainur
ftp> get kitab_penciptaan.txt

#in eru
chmod 555 /srv/ftp/shared
service vsftpd restart

# in manwe 
echo "hai" > test.txt
ftp 192.216.1.1
# login dengan user ainur dan coba put file
ftp> put test.txt