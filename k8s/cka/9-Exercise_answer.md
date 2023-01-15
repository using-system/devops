# Exercise 0

## Prepare environment

`alias k=kubectl`                         # will already be pre-configured

`export do="--dry-run=client -o yaml"`    # k create deploy nginx --image=nginx $do

`export now="--force --grace-period 0"`   # k delete pod x $now

Then use like this : 

`k run pod1 --image=httpd:2.4.41-alpine $do > 2.yaml`

# Exercise 1

## Analyse kube configuration file

Run `kubectl cluster-info --kubeconfig PATH`

## Default port for kube api

`6443`

# Exercise 2

## Pod creation

`kubectl run messaging --image=redis:alpine -l tier=msg`

## Service creation

`kubectl expose deployment hr-web-app --type=NodePort --port=8080 --name=hr-web-app-service --dry-run=client -o yaml > hr-web-app-service.yaml`

Then add the nodePort field with the given port number under the ports section and create a service.

# Exercise 3

## User certificate documentation

[Certificate Signing Requests](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/)

Reference > API Access Control > Certifcate Signing requests

## Steps

 - Create CertificateSigningRequest object
 - Approve : `kubectl certificate approve mycsr`
 - Create role : `kubectl create role myrole --resource=pods --verb=create,list,get,update,delete --namespace=myns`
 - Create role binding : `kubectl create rolebinding myrolebinding --role=myrole --user=myuser --namespace=myns`
 - Check : `kubectl auth can-i update pods --as=myuser --namespace=myns`

# Exercise 4

## Resolve service check in a pod

`kubectl run test-nslookup --image=busybox --rm -it --restart=Never -- nslookup myservice`

## Resolve pod check in a pod

`kubectl get pod nginx-resolver -o wide`

to get the pod id, replace dot by - then 

`kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup 10-244-192-4.default.pod`

## Execute a long command with split it

~~~yaml
exec:
        command:
        - sh
        - -c
        - 'wget -T2 -O- http://service-am-i-ready:80' 
~~~

## Map a secret to variable env in a pod spec

~~~yaml
    - name: APP_PASS
      valueFrom:
        secretKeyRef:
          name: secret2
          key: pass
~~~

## Map the current node name to a variable env

~~~yaml
    - name: MY_NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName 
~~~

## Create an empty dir volume

~~~yaml

  volumes:
    - name: vol
      emptyDir: {} 

~~~
# Exercise 5

## Show container usage

`k top pod -h` to have the help documentation

~~~
--containers=false: If present, print usage of containers within a pod.
~~~

Result : 

`k top pod --containers=true`

## Show the current context 

`kubectl config current-context`

## Show the context names

`k config get-contexts -o name`

## Write the resources names

`k api-resources --namespaced -o name`

## Get number of roles for the namespace myns

`k -n myns get role --no-headers | wc -l`

## Get number of pods for the namespace myns

`k -n myns get pods --no-headers | wc -l`

# Exercise 6

## Show kubeadm version

`kubeadm version`

## Show kubectl version

`kubectl version --short`

## Show kubelet version

`kubelet --version`

## Print Join node command with kubeadm

`kubeadm token create`

`kubeadm token create --print-join-command`

## Renew certificate with kubeadm

### Documentation

[Certificate Management with kubeadm](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/)

Taks > Administer a Cluster > Administration with kubeadm > Certificate Management with kubeadm

### Check certificate expiration with kubeadm

`kubeadm certs check-expiration`

### Renew certificate of a component with kubeadm

`kubeadm certs renew`

# Exercise 7

## Restore etcd snapshots

`cd /etc/kubernetes/manifests/`

`mv * ..`

`ETCDCTL_API=3 etcdctl snapshot restore path.db ..certinfo.. --data-dir /var/lib/etcd-backup`

`vim /etc/kubernetes/etcd.yaml`

`mv ../*.yaml .`

Change hostPath path for etcd-data with -data-dir info.

## Get status of a snapshot

`ETCDCTL_API=3 etcdctl ..certinfo.. snapshot status /etc/my-snapshot.db`

# Exercise 8

## List container on a kubernetes node

`crictl ps`


## Get kube-proxy container on a kubenetes node

`crictl ps | grep kube-proxy`

## Remove kube-proxy container on a kubernetes node

`crictl stop container_id`
`crictl rm container_id`

## Get the info.runtimeType of a container

`crictl inspect container_id | grep runtimeType`

# Exercise 9

## Where is by default kubelet server certificate

`/var/lib/kubelet/pki`

## Find where is kubelet binary

`whereis kubelet`

## Restart kubelet

`systemctl daemon-reload && systemctl restart kubelet`

# Exercise 10

## Run a pod on a control plane node

`k describe node masternode`

and inspect taint and labels

And apply it on the pod spec : 

~~~yaml
spec:
  tolerations:                                 # Taint
  - effect: NoSchedule
    key: node-role.kubernetes.io/control-plane
  nodeSelector:                                # Label
    node-role.kubernetes.io/control-plane: ""
~~~

## Schedule a pod only one instance for each node

Go the the k8s documentation 

[Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)

Concepts > Scheduling, Preemption and Eviction > Assigining Pods to Nodes

and search for podAntiAffinity with topologyKey == kubernetes.io/hostname

~~~yaml
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - store
            topologyKey: "kubernetes.io/hostname"
~~~

## Get iptables rules for a service

`iptables-save | grep myservice`

# Exercise 11

## Command to create role

`kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods`

## Command to create rolebinding (mapped to user)

`kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser`

## Command to create rolebinding (mapped to service account)

`kubectl create rolebinding developer-binding-myuser --role=developer --serviceaccount=default:myservice`

# Exercise 12

## View pod log without client

`cat /var/log/pods/...` on the node

## View in live containers on a k8s node

`watch crictl ps`

## How to view ingress classes

`k get ingressclass`

## Check rights for service account

`k auth can-i get pods --as system:serviceaccount:ns2:myserviceaccount`

## Map a RoleBinding to a clusterole

`k -n default create rolebinding myrolebinding --clusterrole view --user user1`

## Append data in a text file

`command >> mylog.txt`

## 100 mega, 1 go for memory resource

`100Mi`

`1Gi`

## 100 milli for cpu resource

`100m`

# Exercise 13

## Copy files form node to another

`scp /var/log/*.* NODE_IP:/data`