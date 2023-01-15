### Prepare environment for kubectl alias et basic export

<details>
<summary>show</summary>
<p>

`alias k=kubectl`                         # will already be pre-configured

`export do="--dry-run=client -o yaml"`    # k create deploy nginx --image=nginx $do

`export now="--force --grace-period 0"`   # k delete pod x $now

Then use like this : 

`k run pod1 --image=httpd:2.4.41-alpine $do > 2.yaml`

</p>
</details>

### Analyse kube configuration file

<details>
<summary>show</summary>
<p>

Run `kubectl cluster-info --kubeconfig PATH`
OR `kubectl cluster-info --kubeconfig PATH` to specify another configuration file

</p>
</details>

### Default port for kube api

<details>
<summary>show</summary>
<p>

`6443`

</p>
</details>

### Specify label with pod creation imperative command

<details>
<summary>show</summary>
<p>

`kubectl run messaging --image=redis:alpine -l tier=msg`

</p>
</details>

### How to create NodePort service by specifying port imperative command

<details>
<summary>show</summary>
<p>

`kubectl expose deployment hr-web-app --type=NodePort --port=8080 --name=hr-web-app-service --dry-run=client -o yaml > hr-web-app-service.yaml`

Then add the nodePort field with the given port number under the ports section and create a service.

</p>
</details>

### Where is K8s Doc for user certificate creation and define the steps

<details>
<summary>show</summary>
<p>

[Certificate Signing Requests](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/)

Reference > API Access Control > Certifcate Signing requests

Steps : 
 - Create CertificateSigningRequest object
 - Approve : `kubectl certificate approve mycsr`
 - Create role : `kubectl create role myrole --resource=pods --verb=create,list,get,update,delete --namespace=myns`
 - Create role binding : `kubectl create rolebinding myrolebinding --role=myrole --user=myuser --namespace=myns`
 - Check : `kubectl auth can-i update pods --as=myuser --namespace=myns`

</p>
</details>

### Resolve service check in a pod

<details>
<summary>show</summary>
<p>

`kubectl run test-nslookup --image=busybox --rm -it --restart=Never -- nslookup myservice`

</p>
</details>

### Resolve pod check in a pod

<details>
<summary>show</summary>
<p>

`kubectl get pod nginx-resolver -o wide`

to get the pod id, replace dot by - then 

`kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup 10-244-192-4.default.pod`

</p>
</details>

### Execute a long command in a container

<details>
<summary>show</summary>
<p>

~~~yaml
exec:
        command:
        - sh
        - -c
        - 'wget -T2 -O- http://service-am-i-ready:80' 
~~~

</p>
</details>

### Map a secret to variable env in a pod spec

<details>
<summary>show</summary>
<p>

~~~yaml
    - name: APP_PASS
      valueFrom:
        secretKeyRef:
          name: secret2
          key: pass
~~~

</p>
</details>

### Map the current node name to a variable env

<details>
<summary>show</summary>
<p>

~~~yaml
    - name: MY_NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName 
~~~

</p>
</details>


### Create an empty dir volume

<details>
<summary>show</summary>
<p>

~~~yaml

  volumes:
    - name: vol
      emptyDir: {} 

~~~

</p>
</details>

### Show container usage

<details>
<summary>show</summary>
<p>

`k top pod -h` to have the help documentation

~~~
--containers=false: If present, print usage of containers within a pod.
~~~

Result : 

`k top pod --containers=true`

</p>
</details>

### Show the current context 

<details>
<summary>show</summary>
<p>

`kubectl config current-context`

</p>
</details>

### Show the context names

<details>
<summary>show</summary>
<p>

`k config get-contexts -o name`

</p>
</details>



### Write the resources names

<details>
<summary>show</summary>
<p>

`k api-resources --namespaced -o name`

</p>
</details>



### Get number of roles for the namespace myns

<details>
<summary>show</summary>
<p>

`k -n myns get role --no-headers | wc -l`

</p>
</details>



### Get number of pods for the namespace myns

<details>
<summary>show</summary>
<p>

`k -n myns get pods --no-headers | wc -l`

</p>
</details>

### Show kubeadm version

<details>
<summary>show</summary>
<p>

`kubeadm version`

</p>
</details>

### Show kubectl version

<details>
<summary>show</summary>
<p>

`kubectl version --short`

</p>
</details>

### Show kubelet version

<details>
<summary>show</summary>
<p>

`kubelet --version`

