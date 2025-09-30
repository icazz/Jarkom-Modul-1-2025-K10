#!/bin/bash

apt update
apt install vsftpd -y && apt install ftp -y
adduser ainur
adduser melkor
mkdir -p /srv/ftp/shared
usermod -d /srv/ftp/shared ainur
usermod -d /srv/ftp/shared melkor
chown ainur:ainur /srv/ftp/shared
chmod 700 /srv/ftp/shared

nano /etc/vsftpd.conf
```
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
```

echo "hai" > /srv/ftp/shared/test.txt
echo "hai" > /root/tes.txt
service vsftpd start
ftp 192.216.1.1
# masukkan username dan password
# ainur bisa akses folder, tes dengan cara put dan get file
ftp> ascii
ftp> get test.txt
ftp> put tes.txt
