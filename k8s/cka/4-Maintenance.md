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