</p>
</details>

### Print Join node command with kubeadm

<details>
<summary>show</summary>
<p>

`kubeadm token create`

`kubeadm token create --print-join-command`

</p>
</details>



### Where is Renew certificate doc with kubeadm

<details>
<summary>show</summary>
<p>

[Certificate Management with kubeadm](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/)

Taks > Administer a Cluster > Administration with kubeadm > Certificate Management with kubeadm

</p>
</details>


### Check certificate expiration with kubeadm

<details>
<summary>show</summary>
<p>

`kubeadm certs check-expiration`

</p>
</details>



### Renew certificate of a component with kubeadm

<details>
<summary>show</summary>
<p>

`kubeadm certs renew`

</p>
</details>

### Restore etcd snapshots

<details>
<summary>show</summary>
<p>

`cd /etc/kubernetes/manifests/`

`mv * ..`

`ETCDCTL_API=3 etcdctl snapshot restore path.db ..certinfo.. --data-dir /var/lib/etcd-backup`

`vim /etc/kubernetes/etcd.yaml`

`mv ../*.yaml .`

Change hostPath path for etcd-data with -data-dir info.

</p>
</details>


### Get status of a snapshot

<details>
<summary>show</summary>
<p>

`ETCDCTL_API=3 etcdctl ..certinfo.. snapshot status /etc/my-snapshot.db`

</p>
</details>



### List container on a kubernetes node

<details>
<summary>show</summary>
<p>

`crictl ps`

</p>
</details>

### Get kube-proxy container on a kubenetes node

<details>
<summary>show</summary>
<p>

`crictl ps | grep kube-proxy`

</p>
</details>


### Remove kube-proxy container on a kubernetes node

<details>
<summary>show</summary>
<p>

`crictl stop container_id`
`crictl rm container_id`

</p>
</details>

### Get the info.runtimeType of a container

<details>
<summary>show</summary>
<p>

`crictl inspect container_id | grep runtimeType`

</p>
</details>

### Where is by default kubelet server certificate

<details>
<summary>show</summary>
<p>

`/var/lib/kubelet/pki`

</p>
</details>

### Find where is kubelet binary

<details>
<summary>show</summary>
<p>

`whereis kubelet`

</p>
</details>

### Restart kubelet

<details>
<summary>show</summary>
<p>

`systemctl daemon-reload && systemctl restart kubelet`

</p>
</details>

### Run a pod on a control plane node

<details>
<summary>show</summary>
<p>

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

</p>
</details>


### Schedule a pod only one instance for each node

<details>
<summary>show</summary>
<p>

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

</p>
</details>

### Get iptables rules for a service

<details>
<summary>show</summary>
<p>

`iptables-save | grep myservice`

</p>
</details>

### Command to create role

<details>
<summary>show</summary>
<p>

`kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods`

</p>
</details>

### Command to create rolebinding (mapped to user)

<details>
<summary>show</summary>
<p>

`kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser`

</p>
</details>

### Command to create rolebinding (mapped to service account)

<details>
<summary>show</summary>
<p>

`kubectl create rolebinding developer-binding-myuser --role=developer --serviceaccount=default:myservice`

</p>
</details>

### View pod log without client

<details>
<summary>show</summary>
<p>

`cat /var/log/pods/...` on the node

</p>
</details>


### View in live containers on a k8s node

<details>
<summary>show</summary>
<p>

`watch crictl ps`

</p>
</details>

### How to view ingress classes

<details>
<summary>show</summary>
<p>

`k get ingressclass`

</p>
</details>



### Check rights for service account

<details>
<summary>show</summary>
<p>

`k auth can-i get pods --as system:serviceaccount:ns2:myserviceaccount`

</p>
</details>



### Map a RoleBinding to a clusterole

<details>
<summary>show</summary>
<p>

`k -n default create rolebinding myrolebinding --clusterrole view --user user1`

</p>
</details>

### Append data in a text file

<details>
<summary>show</summary>
<p>

`command >> mylog.txt`

</p>
</details>

### 100 mega, 1 go for memory resource

<details>
<summary>show</summary>
<p>

`100Mi`

`1Gi`

</p>
</details>


### 100 milli for cpu resource

<details>
<summary>show</summary>
<p>


`100m`

</p>
</details>

### Copy files form node to another

<details>
<summary>show</summary>
<p>

`scp /var/log/*.* NODE_IP:/data`

</p>
</details>

