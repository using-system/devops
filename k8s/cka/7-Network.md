# IP Commands

### Get info on network interfaces

<details>
<summary>show</summary>
<p>

`ip link`

`ip addr`

</p>
</details>

### Assign ip on a network interface

<details>
<summary>show</summary>
<p>

`ip addr add 192.168.1.10/24 dev eth0`

</p>
</details>


# Route table

### Get the route table

<details>
<summary>show</summary>
<p>

`route`

</p>
</details>

### Add route

<details>
<summary>show</summary>
<p>

`ip route add 192.168.2.0/24 via 192.168.1.1`

</p>
</details>

### Add default route

<details>
<summary>show</summary>
<p>

`ip route add default via 192.168.2.1`

</p>
</details>

### Enable on a host to forward traffic for 2 network interfaces

<details>
<summary>show</summary>
<p>

`echo 1 > /proc/sys/net/ipv4/ip_forward`

</p>
</details>


# DNS 

### Where is host file

<details>
<summary>show</summary>
<p>

`/etc/hosts`

</p>
</details>

### Specify a dns server and how to configure it

<details>
<summary>show</summary>
<p>

```
/etc/resolv.conf
nameserver 192.168.1.10
search           mycompany.com
```

where 

- nameserver  : Specify a dns
- search : to shortness a dns entry (ping myserver instead myserver.company.com)

</p>
</details>

### How to priorize host file or dns

<details>
<summary>show</summary>
<p>

`/etc/nsswtich.config`


</p>
</details>

### Different record types

<details>
<summary>show</summary>
<p>

- A : map to IPV6 address
- AAAA: map to a IPV7 address
- CNAME : map to dns entry

</p>
</details>

### Full address for a service and shortness address

<details>
<summary>show</summary>
<p>

K8s create a dns entry for each service created :

```
myservice.mynamespace.svc.cluster.local
```

and via `search` entry in `/etc/resolv.conf`  can be access via 

```
myservice
myservice.mynamespace
myservice.mynamespace.svc
```

Entries can be created for pod by not by default must be configured:

`10-244-1-5.mynamespace.pod`

</p>
</details>

### Where is configuration for core dns

<details>
<summary>show</summary>
<p>

 `/etc/coredns/Corefile`

</p>
</details>

### How to get ip of the core dns server

<details>
<summary>show</summary>
<p>

CoreDns is deployed via a service nammed kube-dns. Get the ip of this service to configure dns in `/etc/resolv.conf`. It's configured autmaticly by kubelet (dns server setted in kubelet configuration file).

</p>
</details>

### What is the name of the dns tool

<details>
<summary>show</summary>
<p>

`nslookup`

</p>
</details>


# Network namespaces

### Run a command in a network namespace

<details>
<summary>show</summary>
<p>

`ip netns exec mynetworkns ip link`

Run `ip netns exec` to execute a command on a network namespace

OR

`ip -n mynetworkns command`

</p>
</details>


# Docker network

### View docker network

<details>
<summary>show</summary>
<p>

`docker network ls`

</p>
</details>

### View docker network namespace

<details>
<summary>show</summary>
<p>

`ip netns`

</p>
</details>


# CNI

### Where is doc for CNI

<details>
<summary>show</summary>
<p>

[Network Plugins | Kubernetes](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/)

Concept > Extending Kubernetes > Compute, Storage, and Networking Extensions > Network Plugins

</p>
</details>

### Definition of CNI

<details>
<summary>show</summary>
<p>

Container Network interface

Defines the standard for network challenges (network namespaces, bridge, add network interface...)

Create a network namespace for each container.

</p>
</details>

### Examples of cni plugin

<details>
<summary>show</summary>
<p>

Calico is a CNI plugin for k8s for example.

</p>
</details>

### How to view cni configuration

<details>
<summary>show</summary>
<p>

The cni plugin is configured in the kubelet config : 

`ps -aux | grep kubelet`

and see cni options (bin and config dir)

</p>
</details>

### How works weaveworks

<details>
<summary>show</summary>
<p>

Weaveworks install an agent (daemonset) on each node to intercept out/in tcp package to reroute them to the good destination.

</p>
</details>

### Where is cni configuration

<details>
<summary>show</summary>
<p>

`/etc/cni/net.d/`

</p>
</details>

### Cni bin default directory

<details>
<summary>show</summary>
<p>

`/opt/cni/bin`

</p>
</details>

### CNI ip address management

<details>
<summary>show</summary>
<p>

IP addr management is need to avoid duplicate ip adressing.
Cni comes with 2 plugins for that : "DHCP" or "host-local".

It's configured into the file `/etc/cni/net.d/net-script.com` into "`ipam.type`" value

</p>
</details>

### How to determine pod ip allocation

<details>
<summary>show</summary>
<p>

To determine pod ip allocation run :

`kubectl logs <weave-pod-name> weave -n kube-system` (for example with weave)

</p>
</details>

# Netstat

### View all connection for a system (with etcd for exemple)

<details>
<summary>show</summary>
<p>

Run :

`netstat -anp | grep etcd`

for view all connection for a system (example etcd above)

</p>
</details>

### Examming networking of a pod

<details>
<summary>show</summary>
<p>

```
kubectl run busybox2 --image=busybox --command sleep 5000 --dry-run=client -o yaml > pod.yaml
kubectl apply -f pod.yaml
kubectl exec busybox2 -- route
```

</p>
</details>


# Service networking

### Role of kubeproxy

<details>
<summary>show</summary>
<p>

When a service is creating, the ip of the service redirecting to  kubeproxy on each node (daemonset) to intercept the message and redirect to the good destination/pod.

</p>
</details>

### Different mode of kubeproxy

<details>
<summary>show</summary>
<p>

3 mode for kubeproxy : iptables (default), userspace, ipvs. The mode can be set with the option `--proxy-mode` of the kube-proxy process or run : 

`kubectl logs <kube-proxy-pod-name> -n kube-system`

</p>
</details>

### Set ip range for services

<details>
<summary>show</summary>
<p>

The ip range for service are set with the option `--service-ip-range` of the kube-api process.

</p>
</details>


# Ingress

### Where is doc for ingress

<details>
<summary>show</summary>
<p>

[Ingress | Kubernetes](https://kubernetes.io/docs/concepts/services-networking/ingress/)

Concepts > Service, Load Balancing, and Networking > Ingress

</p>
</details>

### List of different ingress solution

<details>
<summary>show</summary>
<p>

The solution manage the ingress (traefik, nginx, haproxy...)

</p>
</details>

### Command to create an ingress

<details>
<summary>show</summary>
<p>

`kubectl create ingress ingress-test --rule="wear.my-online-store.com/wear*=wear-service:80"`

</p>
</details>

### metadata annotation

<details>
<summary>show</summary>
<p>

```yaml
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
```
</p>
</details>

### Create an ingress controller from scratch

<details>
<summary>show</summary>
<p>

- create namespace
- create configmap
- create serviceaccount
- create role to get/update configmap and binding to the service account
- create the deployment file (with nginx controller for example)
- For onpremise structure : create a service to expose the deployment via --type=NodePort. (cloud platform create a loadbalancer directly). Can use too metalllb for onpremise structure.

</p>
</details>
