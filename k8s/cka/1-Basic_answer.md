# Pods

## Yaml structure

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: mypod
    labels:
      app: mypod-app

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

`kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml`

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

`kubectl create replicaset replica1 -o yaml > replica1.yaml`

## Edit a ReplicaSet

`kubectl edit replicaset replica1`

# Deployment

## Create a yaml template

`kubectl create deployment --image=nginx nginx --replicas=5 --dry-run=client -o yaml > deployment.yaml`

`kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > deployment.yaml`

## Yaml structure

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: deploy1
    labels:
      app: myapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myapp
  template:

   # yaml of a pod without apiVersion and kind
```

## Scale

`kubectl scale deployment deploy1 --replicas=5 ` 

# Namespace

## Get resource from namespace

`kubectl get [resource=pods/deploy..] --namespace=myns`

`kubectl get [resource=pods/deploy..] -n myns`

## Get resource from all namespaces

`kubectl get [resource=pods/deploy..] --all-namespaces`

## Create a pod with namespace specified

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: mypod
  namespace: myns
    labels:
      app: mypod-app

spec:
  containers:
  - name: nginx
    image: nginx
```

## Switch namespace

kubectl config set-context --current --namespace=myns

# Services

## Create a yaml template

`kubectl expose deployment mydeploy --name=myservice --target-port=8080 --type=NodePort --port=8080 --dry-run=client -o yaml > service.yaml`

`kubectl expose deployment nginx --port 80 --dry-run=client -o yaml > service.yaml`

`kubectl expose pod mypod --name=myservice  --type=NodePort --port=8080 --dry-run=client -o yaml > service.yaml`

`kubectl run mypod --image:nginx --port=8080 --expose --dry-run=client -o yaml > podwithservice.yaml`

By default the type of a service is ClusterIp.

## Yaml structure (Node Port)

~~~yaml
 apiVersion: v1
 kind: Service
 metadata:
   name: myService
 spec:
   type: NodePort
   ports:
    - targetPort: 8080
      port: 80
      nodePort: 30008
        selector:
          name: myApp

~~~

# Basic monitoring

Basic monitoring in memory can be performed with metrics-server

Once deployed run : 

`kubectl top node`

`kubectl top pod`

# Logging

`kubectl logs -f my-pod`

Whit multiple containers:

`kubectl logs -f my-pod container-name`