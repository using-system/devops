# Manual Scheduling

### How to force node in the yaml pod definition

<details>
<summary>show</summary>
<p>

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

</p>
</details>

# Selectors

### Command to get all pods with selector filetering (app=myapp)

<details>
<summary>show</summary>
<p>

`kubectl get pods --selector app=myapp`

</p>
</details>

### Command to get all pods with labels

<details>
<summary>show</summary>
<p>

`kubectl get pods --show-labels`

</p>
</details>

# Taints and tolerations
 
### List of the taint effect

<details>
<summary>show</summary>
<p>

NoSchedule, PreferNoSchedule, NoExecute

</p>
</details>

### Command to add taint on a node

<details>
<summary>show</summary>
<p>

`kubectl taint nodes node-name key=value:taint-effect`

</p>
</details>

### Command to remove a taint on a node

<details>
<summary>show</summary>
<p>

`kubectl taint nodes mynode app=red:NoSchedule-`

</p>
</details>

### Yaml definition to add a toleration on a pod

<details>
<summary>show</summary>
<p>

Tolerations are for pod

In pod spec add : 

```yaml
tolerations:
- key: "app"
  operator: "Equal"
  value: "red"
  effect: "NoSchedule"
```


</p>
</details>

### Command to have the toleration definition for a pod

<details>
<summary>show</summary>
<p>

`kubectl explain pod.spec.tolerations --recursive`

</p>
</details>


# Node affinity

### Command to add label color with value blue on node "mynode"

<details>
<summary>show</summary>
<p>

`kubectl label nodes mynode color=blue`

</p>
</details>

### Command to have yaml definition of node affinity for a pod

<details>
<summary>show</summary>
<p>

`kubectl explain pod.spec.affinity.nodeAffinity --recursive`

</p>
</details>


# Resources

### Command to have yaml definition of resources request of a pod

<details>
<summary>show</summary>
<p>

`kubectl explain pod.spec.containers.resources.requests --recursive`

</p>
</details>

### Command to have yaml definition of resources limits

<details>
<summary>show</summary>
<p>

`kubectl explain pod.spec.containers.resources.limits--recursive`


</p>
</details>


# Daemon Sets

### What is a daemon set ?

<details>
<summary>show</summary>
<p>

Daemon sets ensure that the pod is deployed on each node (use case : kube-proxy, wants to monitor each node...)

Yaml file definition is like a ReplicaSet.

</p>
</details>

### Command to get daemonsets from the current namespace

<details>
<summary>show</summary>
<p>

`kubectl get daemonsets`

</p>
</details>

### How to create a daemonset yaml template (with image nginx) ?

<details>
<summary>show</summary>
<p>

`kubectl create deploy mydeploy --image=nginx --dry-run=client -o yaml > daemonset.yaml`

Then with vim, change kind to DaemonSet and remove strategy (replicas) element.

</p>
</details>


# Statics pods

### What is a static pod ?

<details>
<summary>show</summary>
<p>

It's with statics pods that kube admin tools is configured on master node.

</p>
</details>

### Where are the static pod defintion by default ?

<details>
<summary>show</summary>
<p>

/etc/kubernetes/manifests

</p>
</details>

### How to check the directory configured for the static pod definition

<details>
<summary>show</summary>
<p>

check with `ps -aux | grep kubelet` to check the config parameter/file

</p>
</details>

### How to connect to a another node ?

<details>
<summary>show</summary>
<p>

`kubectl get nodes -o wide`

Then take the ip and execute `ssh [ip]` the execute `logout` when finished.

</p>
</details>



# Multiple scheduler

### Why multiple scheduler ?

<details>
<summary>show</summary>
<p>

- Hpa  mutilple master nodes
- Custom scheduling algo


</p>
</details>

### Procedure to create a custom scheduler

<details>
<summary>show</summary>
<p>

Copy scheduler static pod yaml file and add `--schedule-name` and `--lock-object-name` to the name of custom schedule and set `--leader-elect` to false (for hpa/multiple master nodes) and update `--secure-port` or `--port` options + liveness probes.

</p>
</details>

### How to specify the scheduler name on the yaml pod definition

<details>
<summary>show</summary>
<p>

Add `schedulerName` yaml options under spec of a pod.

</p>
</details>

### Command to get event from scheduler

<details>
<summary>show</summary>
<p>

`kubectl get events`

</p>
</details>

### Command to get logs from scheduler

<details>
<summary>show</summary>
<p>

`kubectl logs myscheduler --namespace=kube-system`

</p>
</details>
