#!/bin/bash

# in melkor
apt-get install -y openbsd-inetd telnetd

CAT <<EOF > /etc/inetd.conf
telnet stream tcp nowait root /usr/sbin/tcpd /usr/sbin/telnetd
EOF

service openbsd-inetd restart

useradd -m -s /bin/bash melkor
echo "melkor:melkor" | chpasswd

# in eru
telnet 192.216.1.2
# login sesuai user yang dibuat pada melkor