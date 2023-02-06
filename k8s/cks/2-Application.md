# Containers

## Container tools

### Describe docker, containerid, crictl and podman

<details>
<summary>show</summary>
<p>

Docker : Container Runtime + tool for managing containers/image

Containerd : Container Runtime (use now by k8s instead docker runtime)

Crictl : CLI compatible with docker and Containerd runtime

Podman : tool for managing containers/image

</p>
</details>

## Commands with docker and podman

### List images

<details>
<summary>show</summary>
<p>

`docker ps`

OR

`podman ps`

</p>
</details>

### Run two containers in the same kernel group namespace

<details>
<summary>show</summary>
<p>

`docker run --name c1 -d nginx:alpine sh -c 'sleep 1d'`

`docker run --name c2 --pid=container:c1 -d ubuntu sh -c 'sleep 2d'`

OR

`podman run --name c1 -d nginx:alpine sh -c 'sleep 1d'`

`podman run --name c2 --pid=container:c1 -d ubuntu sh -c 'sleep 2d'`


</p>
</details>

### List process of a container

<details>
<summary>show</summary>
<p>

`docker exec c1 ps aux`

OR

`podman exec c1 ps aux`

</p>
</details>

### Remove container

<details>
<summary>show</summary>
<p>

`docker rm container_id --force`

OR

`podman rm container_id --force`

</p>
</details>

### Built an image and run it

<details>
<summary>show</summary>
<p>

`docker build -t myimage`

`docker image ls`

`docker run myimage`

OR

`podman build -t myimage`

`podman image ls`

`podman run myimage`

</p>
</details>

## Dockerfile

### Simple Dockerfile execute ping google.com

<details>
<summary>show</summary>
<p>

```Dockerfile
FROM bash
CMD ["ping", "google.com"]
```

</p>
</details>

# Use service accounts with pods

### Where is documentation for manage pods with service accounts

<details>
<summary>show</summary>
<p>

[Configure Service Accounts for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)

Taks > Configure Pods and Containers > Configure Service Accounts for Pods


</p>
</details>

### How to find the token mounted into a pod

<details>
<summary>show</summary>
<p>

Run `mount | grep service` describe the pod specification.

</p>
</details>

### How to connect to the k8s api with token inside a pod

<details>
<summary>show</summary>
<p>

Run `printenv | grep KUBER` to the the k8s api url.

THEN

run `curl https://X.X.X.X -k -H "Authorization Bearer $(cat token)"`

</p>
</details>

### Disable service account mouting in pod specification

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  serviceAccountName: build-robot
  automountServiceAccountToken: false
  ...
```

</p>
</details>

### Disable service account mouting in service account specification

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot
automountServiceAccountToken: false
...
```

</p>
</details>

# Manage Secrets

## Secrets and Pods

### Where is documentation for manage secrets for pods ?

<details>
<summary>show</summary>
<p>

[Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

Concepts > Configuration > Secrets


</p>
</details>

### Using secrets a Files from a Pod

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: mypod
    image: redis
    volumeMounts:
    - name: foo
      mountPath: "/etc/foo"
      readOnly: true
  volumes:
  - name: foo
    secret:
      secretName: mysecret
      optional: false # default setting; "mysecret" must exist
```

</p>
</details>

### Hack a pod secret (env variable)

<details>
<summary>show</summary>
<p>

 - run `crictl ps | grep [PODNAME]` to get the container id
 - then run `crictl inspect [CONTAINERID]` and search for env section

</p>
</details>

### Hack a pod secret (from file)

<details>
<summary>show</summary>
<p>

 - run `crictl ps | grep [PODNAME]` to get the container id
 - then run `crictl inspect [CONTAINERID]` and search for pid element
 - finally run `cat /proc/[PID]/root/[MOUNTPATH]/[SECRETKEY]`

</p>
</details>

### Hack a pod secret with edcd client

<details>
<summary>show</summary>
<p>

`ETCDCTL_API=3 etcdctl ... endpoint and cert infos ... get /registry/secrets/[NAMESPACE]/[SECRETNAME]`

</p>
</details>

## Secrets and Etcd

### Where is documentation for encrypting secrets ?

<details>
<summary>show</summary>
<p>

[Encrypting Secret Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)

Tasks > Administer a Cluster > Encrypting Secret Data at Rest


</p>
</details>

### Create a etc encryption configuration for aescbc and add the capacity to read uncrypted secrets

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <BASE 64 ENCODED SECRET>
      - identity: {}
```

Save that file in etc/kubernetes/etcd/ec.yaml
and generate password with command `echo -n 'password' | base64`

</p>
</details>

### Activate encryption for apiserver etcd

<details>
<summary>show</summary>
<p>

 - Add the `--encryption-provider-config=/etc/kubernetes/etcd/ec.yaml` argument kube-apiserver manifest file (add volume and volumeMount too)
 - Check the logs in /var/log/pods

</p>
</details>

### Replace all secrets to encode existing secret

<details>
<summary>show</summary>
<p>

`k get secret -A -o yaml | k replace -f -`

</p>
</details>