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

`kubectl explain pod.spec.tolerations --recursive`

# Node affinity

## Set label

`kubectl label nodes mynode color=blue`

## Set node affinity

`kubectl explain pod.spec.affinity.nodeAffinity --recursive`

# Resources

## Resources request

`kubectl explain pod.spec.containers.resources.requests --recursive`

## Resources limit

`kubectl explain pod.spec.containers.resources.limits--recursive`

# Daemon Sets

## Definition

Daemon sets ensure that the pod is deployed on each node (use case : kube-proxy, wants to monitor each node...)

Yaml file definition is like a ReplicaSet.

## Get  Daemon Sets

`kubectl get daemonsets`

## Create DaemonSets template

`kubectl create deploy mydeploy --image=nginx --dry-run=client -o yaml > daemonset.yaml`

Then with vim, change kind to DaemonSet and remove strategy (replicas) element.

# Statics pods

## Definition

If no master node, a worker node can create pod with putting pod yaml files in /etc/kubernetes/manifests (by default. check with `ps -aux | grep kubelet` to check the config parameter/file)

Run `docker ps` to view container (no kubectl beacause no k8s api).

It's with statics pods that kube admin tools is configured on master node.

## Connect to another node

`kubectl get nodes -o wide`

Then take the ip and execute `ssh [ip]` the execute `logout` when finished.