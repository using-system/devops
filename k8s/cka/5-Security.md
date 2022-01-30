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