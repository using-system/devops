# Manual Scheduling

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
      - containerPort: 8080
  nodeName: node02


```

# Selectors

## Filter with kubectl

`kubectl get pods --selector app=myapp`

`kubectl get pods --show-labels`

# Taints and tolerations

## Taints

### Add taint

Taints are for node

`kubectl taint nodes node-name key=value:taint-effect`

where taint-effect = NoSchedule, PreferNoSchedule, NoExecute

`kubectl taint nodes mynode app=red:NoSchedule`

### Remove taint

`kubectl taint nodes mynode app=red:NoSchedule-`

## Tolerations

Tolerations are for pod

In pod spec add : 

```yaml
tolerations:
- key: "app"
  operator: "Equal"
  value: "red"
  effect: "NoSchedule"
```

Tips for have details for the pod yaml schema

`kubectl explain pod --recursive | less`

