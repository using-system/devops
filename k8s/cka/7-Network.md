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

# Netstat

Run :

`netstat -anp | grep etcd`

for view all connection for a system (example etcd above)