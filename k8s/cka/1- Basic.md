# Yaml file

# Pods

## Yaml structure

```yaml
apiVersion: v1
kind: Pod

metadata:
  name:mypod
    labels:
      app:mypod-app

spec:
  containers:
  - name: nginx
    image: nginx
```



## Create a nginx pod

`kubectl run nginx --image=nginx`

## Get pods

`kubectl get pods`

## Get pods (detailed)

`kubectl get pods -o wide`

## Get details for a pod

`kubectl describe pod nginx`

## Get images used in a pod

`kubectl describe pod nginx | grep -i image`

## Delete a pod

`kubectl delete pod nginx`

## Create a yaml template

`kubectl run nginx --image=nginx --dry-run -o yaml > pod.yaml`

## Edit a pod

`kubectl edit pod nginx`

# Replicas

## Yaml struture

```yaml
apiVersion: apps/v1
kind: ReplicaSet

metadata:
  name: replica1

spec:
  replicas: 2
  selector:
    matchLabels:
      type: back
  template:
   # yaml of a pod without apiVersion and kind
```

## Get ReplicaSet

`kubectl get replicaset`

## Create a yaml template

`kubectl get replicaset replica1 -o yaml > replica1.yaml`

## Edit a ReplicaSet

`kubectl edit replicaset replica1`