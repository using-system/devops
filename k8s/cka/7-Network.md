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

## Tooling

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

