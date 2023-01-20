# Pod

### Yaml structure of a pod

<details>
<summary>show</summary>
<p>

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
</p>
</details>

### Command to create a pod with nginx image

<details>
<summary>show</summary>
<p>

`kubectl run nginx --image=nginx`

</p>
</details>


### Command to get all pods from current namespace

<details>
<summary>show</summary>
<p>

`kubectl get pods`

</p>
</details>


### Command to get all pods from current namespace (detailed version)

<details>
<summary>show</summary>
<p>

`kubectl get pods -o wide`

</p>
</details>


### Command to get details for the pod nammed "nginx".

<details>
<summary>show</summary>
<p>

`kubectl describe pod nginx`

</p>
</details>


### Command to get images used for the pod nammed "nginx"

<details>
<summary>show</summary>
<p>

`kubectl describe pod nginx | grep -i image`

</p>
</details>


### Command to delete the pod nginx

<details>
<summary>show</summary>
<p>

`kubectl delete pod nginx`

</p>
</details>


### Command to create a yaml template for a pod use image nginx

<details>
<summary>show</summary>
<p>

`kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml`

</p>
</details>


### Command to edit pod nginx

<details>
<summary>show</summary>
<p>

`kubectl edit pod nginx`

</p>
</details>


# Replicaset

### Command to get all replicaset from current namespace

<details>
<summary>show</summary>
<p>

`kubectl get replicaset`

</p>
</details>


### Command to create a yaml template of a replicaset

<details>
<summary>show</summary>
<p>

`kubectl create replicaset replica1 -o yaml > replica1.yaml`

</p>
</details>


### Command to edit a replicaset

<details>
<summary>show</summary>
<p>

`kubectl edit replicaset replica1`

</p>
</details>


### Api version for replicaset

<details>
<summary>show</summary>
<p>

`apps/v1`

</p>
</details>

# Deployment

### Command to create a deployment with nginx image and 5 replicaset

<details>
<summary>show</summary>
<p>

`kubectl create deployment --image=nginx nginx --replicas=5 --dry-run=client -o yaml > deployment.yaml`

`kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > deployment.yaml`

</p>
</details>


### Command to scale the depoyment "deploy1" to 5 instances

<details>
<summary>show</summary>
<p>

`kubectl scale deployment deploy1 --replicas=5 `

</p>
</details>


### Api version for Deployment

<details>
<summary>show</summary>
<p>

`apps/v1`

</p>
</details>


# Namespace

### Command to get all pods from the namespace "ns1"

<details>
<summary>show</summary>
<p>

`kubectl get [resource=pods/deploy..] --namespace=myns`

`kubectl get [resource=pods/deploy..] -n myns`

</p>
</details>

### Specify namespace in the yaml structure of a pod

<details>
<summary>show</summary>
<p>

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

</p>
</details>

### Command to switch namespace to "myns"

<details>
<summary>show</summary>
<p>

`kubectl config set-context --current --namespace=myns`

</p>
</details>


# Service

###  Command to create yaml template for : ervice = myService, Deployment = mydeploy, targetPort = 8080, port = 8080 (node port type)

<details>
<summary>show</summary>
<p>

`kubectl expose deployment mydeploy --name=myservice --target-port=8080 --type=NodePort --port=8080 --dry-run=client -o yaml > service.yaml`

`kubectl expose deployment nginx --port 80 --dry-run=client -o yaml > service.yaml`

</p>
</details>


### Command to create yaml template for :  A pod "mypod" with service associated for port 8080

<details>
<summary>show</summary>
<p>

`kubectl expose pod mypod --name=myservice  --type=NodePort --port=8080 --dry-run=client -o yaml > service.yaml`

`kubectl run mypod --image:nginx --port=8080 --expose --dry-run=client -o yaml > podwithservice.yaml`

</p>
</details>

# Monitoring

### Command to get monitoring stats for node

<details>
<summary>show</summary>
<p>

`kubectl top node`
</p>
</details>

### Command to get monitoring stats for pod

<details>
<summary>show</summary>
<p>

`kubectl top pod`

</p>
</details>

# Logging

### Command to get log for a pod (without or with container name specified)

# VI editor

### Shortcut to insert text

<details>
<summary>show</summary>
<p>

I key


</p>
</details>

### Shortcut to save and quit

<details>
<summary>show</summary>
<p>

Esc + :wq

</p>
</details>

### Shorcut to force quit without save

<details>
<summary>show</summary>
<p>

Esc + :q!

</p>
</details>