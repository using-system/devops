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

`kubectl set image mydeploy image`

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
spec:
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



OR by valumes

```yaml
volumes: 
- name: myconfig-volume
  configMap:
    name: myconfig
```

