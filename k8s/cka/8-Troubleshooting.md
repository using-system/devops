## Control Plane failure

## With kubeadm

### Inspect system pod and logs

<details>
<summary>show</summary>
<p>

`kubectl get pod -n kube-system`

Then

`kubectl logs pod_name -n kube_system`

</p>
</details>


## With services

### Inspect system pod and logs (for kube-proxy and kube api for example)

<details>
<summary>show</summary>
<p>

`service kube-proxy status`

`sudo journalctl -u kube-apiserver`

</p>
</details>


## Kubelet

### View kubelet status and logs

<details>
<summary>show</summary>
<p>

`service kubelet status`

`sudo journalctl -u kubelet`

</p>
</details>

### Restart kubelet

<details>
<summary>show</summary>
<p>

`systemctl start kubelet`

</p>
</details>

### How to determine where is kubelet config  yaml file (with kubeadm)

<details>
<summary>show</summary>
<p>

`vi /var/lib/kubelet/config.yaml`

</p>
</details>

### View kubelet configuration

<details>
<summary>show</summary>
<p>

View kubelet config file : `cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf`

</p>
</details>


# CNI

### Differents network plugins

<details>
<summary>show</summary>
<p>

There are severals network plugins : Weave, Flannel,  Calico

</p>
</details>

### How to determine bin and network plugins

<details>
<summary>show</summary>
<p>

 The kubelet is responsible for executing plugins as we mention the following parameters in kubelet configuration.

- cni-bin-dir:   Kubelet probes this directory for plugins on startup
- network-plugin: The network plugin to use from cni-bin-dir. It must match the name reported by a plugin probed from the plugin directory.


</p>
</details>

### Where is doc for networking model implementation

<details>
<summary>show</summary>
<p>

[Cluster Networking | Kubernetes](https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model)

Concept > Cluster Administration > Cluster Networking

</p>
</details>

### How to install a puglin network (weave for example)

<details>
<summary>show</summary>
<p>

[Cluster Networking | Add-On](https://kubernetes.io/docs/concepts/cluster-administration/addons/)

Concept > Cluster Administration > Installing Addons

</p>
</details>


# DNS

### Resources of kube-dns

<details>
<summary>show</summary>
<p>

- service account corsdns
- cluster roles : coredns, kube-dns
- clusterrolebindings : coredns, kube-dns
- deployment : coredns
- configmap : coredns
- service : kube-dns

</p>
</details>

### If pod is in pending, what we must do

<details>
<summary>show</summary>
<p>

check netowrk pluging

</p>
</details>

### Pod failed : procedure to do

<details>
<summary>show</summary>
<p>

upgrade docker, dsable selinux, modify coredns deploy to set allowPrivilegeEscalation to true

</p>
</details>


# Kube-proxy

### Procedure to check kube-proxy

<details>
<summary>show</summary>
<p>

- check if kube-proxy running
- check kube-proxy logs
- check kube-proxy configmap

</p>
</details>


# Json Path

### Where is documentation

<details>
<summary>show</summary>
<p>

[JSONPath Support](https://kubernetes.io/docs/reference/kubectl/jsonpath/)

Reference > Command line tool (kubectl) > JSONPath Support

</p>
</details>

### Get pods in json output format

<details>
<summary>show</summary>
<p>

Get the json format : `kubectl -get pods -o json`

</p>
</details>

### Get the first image of each pod

<details>
<summary>show</summary>
<p>

`kubectl -get pods -o=jsonpath='{.item[0].spec.containers[0].image'}`

</p>
</details>

### Get all nodes names

<details>
<summary>show</summary>
<p>

`kubectl get nodes -o=jsonpath='{.items[*].metadata.name}'`

</p>
</details>

### Merge request witn n infos to dipslay

<details>
<summary>show</summary>
<p>

`kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {.items[*].status.capacity.cpu}'`

</p>
</details>

### Formatting with tab...

<details>
<summary>show</summary>
<p>

`kubectl get nodes -o=jsonpath='{range .items[*]} {.metadata.name} {"\t"} {.status.capacity.cpu} {"\n"}{end}'`

</p>
</details>

### Filtering

<details>
<summary>show</summary>
<p>

`kubectl config view --kubeconfig=my-kube-config -o jsonpath="{.contexts[?(@.context.user=='aws-user')].name}"`

</p>
</details>

### Custom columns

<details>
<summary>show</summary>
<p>

`kubectl get nodes -o=custom-columns=MYCOLUMN:.metadata.name,COLUMN2:.status.capacity.cpu` (path starting with each items)

</p>
</details>

### Sorting nodes by name

<details>
<summary>show</summary>
<p>

`kubectl get nodes --sort-by=.metadata.name`

</p>
</details>


# KubeConfig

### View config of a file

<details>
<summary>show</summary>
<p>

`kubectl config view --kubeconfig /root/myconfif.kubeconfig`

</p>
</details>

### Analyse cluster

<details>
<summary>show</summary>
<p>

`kubectl cluster-info --kubeconfig /root/config.kubeconfig`

</p>
</details>
