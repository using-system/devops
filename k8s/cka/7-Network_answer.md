# IP Commands

`ip link`

`ip addr`

`ip addr add 192.168.1.10/24 dev eth0`

# Route table

## Get the route table

`route`

## Add route

`ip route add 192.168.2.0/24 via 192.168.1.1`

## Add default route

`ip route add default via 192.168.2.1`

## Enable on a host to forward traffic for 2 network interface

`echo 1 > /proc/sys/net/ipv4/ip_forward`

# DNS 

## HostFile

`/etc/hosts`

to enter resolution ip <--> host

## Specify dns server

```
/etc/resolv.conf
nameserver 192.168.1.10
search           mycompany.com
```

where 

- nameserver  : Specify a dns
- search : to shortness a dns entry (ping myserver instead myserver.company.com)

## Priorize the host file or dns use the file

`/etc/nsswtich.config`

## Record types

- A : map to IPV6 address
- AAAA: map to a IPV7 address
- CNAME : map to dns entry

## DNS in K8s cluster

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

## CoreDNS

Dns in k8s is managed by kube-dns  : CoreDNS.

Configuration file : `/etc/coredns/Corefile` passed via configmap object (edit it to update config)

CoreDns is deployed via a service nammed kube-dns. Get the ip of this service to configure dns in `/etc/resolv.conf`. It's configured autmaticly by kubelet (dns server setted in kubelet configuration file).

## DNS Tooling

`nslookup`

# Network namespaces

`ip netns exec mynetworkns ip link`

Run `ip netns exec` to execute a command on a network namespace

OR

`ip -n mynetworkns command`

# Docker network

Docker create a bridge by default. To view it : 

`docker network ls`

When a container is created, a  network namespace is create. To view it : 

`ip netns`

# CNI

[Network Plugins | Kubernetes](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/)

Concept > Extending Kubernetes > Compute, Storage, and Networking Extensions > Network Plugins

## Name

Container Network interface

## Definition

Defines the standard for network challenges (network namespaces, bridge, add network interface...)

Create a network namespace for each container.

## Plugins

Calico is a CNI plugin for k8s for example.

The cni plugin is configured in the kubelet config : 

`ps -aux | grep kubelet`

and see cni options (bin and config dir)

## Weaveworks

Weaveworks install an agent (daemonset) on each node to intercept out/in tcp package to reroute them to the good destination.

## Cni configuration

`/etc/cni/net.d/`

Inspect the type parameter of the conf file to determine bin executed by kubelet

## Bin configuration

by default : 

`/opt/cni/bin`

## IP Address management

IP addr management is need to avoid duplicate ip adressing.
Cni comes with 2 plugins for that : "DHCP" or "host-local".

It's configured into the file `/etc/cni/net.d/net-script.com` into "`ipam.type`" value

# Netstat

Run :

`netstat -anp | grep etcd`

for view all connection for a system (example etcd above)

## Exec ip/route command on a pod to examine networking

```
kubectl run busybox2 --image=busybox --command sleep 5000 --dry-run=client -o yaml > pod.yaml
kubectl apply -f pod.yaml
kubectl exec busybox2 -- route
```

To schedule the pod on a specific node, edit yaml and add into spec : 

`nodeName: mynode`

# Service networking

When a service is creating, the ip of the service redirecting to  kubeproxy on each node (daemonset) to intercept the message and redirect to the good destination/pod.

3 mode for kubeproxy : iptables (default), userspace, ipvs. The mode can be set with the option `--proxy-mode` of the kube-proxy process.

The ip range for service are set with the option `--service-ip-range` of the kube-api process.

# Ingress

[Ingress | Kubernetes](https://kubernetes.io/docs/concepts/services-networking/ingress/)

Concepts > Service, Load Balancing, and Networking > Ingress

## Ingress controller

The solution manage the ingress (traefik, nginx, haproxy...)

## Ingress resources

All defintions file to expose service.

## Create Ingress by command

`kubectl create ingress ingress-test --rule="wear.my-online-store.com/wear*=wear-service:80"`

## Metadata annotation

```yaml
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
```

## Create Ingress Controller from scratch

- create namespace
- create configmap
- create serviceaccount
- create role to get/update configmap and binding to the service account
- create the deployment file (with nginx controller for example)
- For onpremise structure : create a service to expose the deployment via --type=NodePort. (cloud platform create a loadbalancer directly). Can use too metalllb for onpremise structure.