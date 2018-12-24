#!/usr/bin/env bash

# # Initiaite k8s cluster
# echo "Setting up k8s cluster..."
# kubeadm init --pod-network-cidr=10.244.0.0/16 #flannel CIDR
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.0/Documentation/kube-flannel.yml
# kubectl taint nodes --all node-role.kubernetes.io/master

# Set static ip address
echo "Setting static IP..."
cat /etc/netplan/01-netcfg.yaml
cat <<EOF >/etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
     dhcp4: no
     addresses: [192.168.0.201/24]
     gateway4: 192.168.0.1
EOF
cat /etc/netplan/01-netcfg.yaml
netplan apply