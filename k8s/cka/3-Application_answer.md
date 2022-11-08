# Rollout

## Commands

`kubectl rollout status mydeploy`

`kubectl rollout history mydeploy`

## Strategies

### Recereate

Kill them all pods then recreate

### Rolling update

Update pod on by one (default strategy)

## Update image

`kubectl set image mydeploy image --record`

## Rollback

`kubectl rollout undo mydeploy`

# Commands

In the definition of the pod/spec/containers/name add :

```yaml
command: ["sleep"]
args: ["myarg"]
```

EntryPoint DockerFile instruction correspond to command and CMD DockerFile instruction  correspond to args.

# Environment variables

## With value

In the definition of the pod/spec/containers/name add

```yaml
env:
  - name: ENV1
    value: MYVALUE
  ...
```

## From config map

### Create config map by command

`kubectl create configmap myconfig --from-literal=KEY1=VALUE1 --from-literal=KEY2=VALUE2 etc...`

OR

`kubectl create configmap myconfig --from-file=myconfig.properties`

### Create config map with Yaml

```yaml
apiVersion: v1
king: ConfigMap
metadata:
  name: myconfig
data:
  KEY1: VALUE1
  KEY2: VALUE2
```

### Get config map

`kubectl get configmaps`

`kubectl describe configmap myconfig`

### Specify a config map to a pod

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

## With Secrets

### Create secret by command

`kubectl create secret generic mysecret --from-literal=KEY1=VALUE1  --from-literal=KEY2=VALUE2 ...`

OR

`kubectl create secret generic mysecret --from-file=secret.properties`

### Create secret  with Yaml

```yaml
apiVersion: v1
king: Secret
metadata:
  name: mysecrets
data:
  KEY1: VALUE1
  KEY2: VALUE2
```

Values must be encoded like this :
`echo -n 'VALUE1' | base64`

### Get secret

`kubectl get secrets`

`kubectl describe secrets mysecrets`

### Get a value of a secret

kubectl get secrets mysecrets -o yaml

Then : 

`echo -n 'bXlzcUe=' | base64 --decode`

### Specify a secret to a pod

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

# Pod lifecyle

```yaml
spec:
  containers:
  - name: lifecycle-demo-container
    image: nginx
    lifecycle:
      postStart:
        exec:
          command: ["/bin/sh", "-c", "echo Hello from the postStart handler > /usr/share/message"]
      preStop:
        exec:
          command: ["/bin/sh","-c","nginx -s quit; while killall -0 nginx; do sleep 1; done"]
```

# Init container

In the pod definition : 

```yaml
spec:
   initContainers:
   - name: init-myservice
     image: busybox    
     command: ['sh', '-c', 'git clone ...; done;']
```

