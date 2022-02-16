# Prerequisite

```
choco install kubernetes-helm
```

# Add help Repo

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

# Create namespace

```
kubectl create namespace monitoring
```

# Install

```
helm install prometheus prometheus-community/prometheus -n monitoring 
```

Add the param `--set nodeExporter.hostRootfs=false` for DockerDesktop fix.

# Uninstall

```
helm uninstall prometheus
```

