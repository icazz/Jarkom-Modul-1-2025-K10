#!/bin/bash

# in eru
apt install openssh-server -y
service ssh restart
netstat -tuln | grep :22

# in varda
ssh ainur@192.216.1.1