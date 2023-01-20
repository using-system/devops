# Authentication

### List of authentications

<details>
<summary>show</summary>
<p>

- Static password file
- Static token file
- Certificates
- Identity services (ldap...)

</p>
</details>

### How to configure static password file

<details>
<summary>show</summary>
<p>

Csv file with 3 column : password, username, userid. (one Optional column groupname)

Pass the file to the kube-api-server option `--basic-auth-file`.

</p>
</details>

### How to configure static token file

<details>
<summary>show</summary>
<p>

Csv file with 3 column : token, username, userid. (one Optional column groupname)

Pass the file to the kube-api-server option `--token-auth-file`.


</p>
</details>

# Cluster certificates

### Where is the doc for generate certificate

<details>
<summary>show</summary>
<p>

[Generate Certificates Manually | Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/certificates/)
Tasks > Administer a Cluster > Generate Certificates Manually

</p>
</details>

### How to generate a CA

<details>
<summary>show</summary>
<p>

`openssl genrsa -out ca.key 2048` --> ca.key

`openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr` --> ca.csr

`openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt` --> ca.crt

</p>
</details>

### How to generate a admin user

<details>
<summary>show</summary>
<p>

`openssl genrsa -out admin.key 2048`

`openssl req -new -key admin.key -subj "/CN=kube-admin/OU=system:masters" -out admin.csr` -

`openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt` 

</p>
</details>

### How to connect with curl to k8s api and https endpoint

<details>
<summary>show</summary>
<p>

`curl https://kuba-apiserver:6443/api/v1/pods --key admin.key --cert admin.crt --cacert ca.crt`

</p>
</details>

### How to view the location of certificates (with kubeadm and from scratch)

<details>
<summary>show</summary>
<p>

`cat/etc/kubernetes/manifests/kube-apiserver.yaml` (static pods)

`cat /etc/systemd/system/kube-apiserver.service`

</p>
</details>

### How to have details for a certificate

<details>
<summary>show</summary>
<p>

`openssl x509 -int /etc/kubernetes/pki/apiserver.crt -text -noout`

</p>
</details>

### View logs for investigation

<details>
<summary>show</summary>
<p>


`kubectl logs` or `docker logs` (if kubectl doesn't working)

</p>
</details>

### How to generate user certificate for access to k8s API

<details>
<summary>show</summary>
<p>

`openssl genrsa -out mat.key 2048`

`openssl req -new -key mat.key -subj "/CN=mat" -out mat.csr`

`cat mat.csr | base64`

Then create a yaml file with kind : `CertificateSigningRequest`

`kubectl get csr`

`kubectl certificate approve mat`

`kubectl get csr mat -o yaml`

`echo 'LS...=' | base64 --decode`

</p>
</details>


# KubeConfig

### Where is kubeconfig file

<details>
<summary>show</summary>
<p>

`$HOME/.kube/config`

</p>
</details>

### Where is doc for access to multiple cluster with kubeadm

<details>
<summary>show</summary>
<p>

[Configure Access to Multiple Clusters | Kubernetes](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)

Tasks > Access Applications in a cluster > Configure Access to multiple clusters

</p>
</details>

### Command to view config

<details>
<summary>show</summary>
<p>

`kubectl config view`

</p>
</details>

### Command to change context

<details>
<summary>show</summary>
<p>

`kubectl config use-context dev-frontend`

</p>
</details>

### Command to change context with another config file

<details>
<summary>show</summary>
<p>

`kubectl config use-context dev-frontend --kubeconfig=/home/myconfig`

</p>
</details>


# Authorization modes

### List of auth moddes

<details>
<summary>show</summary>
<p>

Node, ABAC, RBAC, WEBHOOK, AlwaysDeny, AlwaysAllow

</p>
</details>

### How to set the mode

<details>
<summary>show</summary>
<p>


Set the modes with kube-apiserver option `--authorization-mode`.

</p>
</details>

### Where is doc for RBAC

<details>
<summary>show</summary>
<p>

[Using RBAC Authorization | Kubernetes](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

Reference > API Access Control > Using RBAC Authorization

</p>
</details>

### Command to get roles

<details>
<summary>show</summary>
<p>

`kubectl get roles`

</p>
</details>

### Commant to get role binding

<details>
<summary>show</summary>
<p>

`kubectl get rolebindings`

</p>
</details>

### Command to determine if user has right to delete node

<details>
<summary>show</summary>
<p>

`kubectl auth can-i delete nodes --as dev-user`

</p>
</details>

### Command to get resources of k8s api

<details>
<summary>show</summary>
<p>

`kubectl api-resources`

</p>
</details>


# Service account

### Where is doc for managing service account

<details>
<summary>show</summary>
<p>

[Managing Service Accounts | Kubernetes](https://v1-20.docs.kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)

Reference > API Access Control > Managing Service account

</p>
</details>

### Command to create service account

<details>
<summary>show</summary>
<p>

`kubectl create serviceaccount myserviceaccount`

</p>
</details>

### How to get token of the service account

<details>
<summary>show</summary>
<p>

It's create a secret object with the token of the service account. Run `kubectl describe` of the service account to get the secret name.

The token can be used with bearer token header when request kubernetes api.

The token can me mounted in volume. The default token of the namespace is automatically mounted. 

</p>
</details>

### How to set the serviceAccount to a pod

<details>
<summary>show</summary>
<p>

We can specify a custom service account with the property `serviceAccountName` under pod/spec yaml definition file.

</p>
</details>

### Command to create a token

<details>
<summary>show</summary>
<p>

`kubectl create token myserviceaccount`

</p>
</details>


# Image security

### Where is doc to specify secret to pull image

<details>
<summary>show</summary>
<p>

To specify image full form a private registry, use docker-registry secret :  [Pull an Image from a Private Registry | Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)

Tasks > Configure Pods and Containers > Pull an Image from a private registry

</p>
</details>


# Security context

### Command to get the user run a pod

<details>
<summary>show</summary>
<p>

`kubectl exec mypod -- whoami`

</p>
</details>

### How to set the user run a pod and where is the doc

<details>
<summary>show</summary>
<p>

To modify the user, set the security context a the pod/spec level or pod/spec/contrainers level : [Configure a Security Context for a Pod or Container | Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

Tasks > Configure Pods and Containers > Configure a Security Context for a Pod or Container

</p>
</details>

### Command to get the if of a user

<details>
<summary>show</summary>
<p>

To get the id of a user : `id -u root`

</p>
</details>


# Network Policy

### Definition of ingress and egress

<details>
<summary>show</summary>
<p>

Ingress : incoming traffic (perspective from the object associated to the Network policy)

Egress : outcoming traffic (perspective from the object associated to the Network policy)

</p>
</details>

### Where is doc of Network policy

<details>
<summary>show</summary>
<p>

[Network Policies | Kubernetes](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

Concepts > Services, Load Balancing and Networking > Network Policies

</p>
</details>
