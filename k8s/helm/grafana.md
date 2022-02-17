# Prerequisite

```
choco install kubernetes-helm
```

# Add help Repo

```
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

# Create namespace

```
kubectl create namespace grafana
```

# Install

```
helm install grafana grafana/grafana -n grafana
```

# View admin password

```
kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```



# Uninstall

```
helm uninstall grafana
```

