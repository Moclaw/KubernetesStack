#!/bin/bash

echo "Deploying monitoring stack..."

# Apply monitoring components
kubectl apply -f monitoring/prometheus.yaml
kubectl apply -f monitoring/grafana.yaml

echo "Waiting for monitoring pods to be ready..."
kubectl wait --for=condition=Ready pod -l app=prometheus -n monitoring --timeout=120s
kubectl wait --for=condition=Ready pod -l app=grafana -n monitoring --timeout=120s

# Apply ingress
kubectl apply -f ingress/grafana-ingress.yaml

echo "Monitoring stack deployed successfully!"
echo "Grafana will be available at: http://grafana.moclawr.com"
echo "Default Grafana credentials: admin/admin123"

echo ""
echo "To deploy Cloudflare tunnel:"
echo "1. Create a tunnel at https://dash.cloudflare.com"
echo "2. Update tunnel-secret.yaml with your credentials"
echo "3. Run: kubectl apply -f cloudflare/"
