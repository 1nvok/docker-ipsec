#!/bin/bash

if [[ $SSH_PASSWD == "sshpass" ]] || [[ $SSH_PASSWD == ""  ]]; then
SSH_PASSWD=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 ; echo`
echo "Generated root ssh-password - $SSH_PASSWD" > /var/tmp/SSH_PASSWD
fi
if [[ $SSH_PORT == "22" ]] || [[ $SSH_PORT == ""  ]]; then
SSH_PORT=$(( $RANDOM % 20000 + 20000 ))
echo "Generated sshd server port - $SSH_PORT" > /var/tmp/SSH_PORT
fi
if [[ $VPN_PSK == "mykey" ]] || [[ $VPN_PSK == ""  ]]; then 
VPN_PSK=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 ; echo`
echo "Generated psk-key - $VPN_PSK" > /var/tmp/VPN_PSK
fi
if [[ $VPN_USER == "myuser" ]] || [[ $VPN_USER == ""  ]]; then
VPN_USER=`head /dev/urandom | tr -dc A-Za-z | head -c 10 ; echo`
echo "Generated username - $VPN_USER" > /var/tmp/VPN_USER
fi
if [[ $VPN_PASSWD == "mypasswd" ]] || [[ $VPN_PASSWD == ""  ]]; then
VPN_PASSWD=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 ; echo`
echo "Generated password - $VPN_PASSWD" > /var/tmp/VPN_PASSWD
fi

# change ssh password;
echo "root:$SSH_PASSWD" | chpasswd

# change default ssh port;
sed -i "s/#Port 22/Port $SSH_PORT/" /etc/ssh/sshd_config

# ipsec auth;
echo ": PSK $VPN_PSK"		     >> /etc/strongswan/ipsec.secrets
echo "$VPN_USER : XAUTH $VPN_PASSWD" >> /etc/strongswan/ipsec.secrets

# run services;
/usr/sbin/sshd
/usr/sbin/strongswan start
/bin/bash
