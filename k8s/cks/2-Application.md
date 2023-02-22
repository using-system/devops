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

### List local docker images with their sizes

<details>
<summary>show</summary>
<p>

`docker image list`

OR 

`docker image list | grep appname`

</p>
</details>

### Reduce the size of the Dockerfile below

```Dockerfile
FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y golang-go
COPY app.go .
RUN CGO_ENABLED=0 go build app.go
CMD ["./app"]
```

<details>
<summary>show</summary>
<p>

```Dockerfile
# build container stage 1
FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y golang-go
COPY app.go .
RUN CGO_ENABLED=0 go build app.go

# app container stage 2
FROM alpine
COPY --from=0 /app .
CMD ["./app"]
```

</p>
</details>

### How to secure a docker image 

<details>
<summary>show</summary>
<p>

 - Specify base image version
 - Run as non root
 - ReadOnly filesystem access
 - Remove shell access 

```Dockerfile
# build container stage 1
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y golang-go=2:1.13~1ubuntu2
COPY app.go .
RUN pwd
RUN CGO_ENABLED=0 go build app.go

# app container stage 2
FROM alpine:3.12.0
RUN addgroup -S appgroup && adduser -S appuser -G appgroup -h /home/appuser
RUN rm -rf /bin/*
COPY --from=0 /app /home/appuser/
USER appuser
CMD ["/home/appuser/app"]
```

</p>
</details>

## Sandbox

### What is container sandbox

<details>
<summary>show</summary>
<p>

An additional security layer to reduce attack surface. Container sandbox mitigates system calls between the container and kernel.

More resources needed.

</p>
</details>

### Get the kernel linux name inside container

<details>
<summary>show</summary>
<p>

Run the command `uname -r` or `strace uname -r`

The commands inside container or directly in the node produce same result.

</p>
</details>

### What is OCI

<details>
<summary>show</summary>
<p>

Open Container Initiative.

It's a linux foundation project to design specifications for containers and a runtime implementation (implements the specification)

</p>
</details>

### What is CRI

<details>
<summary>show</summary>
<p>

Container Runtime interface.

Allows to communicate with different container runtime.

</p>
</details>

### How to specify the cri in kubelet

<details>
<summary>show</summary>
<p>

`--container-runtime` and `--container-runtime-endpoint` parameters 

</p>
</details>

### How katacontainers sandbox works

<details>
<summary>show</summary>
<p>

Additional isolation with a lightweight VM and individual kernels.

Warning : strong isolation. Runs every container in its own private VM.

</p>
</details>

### How gVisor sandbox works

<details>
<summary>show</summary>
<p>

Provides by Google. 

Additional layer of separation (not vm based like katacontainers) and simulates kernel syscalls with limited features.

The runtime called runsc

</p>
</details>

## Runtime class

### What is a runtime class

<details>
<summary>show</summary>
<p>

It's used by pod to specify witch container runtime is used by the pod.

</p>
</details>

### Where is doc for runtime class

<details>
<summary>show</summary>
<p>

[Runtime Class](https://kubernetes.io/docs/concepts/containers/runtime-class/)

Concepts > Containers > Runtime Class


</p>
</details>

### Create runtime class for gVisor

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: gVisor 
handler: runsc 
```

</p>
</details>

### Get the list of runtime classes

<details>
<summary>show</summary>
<p>

`k get runtimeclass`

</p>
</details>

### Specify runtime class for a pod

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  runtimeClassName: myclass
  # ...

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

# Security context

### Where is documentation for security context

<details>
<summary>show</summary>
<p>

[Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

Tasks > Configure Pods and Containers > Configure a Security Context for a Pod or Container


</p>
</details>

### Get the id of user, group, and fsgroup

<details>
<summary>show</summary>
<p>

`id`

</p>
</details>

### Run container as non root

<details>
<summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-2
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - name: sec-ctx-demo-2
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      runAsNonRoot: false
```

</p>
</details>

### What means privileged container and how activate it

<details>
<summary>show</summary>
<p>

Privileged container means the container user is directory mapped to host user

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-2
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - name: sec-ctx-demo-2
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      privileged: true
```

</p>
</details>

### What means privilege escalation and how activate it

<details>
<summary>show</summary>
<p>

Privilege escalation controls a process can gain mire privileges than parent (activated by default)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-2
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - name: sec-ctx-demo-2
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      allowPrivilegeEscalation: true
```

</p>
</details>