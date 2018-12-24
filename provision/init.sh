#!/usr/bin/env bash

echo "Starting bootstrap..."

# Install Docker
echo "Updating..."
apt-get update && apt-get install -y curl apt-transport-https ca-certificates software-properties-common

echo "Adding docker repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/docker.list
deb https://download.docker.com/linux/$(lsb_release -si | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable
EOF

echo "Installing docker..."
apt-get update && apt-get install -y docker-ce

# Disable swapping
echo "disabling swap"
cat /proc/swaps
awk '/swap/{$0="#"$0} 1' /etc/fstab >/etc/fstab.tmp && mv /etc/fstab.tmp /etc/fstab
sudo swapoff -a
sudo sysctl vm.swappiness=0
cat /proc/swaps

# Set apt up ready for installing k8s
echo "Adding k8s repository..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
echo "Updating..."
apt-get update

# Install k8s
echo "Installing k8s..."
apt-get install -y kubelet kubeadm kubectl
#systemctl status kubelet