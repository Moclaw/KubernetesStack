#!/bin/bash

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Wait for K3s to be ready
sudo k3s kubectl wait --for=condition=Ready nodes --all --timeout=60s

# Create namespace for monitoring
sudo k3s kubectl create namespace monitoring

# Create namespace for cloudflare
sudo k3s kubectl create namespace cloudflare

echo "K3s cluster is ready!"
