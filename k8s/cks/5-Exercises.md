### Where is Falco doc for output supported field

<details>
<summary>show</summary>
<p>

[Supported Fields for Conditions and Outputs](https://falco.org/docs/reference/rules/supported-fields/)

Reference > Falco Rules > Fields for Conditions and Outputs

</p>
</details>

### Display in falco rule output time with nanosecond part

<details>
<summary>show</summary>
<p>

`%evt.time`

</p>
</details>

### Check k8s api is not accesible via NodePort to be access by external

<details>
<summary>show</summary>
<p>

 - `k edit service kubernetes` and check for type is ClusterIP -->  `type: ClusterIP`
 - In kube-apiserver manifest file check argument  `--kubernetes-service-node-port` is not present

</p>
</details>


### Where is doc for activate Pod security Standard

<details>
<summary>show</summary>
<p>

[Enforce Pod Security Standards with Namespace Labels](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-namespace-labels/)

Tasks > Configure Pods and Containers > Enforce Pod Security Standards with Namespace Labels

</p>
</details>

### Activate Pod security Standard in an namespace

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-baseline-namespace
  labels:
    pod-security.kubernetes.io/enforce: baseline
```

</p>
</details>

### Access to secrets of namespaces myns via curl and kube-api

<details>
<summary>show</summary>
<p>

On the pod :

 - `mount | grep service` to get the token serviceaccount path
 - `printenv` to get the kubeapi host
 - `curl https://KUBE_API_HOST:KUBE_API_PORT/api/v1/namespaces/myns/secrets -H "Authorization: Bearer $(cat token)" -k`

</p>
</details>

### Check syscall stats of a pod

<details>
<summary>show</summary>
<p>

On the node who host the pod :

 - `crictl ps | grep podname` to get container ID
 - `crictl inspect CONTAINER_ID | grep pid` to get pid
 - `strace -f -cw -p PID` to the syscall stats

</p>
</details>

### Count all audit Secret log entries which referer service account 'myserviceaccount' and display as a json output

<details>
<summary>show</summary>
<p>

`cat myaudit.log | grep 'myserviceaccount' | grep Secret | wc -l`

`cat myaudit.log | grep 'myserviceaccount' | grep Secret | jq`

</p>
</details>

### The pod is not created. How to get log why ?

<details>
<summary>show</summary>
<p>

`k -n team-red describe rs myreplicaset`

</p>
</details>

### The pod is not created. How to get log why ?

<details>
<summary>show</summary>
<p>

`k describe rs myreplicaset`

</p>
</details>