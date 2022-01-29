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