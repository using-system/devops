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