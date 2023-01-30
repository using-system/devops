# Overview 

## Kubernetes components

### Control plane components

<details>
<summary>show</summary>
<p>

apiserver -> etcd (k8s database)

scheduler (assign pod to nodes) -> apiserver

controller manager -> apiserver

</p>
</details>

### Data plane components

<details>
<summary>show</summary>
<p>

apiserver <-> kubelet (run pod and informs api server pod state changes)

apiserver <- kube-proxy (informs services changed)

</p>
</details>

### Where is documentation of kubernetes components

<details>
<summary>show</summary>
<p>

[Kubernetes Components](https://kubernetes.io/docs/concepts/overview/components)

Concepts > Overview > Kubernetes components

</p>
</details>

## Certificates location 

### CA

<details>
<summary>show</summary>
<p>

on master node /etc/kubernetes/pki/ca.crt,key

</p>
</details>

### Api server certificate

<details>
<summary>show</summary>
<p>

on master node /etc/kubernetes/pki/apiserver.crt,key

</p>
</details>

### controller manager -> Api server client certificate

<details>
<summary>show</summary>
<p>

on master node vi /etc/kubernetes/controller-manager.conf (data is in the configuration file)

</p>
</details>

### scheduler -> Api server client certificate

<details>
<summary>show</summary>
<p>

on master node vi /etc/kubernetes/scheduler.conf (data is in the configuration file)

</p>
</details>

### kubelet -> Api server client certificate 

<details>
<summary>show</summary>
<p>

on each node,  vi /etc/kubernetes/kubelet.conf refers to /var/lib/kubelet/pki/kubelet-client-current.pem

</p>
</details>

### kubelet server certificate

<details>
<summary>show</summary>
<p>

on each node, /var/lib/kubelet/pki/kubelet.crt,key

</p>
</details>

### Api server -> kubelet client certificate 

<details>
<summary>show</summary>
<p>

on master node /etc/kubernetes/pki/apiserver-kubelet-client.crt,key

</p>
</details>

### Etcd server certificate

<details>
<summary>show</summary>
<p>

on master node /etc/kubernetes/pki/etcd/server.crt,key

</p>
</details>

### Api server -> etcd client certificate 

<details>
<summary>show</summary>
<p>

on master node /etc/kubernetes/pki/apiserver-etcd-client.crt,key

</p>
</details>

### Where is documentation for components certificates

<details>
<summary>show</summary>
<p>

[PKI certificates and requirements](https://kubernetes.io/docs/setup/best-practices/certificates/)

Getting started > Best practices > PKI certificates and requirements


</p>
</details>

# Check k8s binaries

### How to check kube-apiserver binary


<details>
<summary>show</summary>
<p>

 - Go the kubernetes github repo https://github.com/kubernetes/kubernetes and choose the k8s version with tags and download server binaries (changelog)
 - `tar xzf kubernetes-server-linux-amd64.tar.gz`
 - `sha512sum kubernetes/server/bin/kube-apiserver > compare`
 - run `ps aux | grep kube-apiserver` to get the pid
 - `find /proc/[PID]/root/ | grep kube-api`
 - `sha512sum [BINARY_PATH] >> compare`
 - after cleanup compare file, run `cat compate | uniq`


</p>
</details>