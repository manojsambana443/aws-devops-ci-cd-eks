# Monitoring (Prometheus + Grafana via Helm)

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Single chart for stack
helm install kps prometheus-community/kube-prometheus-stack -n monitoring --create-namespace -f values.yaml
# Expose Grafana/Prometheus through LoadBalancer (demo only)
```
Update passwords and restrict exposure in production.
