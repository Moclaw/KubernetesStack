# K3s Monitoring Stack with Cloudflare Tunnel

## Setup Instructions

### Option 1: Docker Compose (Recommended for Development)

#### 1. Start Monitoring Stack
```bash
# Start services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

#### 2. Access Services
- Grafana: http://localhost:3000 (admin/admin123)
- Prometheus: http://localhost:9090
- Node Exporter: http://localhost:9100

#### 3. Stop Services
```bash
docker-compose down
# or to remove volumes
docker-compose down -v
```

### Option 2: Kubernetes Deployment

#### 1. Install K3s
```bash
chmod +x k3s-setup.sh
./k3s-setup.sh
```

#### 2. Deploy Monitoring Stack
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

### Docker Compose
- Grafana: http://localhost:3000
- Prometheus: http://localhost:9090

### Kubernetes
- Grafana: https://grafana.moclawr.com
- Default credentials: admin/admin123

## Monitoring

### Docker Compose
```bash
docker-compose ps
docker-compose logs grafana
docker-compose logs prometheus
```

### Kubernetes
Check deployment status:
```bash
kubectl get pods -n monitoring
kubectl get pods -n cloudflare
```

## Configuration

- Prometheus config: `prometheus/prometheus.yml`
- Grafana datasources: `grafana/provisioning/datasources/`
- Grafana dashboards: `grafana/provisioning/dashboards/`
