# Secure an ingress

### Where is doc for ingress

<details>
<summary>show</summary>
<p>

[Ingress | Kubernetes](https://kubernetes.io/docs/concepts/services-networking/ingress/)

Concepts > Service, Load Balancing, and Networking > Ingress

</p>
</details>

### How to skip certicate validation with curl (without and with verbose information)

<details>
<summary>show</summary>
<p>

`curl https://myip:myport/myservice -k`

`curl https://myip:myport/myservice -kv`

</p>
</details>

### Create certifcate secret

<details>
<summary>show</summary>
<p>

`k create secret tls mycertificate --cert=cert.pem,crt --key=cert.key`

</p>
</details>

### Specify tls certificate in a ingress

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-example-ingress
spec:
  tls:
  - hosts:
      - https-example.foo.com
    secretName: testsecret-tls
  rules:
  - host: https-example.foo.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: service1
            port:
              number: 80
```

</p>
</details>

### Resolve ip/port with a domain name with curl option

<details>
<summary>show</summary>
<p>

`curl https://mydomain.com:myport/myservice --resolve mydomain.com:myport:myip`

</p>
</details>

### Generate self-signed certificate

<details>
<summary>show</summary>
<p>

`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout cert.key -out cert.crt -subj "/CN=mydomain.com/O=mydomain.com"`

</p>
</details>

# Security benchmark

## CIS

### Acronym of CIS

<details>
<summary>show</summary>
<p>

CIS : Center for Internet Security

</p>
</details>

### What is CIS

<details>
<summary>show</summary>
<p>

kube-bench can check automaticly CIS rules. Follows the instruction in the kube-bench guthub repository (https://github.com/aquasecurity/kube-bench), --> Running inside a container

</p>
</details>

## kube-bench

### What is kube-bench

<details>
<summary>show</summary>
<p>

kube-bench can check automaticly CIS rules. Follows the instruction in the kube-bench guthub repository (https://github.com/aquasecurity/kube-bench), --> Running inside a container

</p>
</details>

### Check all cis rules on master node with kube-bench

<details>
<summary>show</summary>
<p>

`kube-bench run --targets master`

</p>
</details>

### Check the cis rule 1.2.20 on master node with kube-bench

<details>
<summary>show</summary>
<p>

`kube-bench run --targets master --check 1.2.20`

</p>
</details>

### Check cis rules on worker node with kube-bench

<details>
<summary>show</summary>
<p>

`kube-bench run --targets node`

</p>
</details>

# mTLS

### What is mTLS

<details>
<summary>show</summary>
<p>

mTLS allows you to have a two-way authentication for internal pod secure communication.

</p>
</details>

### How to implements mTLS for a pod

<details>
<summary>show</summary>
<p>

Create a container proxy in the pod that intercepts secure communication.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mtlsdemo
spec:
  containers:
  - name: app
    image: bash
    command:
    - sh
    - -c
    - 'ping google.com'
  - name: proxy
    image: ubuntu
    command:
    - sh
    - -c
    - 'apt-get update && apt-get install iptables -y && iptables -L && sleep 10d'
    securityContext:
      capabilities:
        add: ["NET_ADMIN"]
```


</p>
</details>

# SecOps

## Scanning

### Performs static analysis of k8s yaml files

<details>
<summary>show</summary>
<p>

Use [kubesec](https://kubesec.io/) tool

`kubesec scan pod.yaml`

OR

`docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < podyaml`

</p>
</details>

### Performs a image vulnerability scanning

<details>
<summary>show</summary>
<p>

Use [trivy](https://github.com/aquasecurity/trivy) tool

`trivy image python:3.4-alpine`

OR

`docker run aquasec/trivy image python:3.4-alpine`

</p>
</details>

## Registry

### Update a service account with a image pull secret

<details>
<summary>show</summary>
<p>

`k patch serviceaccount default -p '{"imagePullSecrets": [{"name": "my-registry"}] }'`

</p>
</details>

### Check the image digest of a pod

<details>
<summary>show</summary>
<p>

`k get pod mypod -o yaml`

Then check for the section `status.containerStatuses.imageID`                

</p>
</details>

### How to activate ImagePolicyWebhook

<details>
<summary>show</summary>
<p>

In kubeapi manifest file add the ImagePolicyWebhook

`--enable-admission-plugins=NodeRestriction,ImagePolicyWebHook`

and the configuration file for admission control

`--admission-control-config-file=/etc/kubernetes/admission/config.yaml` (add volume and volumeMount for /etc/kubernetes/admission)             

</p>
</details>