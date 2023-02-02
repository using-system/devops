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

