#!/usr/bin/env bash

# Add k8s-master IP address to hosts file
echo "Adding master ip..."
echo "192.168.0.201 k8s-manager" | tee -a /etc/hosts
cat /etc/hosts

# Set static ip address
var=$1
echo "Setting static IP...192.168.0.21$var"
cat /etc/netplan/01-netcfg.yaml
cat <<EOF >/etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
     dhcp4: no
     addresses: [192.168.0.21$var/24]
     gateway4: 192.168.0.1
EOF
cat /etc/netplan/01-netcfg.yaml
netplan apply