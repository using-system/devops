# Node maintenance

## Eviction timeout

TIme after the pod is considered dead (when a node that's host the pod is not acessible).
Default pod eviction timeout : 5 minutes

## Drain

`kubectl drain mynode`

to moove pod of the node to another. (options : `--force` to ensuire that the node is drained, `--ignore-daemonsets`)

For reintegrate the node for pods scheduling, run :

`kubectl uncordon mynode`

For information the command cordon ensure that no future pods will be scheduled on the node. Differ with drain because drain will do more (pod terminated to moove to another node)

# Cluster upgrade

[Upgrading kubeadm clusters | Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)

## Versionning

kube-apiserver must have the higher version.
controlle-manager, kube-scheduler, kubectl must have the same version of kube-apiserver or one minor down.
kubelet and kube-proxy two minor down the kube-apiserver is allowed.

Kubernetes supports only 3 verisons in a time.

## Strategy

For updrading a component, recommanded approch is to updrage minor by minor.
Update the master node first, then node by node.

## kubeadm

### On master node

Get the plan :  `kubeadm upgrade plan` 

Update kubeadm : `apt-get upgrade -y kubeadm=1.12.0-00`

Update k8s (all except kubelet) `kubeadm upgrade apply v1.12.0`

Upgrade kubelet : `apt-get upgrade -y kubelet=1.12.0-00`

Restart kubelet : `systemctl restart kubelet`

### On each worker node

Drain the worker node :  `kubectl drain mynode`

Update kubeadm : `apt-get upgrade -y kubeadm=1.12.0-00`

Update node : `kubeadm upgrade node`

Upgrade kubelet : `apt-get upgrade -y kubelet=1.12.0-00`

Update kubelet config :  `kubeadm upgrade node config --kubelet-version v1.12.0`

Restart kubelet : `systemctl restart kubelet`

Reschedule the node :  `kubectl uncordon mynode`

# Backup and restore

## Get all pods and deployments in yaml file

`kubectl get all --all-namespaces -o yaml > all.yaml`

## Etcd data directory

[Operating etcd clusters for Kubernetes | Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)

All kubernetes datas are stored in the etcd database. 

`ps -aux | grep -i etcd`

to get the `--data-dir` value.

## Save and restore with etcdctl

`export ETCDCTL_API=3`

`etcdctl snapshot save snapshot.db`

`service kube-api-server stop`

`etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcbackup`

Then configure the new --data-dit in etcd.service params or edit the static pod etcd with kubeadm way.

`systelctl daemon-reload`

`service etcd restart`

`service kube-apiserver start`

(service stop and restart don't need if the service are hosted in pod)

## etcdctl with https

For https endpoint add parameters : `--cacert`, `--cert`, `--key`.
All this values can be retrieved on get the etcd pod description.       

# High Availability

## Kube api

Create a load balancer to access to the kube api

## Multiple master nodes

In High availability cluster, we have multiple master nodes.

For controller manager sheduler.. components, only on master node is active in the same time. Other master node are in a standby mode. The cluster achieved this process with a leader election process (lock object component in the cluster and the component try to be the leader each n secondes with the param `--leader-elect-retry period`)

## Etcd

### Stacked topology

In this schenario, etcd is in each master node.

(easier to setup/manager, fewer servers, risk during features)

### External topology

Etcd is in sepaparted nodes. 

(Less risky, harder to step, more servers)

### Kube api

Kube api is the only component communicate with etcd (`--etcd-servers` option)

### Data stores

We whill have on each master/etcd (depends topology) a copy of the etcd nosql database. All nodes can read but only one can write in the same time. It's the leader node with RAFT protocol. The other nodes redirect the write request to the leader node. The write process is completed when the data is replicated to all etcd nodes.

RAFT protocol consider to elect the leader with communication with the nodes and choose the leader. Quorum = minimal nodes to continue to works. For example, with 5 instances the quorum is 3. Minimal recommended is 3 nodes (quorum is 2, so we can have one node is failure status).

Number to remember for quorum 

- 3 (fault tolorenance : 1)
- 5 (fault tolorenance : 2)
- 7 (fault tolorenance : 3)

### Installation

- Download binaries and install etcd.service
- set the `--initial-cluster` option to define the etcd peers.

# Kubeadm

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ 

## Steps

- Install docker
- Install kubeadm (https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- Intialize master node (kubeadm with options then initialize kube config with instruction output of the kubeadm command : https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
- Join nodes
- Add Pod network (kubectl apply intstruction with wave, flannel... : https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model)

