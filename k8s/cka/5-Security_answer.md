# Authentication

- Static password file
- Static token file
- Certificates
- Identity services (ldap...)

## Static password file

Csv file with 3 column : password, username, userid. (one Optional column groupname)

Pass the file to the kube-api-server option `--basic-auth-file`.

## Static token file

Csv file with 3 column : token, username, userid. (one Optional column groupname)

Pass the file to the kube-api-server option `--token-auth-file`.

# Cluster certificates

[Generate Certificates Manually | Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/certificates/)
Tasks > Administer a Cluster > Generate Certificates Manually

## Generate CA

`openssl genrsa -out ca.key 2048` --> ca.key

`openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr` --> ca.csr

`openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt` --> ca.crt

## Generate admin user

`openssl genrsa -out admin.key 2048`

`openssl req -new -key admin.key -subj "/CN=kube-admin/OU=system:masters" -out admin.csr` -

`openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt` 

Then with curl : 

`curl https://kuba-apiserver:6443/api/v1/pods --key admin.key --cert admin.crt --cacert ca.crt`

## Others

Then do the same procedure for CN=system:kube-scheduler, CN=system:kube-proxy, CN=system:kube-controller-manager

etcdserver.key/crt, etcpeer1key/crt

apiserver.key/crt (create an openssl.cnf for specify host dns and ip )

apiserver-kubelet-client, kubelet-client, apiserver-etcd-client

## View certificates

### With kudeadm

`cat/etc/kubernetes/manifests/kube-apiserver.yaml` (static pods)

### From scratch

`cat /etc/systemd/system/kube-apiserver.service`

### View details of a certificate

`openssl x509 -int /etc/kubernetes/pki/apiserver.crt -text -noout`

## View logs to investigate

`kubectl logs` or `docker logs` (if kubectl doesn't working)

## Generate user certificate for access to k8s API

`openssl genrsa -out mat.key 2048`

`openssl req -new -key mat.key -subj "/CN=mat" -out mat.csr`

`cat mat.csr | base64`

Then create a yaml file with kind : `CertificateSigningRequest`

`kubectl get csr`

`kubectl certificate approve mat`

`kubectl get csr mat -o yaml`

`echo 'LS...=' | base64 --decode`

# KubeConfig

## Where is the kubeconfig file ?

`$home/.kube/config`

## Structure of the configuration file

[Configure Access to Multiple Clusters | Kubernetes](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)

Tasks > Access Applications in a cluster > Configure Access to multiple clusters

```yaml
apiVersion: v1
kind: Config

current-context: ""

clusters:
- cluster:
    certificate-authority: fake-ca-file
    server: https://1.2.3.4
  name: development

contexts:
- context:
    cluster: development
    namespace: frontend
    user: developer
  name: dev-frontend

users:
- name: developer
  user:
    client-certificate: fake-cert-file
    client-key: fake-key-file
```

## Commands

`kubectl config view`

`kubectl config use-context dev-frontend`

`kubectl config use-context dev-frontend --kubeconfig=/home/myconfig`

# Authorization modes

Node, ABAC, RBAC, WEBHOOK, AlwaysDeny, AlwaysAllow

Set the modes with kube-apiserver option `--authorization-mode`.

# RBAC

[Using RBAC Authorization | Kubernetes](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

Reference > API Access Control > Using RBAC Authorization

## Role yaml structure

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

Same object exists for ClusterRole.

## RoleBinding yaml structure

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
# You can specify more than one "subject"
- kind: User
  name: jane # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

Same object exists for ClusterRoleBiding

## Commands

`kubectl get roles`

`kubectl get rolebindings`

`kubectl auth can-i delete nodes --as dev-user`

# Service account

[Managing Service Accounts | Kubernetes](https://v1-20.docs.kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)

Reference > API Access Control > Managing Service account

## Create by command

`kubectl create serviceaccount myserviceaccount`

## Token

It's create a secret object with the token of the service account. Run `kubectl describe` of the service account to get the secret name.

The token can be used with bearer token header when request kubernetes api.

The token can me mounted in volume. The default token of the namespace is automatically mounted. We can specify a custom service account with the property `serviceAccountName` under pod/spec yaml definition file.

# Image security

To specify image full form a private registry, use docker-registry secret :  [Pull an Image from a Private Registry | Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)

Tasks > Configure Pods and Containers > Pull an Image from a private registry

# Security context

## Get the user run a pod

`kubectl exec mypod -- whoami`

To modify the user, set the security context a the pod/spec level or pod/spec/contrainers level : [Configure a Security Context for a Pod or Container | Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

Tasks > Configure Pods and Containers > Configure a Security Context for a Pod or Container

To get the id of a user : `id -u root`

# Network Policy

## Policy types

Ingress : incoming traffic (perspective from the object associated to the Network policy)

Egress : outcoming traffic (perspective from the object associated to the Network policy)

## Yaml schema

[Network Policies | Kubernetes](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

Concepts > Services, Load Balancing and Networking > Network Policies

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - ipBlock:
        cidr: 172.17.0.0/16
        except:
        - 172.17.1.0/24
    - namespaceSelector:
        matchLabels:
          project: myproject
    - podSelector:
        matchLabels:
          role: frontend
    ports:
    - protocol: TCP
      port: 6379
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
    ports:
    - protocol: TCP
      port: 5978
```