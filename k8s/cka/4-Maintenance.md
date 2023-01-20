# Node maintenance

### What is a eviction timeout

<details>
<summary>show</summary>
<p>

TIme after the pod is considered dead (when a node that's host the pod is not acessible).
Default pod eviction timeout : 5 minutes

</p>
</details>

### How to move all pods of a node (kubectl command with options)

<details>
<summary>show</summary>
<p>

`kubectl drain mynode`

</p>
</details>

### How to ensure no pod will be scheduled on a node

<details>
<summary>show</summary>
<p>

`kubectl cordon mynode`

to moove pod of the node to another. (options : `--force` to ensuire that the node is drained, `--ignore-daemonsets`)

For reintegrate the node for pods scheduling, run :

`kubectl uncordon mynode`

For information the command cordon ensure that no future pods will be scheduled on the node. Differ with drain because drain will do more (pod terminated to moove to another node)

</p>
</details>

### How to reintegrate pod for a node

<details>
<summary>show</summary>
<p>

`kubectl uncordon mynode`

</p>
</details>


# Cluster upgrade

### Where is doc for upgrade cluster with kubeadm

<details>
<summary>show</summary>
<p>

[Upgrading kubeadm clusters | Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)

(Tasks > Administer a Cluster > Admin with kubeadm > Upgrading kubeadm clusters)


</p>
</details>

### Versionning strategy

<details>
<summary>show</summary>
<p>

kube-apiserver must have the higher version.
controlle-manager, kube-scheduler, kubectl must have the same version of kube-apiserver or one minor down.
kubelet and kube-proxy two minor down the kube-apiserver is allowed.

Kubernetes supports only 3 verisons in a time.

</p>
</details>

### Command to get the plan of a upgrade

<details>
<summary>show</summary>
<p>

`kubeadm upgrade plan` 

</p>
</details>

### Procedure to upgrade cluster with kubeadm

<details>
<summary>show</summary>
<p>

Get the plan :  `kubeadm upgrade plan` 

Update kubeadm : `apt-get upgrade -y kubeadm=1.12.0-00`

Update k8s (all except kubelet) `kubeadm upgrade apply v1.12.0`

Upgrade kubelet : `apt-get upgrade -y kubelet=1.12.0-00`

Restart kubelet : `systemctl restart kubelet`

</p>
</details>


# Backup and restore

### Command to get all k8s objects in a file

<details>
<summary>show</summary>
<p>

`kubectl get all --all-namespaces -o yaml > all.yaml`

</p>
</details>

### Where is doc for etcd maintenance

<details>
<summary>show</summary>
<p>

[Operating etcd clusters for Kubernetes | Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)

(Tasks > Administer a Cluster > Operating etcd clusters for Kubernetes)

</p>
</details>

### Procedure to determine where is etcd database

<details>
<summary>show</summary>
<p>

`ps -aux | grep -i etcd`

to get the `--data-dir` value.

</p>
</details>

### Procedure to save and restore etcd

<details>
<summary>show</summary>
<p>

`export ETCDCTL_API=3`

`etcdctl snapshot save snapshot.db`

`service kube-api-server stop`

`etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcbackup`

</p>
</details>

### Etcd with https : where is info and wich parameters    

<details>
<summary>show</summary>
<p>

For https endpoint add parameters : `--cacert`, `--cert`, `--key`.
All this values can be retrieved on get the etcd pod description.     

</p>
</details>


# High Availability

### HA for kube api

<details>
<summary>show</summary>
<p>

Create a load balancer to access to the kube api

</p>
</details>

### How works scheduler with HPA

<details>
<summary>show</summary>
<p>

In High availability cluster, we have multiple master nodes.

For controller manager sheduler.. components, only on master node is active in the same time. Other master node are in a standby mode. The cluster achieved this process with a leader election process (lock object component in the cluster and the component try to be the leader each n secondes with the param `--leader-elect-retry period`)

</p>
</details>

### Etcd HPA topologies

<details>
<summary>show</summary>
<p>

Stacked topology : In this schenario, etcd is in each master node. (easier to setup/manager, fewer servers, risk during features)

External topology : Etcd is in sepaparted nodes. (Less risky, harder to step, more servers)

</p>
</details>

### Configure kubeapi to use etcd servers

<details>
<summary>show</summary>
<p>

Kube api is the only component communicate with etcd (`--etcd-servers` option)

</p>
</details>

### How works etcd data store in HPA

<details>
<summary>show</summary>
<p>

We whill have on each master/etcd (depends topology) a copy of the etcd nosql database. All nodes can read but only one can write in the same time. It's the leader node with RAFT protocol. The other nodes redirect the write request to the leader node. The write process is completed when the data is replicated to all etcd nodes.

RAFT protocol consider to elect the leader with communication with the nodes and choose the leader. Quorum = minimal nodes to continue to works. For example, with 5 instances the quorum is 3. Minimal recommended is 3 nodes (quorum is 2, so we can have one node is failure status).

Number to remember for quorum 

- 3 (fault tolorenance : 1)
- 5 (fault tolorenance : 2)
- 7 (fault tolorenance : 3)

</p>
</details>

### Etcd installation

<details>
<summary>show</summary>
<p>

- Download binaries and install etcd.service
- set the `--initial-cluster` option to define the etcd peers.

</p>
</details>


# Kubeadm

### Where is doc for bootstrapping cluster with kubeadmin

<details>
<summary>show</summary>
<p>

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ 

(Getting started > Production envrionment > Installing Kubernetes with deploy tools > Bootstrapinng clusters with kubeadm)

</p>
</details>

### Steps for bootstrapping cluster with kubeadmin

<details>
<summary>show</summary>
<p>

- Install docker
- Install kubeadm (https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- Intialize master node (kubeadm with options then initialize kube config with instruction output of the kubeadm command : https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
- Join nodes
- Add Pod network (kubectl apply intstruction with wave, flannel... : https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model)

</p>
</details>
