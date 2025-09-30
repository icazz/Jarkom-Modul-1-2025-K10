#!/bin/bash
# Melkor
cat <<EOF > /etc/network/interfaces

auto eth0
iface eth0 inet static
    address 192.216.1.2
    netmask 255.255.255.0
    gateway 192.216.1.1

EOF

# Manwe
cat <<EOF > /etc/network/interfaces

auto eth0
iface eth0 inet static
    address 192.216.1.3
    netmask 255.255.255.0
    gateway 192.216.1.1

EOF

# Varda
cat <<EOF > /etc/network/interfaces

auto eth0
iface eth0 inet static
    address 192.216.2.2
    netmask 255.255.255.0
    gateway 192.216.2.1

EOF

# Elmo
cat <<EOF > /etc/network/interfaces

auto eth0
iface eth0 inet static
    address 192.216.2.3
    netmask 255.255.255.0
    gateway 192.216.2.1

EOF
