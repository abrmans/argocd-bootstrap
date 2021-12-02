#!/bin/bash

k3sup install \
--cluster \
--ip 192.168.200.127 \
--k3s-channel stable \
--k3s-extra-args '--disable servicelb --disable traefik --write-kubeconfig-mode 644' \
--merge \
--context k3s-ha-amd64 \
--local-path $HOME/.kube/config \
--user miles

wait

echo ""
echo "Server 1 complete!"
echo ""

wait

k3sup join \
--ip 192.168.200.129 \
--k3s-channel stable \
--k3s-extra-args '--disable servicelb --disable traefik --write-kubeconfig-mode 644' \
--user miles \
--server-user miles \
--server-ip 192.168.200.127 \
--server

wait

echo ""
echo "Server 2 complete!"
echo ""

wait

k3sup join \
--ip 192.168.200.128 \
--k3s-channel stable \
--k3s-extra-args '--disable servicelb --disable traefik --write-kubeconfig-mode 644' \
--user miles \
--server-user miles \
--server-ip 192.168.200.127 \
--server

wait

echo ""
echo "Server 3 complete!"
echo ""

wait

k3sup join \
--ip 192.168.200.122 \
--k3s-channel stable \
--user miles \
--server-user miles \
--server-ip 192.168.200.127

wait

echo ""
echo "Server 4 complete!"
echo ""

wait

k3sup join \
--ip 192.168.200.123 \
--k3s-channel stable \
--user miles \
--server-user miles \
--server-ip 192.168.200.127

wait

echo ""
echo "Server 5 complete!"
echo ""

wait

k3sup join \
--ip 192.168.200.124 \
--k3s-channel stable \
--user miles \
--server-user miles \
--server-ip 192.168.200.127

wait

echo ""
echo "Server 6 complete!"
echo ""

wait

export KUBECONFIG=/home/miles/.kube/config

wait

kubectl config set-context k3s-ha-amd64

echo "All Servers Installed!"

sleep 60

echo "Here is your cluster:"

wait

kubectl get nodes -o wide
