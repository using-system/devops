# Rollout

### Command to get status of a deploy

<details>
<summary>show</summary>
<p>

`kubectl rollout status mydeploy`

</p>
</details>

### Command to get history of a deploy

<details>
<summary>show</summary>
<p>

`kubectl rollout history mydeploy`

</p>
</details>

### List of different strategies of a deploy

<details>
<summary>show</summary>
<p>

Recereate : Kill them all pods then recreate
Rolling update : Update pod on by one (default strategy)

</p>
</details>

### Command to rollback a deploy

<details>
<summary>show</summary>
<p>

`kubectl rollout undo mydeploy`

</p>
</details>

### Command to edit image of a deploy

<details>
<summary>show</summary>
<p>

`kubectl set image --help`

</p>
</details>

  
# Commands

### Specify command and args in yaml definition of a pod

<details>
<summary>show</summary>
<p>

In the definition of the pod/spec/containers/name add :

```yaml
command: ["sleep"]
args: ["myarg"]
```

</p>
</details>

### Entrypoint and Cmd instructions of a DockerFile correspond to wich element in yaml k8s pod spect definition file ?

<details>
<summary>show</summary>
<p>

EntryPoint DockerFile instruction correspond to command and CMD DockerFile instruction  correspond to args.

</p>
</details>


# Environment variables

### Specify value for a env variable in yaml definition of a pod

<details>
<summary>show</summary>
<p>

```yaml
env:
  - name: ENV1
    value: MYVALUE
  ...
```

</p>
</details>

### Command to create a config map  with list of keys/values (literal or with config file)

<details>
<summary>show</summary>
<p>

`kubectl create configmap myconfig --from-literal=KEY1=VALUE1 --from-literal=KEY2=VALUE2 etc...`

OR

`kubectl create configmap myconfig --from-file=myconfig.properties`

</p>
</details>

### Command to get all config maps from current namespace

<details>
<summary>show</summary>
<p>

`kubectl get configmaps`

</p>
</details>

### Command to get details of a config map

<details>
<summary>show</summary>
<p>

`kubectl describe configmap myconfig`

</p>
</details>

### Specify config map in yaml definition of a pod (by name, or with key/value or by volume)

<details>
<summary>show</summary>
<p>

In the definition of the pod/spec/containers/name add

```yaml
envFrom:
  - configMapRef:
      name: myconfig
  ...
```

OR

```yaml
envFrom:
  - configMapKeyRef:
    name: myconfig
    key: KEY1
      ...
```

OR by volumes

```yaml
volumes: 
- name: myconfig-volume
  configMap:
    name: myconfig
```

</p>
</details>

### Command to create a generic secret  with list of keys/values (literal or with config file)

<details>
<summary>show</summary>
<p>

`kubectl create secret generic mysecret --from-literal=KEY1=VALUE1  --from-literal=KEY2=VALUE2 ...`

OR

`kubectl create secret generic mysecret --from-file=secret.properties`

</p>
</details>

### Command to encode secret

<details>
<summary>show</summary>
<p>

`echo -n 'VALUE1' | base64`

</p>
</details>

### Command to get all secrets from current namespace

<details>
<summary>show</summary>
<p>

`kubectl get secrets`

</p>
</details>

### Command to get details of a secret

<details>
<summary>show</summary>
<p>

`kubectl describe secrets mysecrets`

</p>
</details>

### Procedure to get value of a secret

<details>
<summary>show</summary>
<p>

kubectl get secrets mysecrets -o yaml

Then : 

`echo -n 'bXlzcUe=' | base64 --decode`

</p>
</details>

### Specify secret in yaml definition of a pod (by name, or with key/value or by volume)

<details>
<summary>show</summary>
<p>

In the definition of the pod/spec/containers/name add

```yaml
envFrom:
  - secretRef:
      name: mysecrets
  ...
```

OR

```yaml
envFrom:
  - secretKeyRef:
    name: mysecrets
    key: KEY1
      ...
```

OR by volumes

```yaml
volumes: 
- name: myconfig-volume
  secret:
    name: mysecrets
```

</p>
</details>


# Pod lifecyle

### Execute a command after pod start

<details>
<summary>show</summary>
<p>

```yaml
spec:
  containers:
  - name: lifecycle-demo-container
    image: nginx
    lifecycle:
      postStart:
        exec:
          command: ["/bin/sh", "-c", "echo Hello from the postStart handler > /usr/share/message"]
```

</p>
</details>

### Execute a command before the pod stop event

<details>
<summary>show</summary>
<p>

```yaml
spec:
  containers:
  - name: lifecycle-demo-container
    image: nginx
    lifecycle:
      preStop:
        exec:
          command: ["/bin/sh","-c","nginx -s quit; while killall -0 nginx; do sleep 1; done"]
```

</p>
</details>


# Init container

### Specify in pod defintion  init containers with command to specify

<details>
<summary>show</summary>
<p>

In the pod definition : 

```yaml
spec:
   initContainers:
   - name: init-myservice
     image: busybox    
     command: ['sh', '-c', 'git clone ...; done;']
```


</p>
</details>
