# Network policies

### Where is doc of Network policy

<details>
<summary>show</summary>
<p>

[Network Policies | Kubernetes](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

Concepts > Services, Load Balancing and Networking > Network Policies

</p>
</details>

### Check communication from frontpod to backpod

<details>
<summary>show</summary>
<p>

`k exec frontpod -- curl backpod`

</p>
</details>

### Default deny policy (allow dns outcomming traffic)

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Egress
  - Ingress
  egress:
  - ports:
    - port: 53
      protocol: TCP
    - port: 53
      protocol: UDP
```

</p>
</details>

### Allow frontend to communicate to backend pod and backend pods to receive incomming traffic from frontend

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: frontend
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          run: backend
```

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          run: frontend
```

</p>
</details>

### Disable traffic to the ip 1.1.1.1 for pods with label trust=nope

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: metadata-server
  namespace: default
spec:
  podSelector:
    matchLabels:
      trust: nope
  policyTypes:
  - Egress
  egress:
    - to:
        - ipBlock:
            cidr: 0.0.0.0/0
            except:
            - 1.1.1.1/32
```

# Port forward

### Use an HTTP Proxy to Access the Kubernetes API on port 8080

<details>
<summary>show</summary>
<p>

`kubectl proxy --port=8080`

</p>
</details>

### Where is doc to use port forward command

<details>
<summary>show</summary>
<p>

[Use Port Forwarding to Access Applications in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/)

Tasks > Access Applications on a Cluster > Use port forwarding to access application in a cluster

</p>
</details>

### Export service db(port=8745) on localhost port 8080 

<details>
<summary>show</summary>
<p>

`kubectl port-forward service/mongo 8080:8745`

</p>
</details>

### Export pod dbpod(port=8745) on localhost port 8080 

<details>
<summary>show</summary>
<p>

`kubectl port-forward pod/dbpod 8080:8745`

</p>
</details>
