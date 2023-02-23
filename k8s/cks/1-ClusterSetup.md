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
 - after cleanup compare file, run `cat compare | uniq`


</p>
</details>

# Client configuration

### Set a new credential in the kube config with private key and certificate


<details>
<summary>show</summary>
<p>

`k config set-credentials myuser --client-key=myuser.key --client-certificate=myuser.crt`

</p>
</details>

### Set a new context myuser linked to user myuser and cluster kubernetes


<details>
<summary>show</summary>
<p>

`k config set-context myuser --user=myuser --cluster=kubernetes`

</p>
</details>

### Execute manual request to k8s api with curl and certificates


<details>
<summary>show</summary>
<p>

`curl https://X.X.X.X -k --cacert ca --cert crt --key key`

where ca, crt, key are files extracted with command `echo DATA | base64 --decode` (get the data in the kube config file or with `k config view --raw`)

</p>
</details>

### On a worker node, access to the api as worker (kubelet)


<details>
<summary>show</summary>
<p>

`ssh YOUR_WORKER_NODE`

`export KUBECONFIG=/etc/kubernetes/kubelet.conf`

</p>
</details>

# Server configuration

### Allow k8s api to be access by external


<details>
<summary>show</summary>
<p>

`k edit service kubernetes` and `type: ClusterIP` by `type: NodePort`

</p>
</details>

### Enable Node restriction

<details>
<summary>show</summary>
<p>

Add `--enable-admission-plugins=NodeRestriction` in kube-apiserver arguments on the manifest file

wihich deny worker to add label started with key `node-restriction.kubernetes.io` (sample : `k label node node01 node-restriction.kubernetes.io/two=123`)

</p>
</details>

# OPA

### What is OPA

<details>
<summary>show</summary>
<p>

OPA : Open Policy Agent

OPA is an extension (non specific for kuberntes) which allows us to write custom policies.

Rego language is used to write policy implementation.

</p>
</details>

### What is OPA Gatekeeper

<details>
<summary>show</summary>
<p>

OPA Gatekeeper make OPA easier to use in kuberntes.

Rego language is used to write policy implementation.

</p>
</details>

### What is  Admission Webhook

<details>
<summary>show</summary>
<p>

It's called on resource creation after authorization checks die validating admission webbook.

or resource change for mutating admission webbook.

</p>
</details>

### Requirements for OPA

<details>
<summary>show</summary>
<p>

Check the parameter `enable-admission-plugins` of kube-api manifest file. Value must equal to `NodeRestriction`

</p>
</details>

### How to create a OPA policy template

<details>
<summary>show</summary>
<p>

Apply the ConstraintTemplate yaml file (example below) : 		


```yaml
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8salwaysdeny
spec:
  crd:
    spec:
      names:
        kind: K8sAlwaysDeny
      validation:
        # Schema for the `parameters` field
        openAPIV3Schema:
          properties:
            message:
              type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8salwaysdeny
        violation[{"msg": msg}] {
          1 > 0
          msg := input.parameters.message
        }
```

Then check the creation of the custom resource definition with `k get [.METADATA.NAME]` (replace with K8sAlwaysDeny in the example)

</p>
</details>

### How to create a OPA policy

<details>
<summary>show</summary>
<p>

Apply the custom resource definition yaml file (example below) : 		


```yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sAlwaysDeny
metadata:
  name: pod-always-deny
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
  parameters:
    message: "ACCESS DENIED!"
```

Then check the creation with `k get K8sAlwaysDeny`

</p>
</details>

### How to check policy violation

<details>
<summary>show</summary>
<p>

Run `k describe [TEMPLATE_METADATA_NAME] [POLICY_METADATA_NAME]`

and checks for the violations section.

</p>
</details>

# Auditing

### Where is doc for auditing

<details>
<summary>show</summary>
<p>

[Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)

Tasks > Monitoring, Logging, and Debugging > Troubleshooting Clusters > Auditing

</p>
</details>

### Activate auditing

<details>
<summary>show</summary>
<p>

 - Create a folder `etc/kubernetes/audit/`
 - Create a default audit policy file  `etc/kubernetes/audit/policy.yaml`
 - Add in the kube apio manfiest file the parameters : `--audit-policy-file=/etc/kubernetes/audit/policy.yaml`, `--audit-log-path=/etc/kubernetes/audit/logs/audit.log`, `--audit-log-maxsize=500`, `--audit-log-maxbackup=5`


Add the volume and volumeMount : 

```yaml
volumes:
- name: audit
  hostPath:
    path: /etc/kubernetes/audit
    type: File
```

```yaml
volumeMounts:
  - mountPath: /etc/kubernetes/audit
    name: audit
```

</p>
</details>

### Update a auditing rule auditing

<details>
<summary>show</summary>
<p>

 - Desactiving auditing by comment parameter `--audit-policy-file` in the kube api manifest file
 - Update policy file
 - Uncomment parameter

</p>
</details>

# Cluster Maintenance

### Disable a service

<details>
<summary>show</summary>
<p>

`systemctl stop ftpd`

`systemctl disable ftpd`

</p>
</details>

### List all services

<details>
<summary>show</summary>
<p>

`systemctl list-units --type=service`

`systemctl disable ftpd`

</p>
</details>

### Get the application listenning on port 445

<details>
<summary>show</summary>
<p>

`netstats -plnt | grep 445`

</p>
</details>

### Launch a bash with the user myuser

<details>
<summary>show</summary>
<p>

`su myuser`

</p>
</details>

### Display package information

<details>
<summary>show</summary>
<p>

`apt show kube-bench`

</p>
</details>

### Remove package

<details>
<summary>show</summary>
<p>

`apt remove kube-bench`

</p>
</details>