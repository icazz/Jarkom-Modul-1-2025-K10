#!/bin/bash

# in melkor
apt install netcat-openbsd
service vsftpd start
nc -zv 192.216.1.2 21
apt install apache2 -y
service apache2 start
nc -zv 192.216.1.2 80
nc -zv 192.216.1.2 666