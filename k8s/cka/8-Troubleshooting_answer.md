## Control Plane failure

## With kubeadm

`kubectl get pod -n kube-system`

Then

`kubectl logs pod_name -n kube_system`

## With services

`service kube-proxy status`

`sudo journalctl -u kube-apiserver`

## Kubelet

`service kubelet status`

`sudo journalctl -u kubelet`

`systemctl start kubelet`

`vi /var/lib/kubelet/config.yaml`

View kubelet config file : `cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf`

# CNI

## Network pluging

There are severals network plugins : Weave, Flannel,  Calico

## Configuration

 The kubelet is responsible for executing plugins as we mention the following parameters in kubelet configuration.

- cni-bin-dir:   Kubelet probes this directory for plugins on startup
- network-plugin: The network plugin to use from cni-bin-dir. It must match the name reported by a plugin probed from the plugin directory.

## Installation

[Cluster Networking | Kubernetes](https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model)

Concept > Cluster Administration > Cluster Networking

# DNS

## Resources

- service account corsdns
- cluster roles : coredns, kube-dns
- clusterrolebindings : coredns, kube-dns
- deployment : coredns
- configmap : coredns
- service : kube-dns

## Troubleshooting

- pod pending : check netowrk pluging
- ### pod failed, crashloopback : upgrade docker, dsable selinux, modify coredns deploy to set allowPrivilegeEscalation to true 
- Check service

# Kube-proxy

## Role

kubeproxy is responsible for watching services and endpoint associated with each service. When the client is going to connect to the service using the virtual IP the kubeproxy is responsible for sending traffic to actual pods.

## Config

Check the config path by describe the pod/daemonset.
In the config we can override the hostname with the node name of at which the pod is running.

## Troubleshooting

- check if kube-proxy running
- check kube-proxy logs
- check kube-proxy configmap

# Json Path

## Documentation

[JSONPath Support](https://kubernetes.io/docs/reference/kubectl/jsonpath/)

Reference > Command line tool (kubectl) > JSONPath Support

## Use Json Path with kubectl

Get the json format : `kubectl -get pods -o json`

Filer : `kubectl -get pods -o=jsonpath='{.item[0].spec.containers[0].image'}`

## Samples

### Get all nodes names

`kubectl get nodes -o=jsonpath='{.items[*].metadata.name}'`

### Get all node architectures proc

`kubectl get nodes -o=jsonpath='{.items[*].status.nodeInfo.architecture}'`

### Get all node cpu capacity

`kubectl get nodes -o=jsonpath='{.items[*].status.capacity.cpu}'`

## Merge request

`kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {.items[*].status.capacity.cpu}'`

### Formatting

`kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {"\n"} {.items[*].status.capacity.cpu}'`

`kubectl get nodes -o=jsonpath='{range .items[*]} {.metadata.name} {"\t"} {.status.capacity.cpu} {"\n"}{end}'`

## Filter

`kubectl config view --kubeconfig=my-kube-config -o jsonpath="{.contexts[?(@.context.user=='aws-user')].name}"`

## Custom columns

`kubectl get nodes -o=custom-columns=MYCOLUMN:.metadata.name,COLUMN2:.status.capacity.cpu` (path starting with each items)

## Sorting

`kubectl get nodes --sort-by=.metadata.name`

# KubeConfig

## View config of a file

`kubectl config view --kubeconfig /root/myconfif.kubeconfig`

## Annalyse cluster

`kubectl cluster-info --kubeconfig /root/config.kubeconfig`