# K3s Monitoring Stack with Cloudflare Tunnel

## Setup Instructions

### 1. Install K3s
```bash
chmod +x k3s-setup.sh
./k3s-setup.sh
```

### 2. Deploy Monitoring Stack
```bash
chmod +x deploy.sh
./deploy.sh
```

### 3. Configure Cloudflare Tunnel

1. Create a tunnel in Cloudflare dashboard
2. Download the credentials JSON file
3. Encode it to base64: `cat credentials.json | base64 -w 0`
4. Update `cloudflare/tunnel-secret.yaml` with:
   - Your tunnel ID
   - Base64 encoded credentials
5. Deploy: `kubectl apply -f cloudflare/`

### 4. DNS Configuration

Add CNAME record in Cloudflare:
- Name: `grafana`
- Target: `<TUNNEL_ID>.cfargotunnel.com`

## Access

- Grafana: https://grafana.moclawr.com
- Default credentials: admin/admin123

## Monitoring

Check deployment status:
```bash
kubectl get pods -n monitoring
kubectl get pods -n cloudflare
```
