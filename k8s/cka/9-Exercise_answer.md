# Exercise 0

## Prepare environment

`alias k=kubectl`                         # will already be pre-configured

`export do="--dry-run=client -o yaml`    # k create deploy nginx --image=nginx $do

`export now="--force --grace-period 0`   # k delete pod x $now

The following settings will already be configured in your real exam environment in ~/.vimrc. But it can never hurt to be able to type these down:

`
set tabstop=2
set expandtab
set shiftwidth=2
`

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
        - 'wget -T2 -O- http://service-am-i-ready:80'   # to here
~~~