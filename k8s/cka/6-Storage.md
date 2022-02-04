# CSI

Container Storage Interface

Define a rpc standard for CreateVolume, DeleteVolume... and permitt Amazon, Google, Azure... to define theirs plugins to implement their solutions for mount a volume in k8s.

# Volumes

[Volumes | Kubernetes](https://kubernetes.io/docs/concepts/storage/volumes/)

## Yaml definition

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: k8s.gcr.io/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /test-pd
      name: test-volume
  volumes:
  - name: test-volume
    hostPath:
      path: /data 
      type: Directory
```

## HostPath

Problems with hostpath is that the data are stored in a node, not share for all the nodes.

## Others solutions

We can use for example aws storage and replace hostpath by : 

```yaml
volumes:
  - name: test-volume
    awsElasticBlockStore:
      volumeID: "<volume id>"
      fsType: ext4
```

# Persistent Volume

[Persistent Volumes | Kubernetes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

## Definition

Persistent volume permit to decalre the defintion of the volume on time and then the pods can refer it.

## Yaml definition

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```

# Persistent Volume Claims

## Definition

A pvc is bound to a pv to declare what we need for storage use.

Can be remove with the option : Retain (the pv si not deleted but can be used by other pvc), Delete (the pv si deleted), Recycle (the pv si not deleted, the data is recycled and can be used by other pvc).

## Yaml definition

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 8Gi
  storageClassName: slow
```

## Use the pvc in a pod

into the spec of the pod :

```yaml
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim
```

# Storage class

[Storage Classes | Kubernetes](https://kubernetes.io/docs/concepts/storage/storage-classes/)

A storage class permit you to provision the volume automatically with your third party (aws, azure...)

The storage class is defined on the pvc.