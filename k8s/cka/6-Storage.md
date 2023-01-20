# CSI

### Definition of CSI

<details>
<summary>show</summary>
<p>

Container Storage Interface

Define a rpc standard for CreateVolume, DeleteVolume... and permitt Amazon, Google, Azure... to define theirs plugins to implement their solutions for mount a volume in k8s.

</p>
</details>


# Volumes

### Where is doc of Volumes

<details>
<summary>show</summary>
<p>


[Volumes | Kubernetes](https://kubernetes.io/docs/concepts/storage/volumes/)

Concept > Storage > Volumes

</p>
</details>

### Yaml definition for hostpath

<details>
<summary>show</summary>
<p>

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

</p>
</details>

### Hostpath : avantage / problems

<details>
<summary>show</summary>
<p>

Problems with hostpath is that the data are stored in a node, not share for all the nodes.

</p>
</details>

### Alternatives solution to hostpath

<details>
<summary>show</summary>
<p>

We can use for example aws storage and replace hostpath by : 

```yaml
volumes:
  - name: test-volume
    awsElasticBlockStore:
      volumeID: "<volume id>"
      fsType: ext4
```

</p>
</details>


# Persistent Volume

### Where is doc of Persitent volume

<details>
<summary>show</summary>
<p>

[Persistent Volumes | Kubernetes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

Concept > Storage > Persitent Volumes

</p>
</details>

### Definition

<details>
<summary>show</summary>
<p>

Persistent volume permit to decalre the defintion of the volume on time and then the pods can refer it.

</p>
</details>

### Yaml definition

<details>
<summary>show</summary>
<p>

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

</p>
</details>


# Persistent Volume Claims

### Definition

<details>
<summary>show</summary>
<p>

A pvc is bound to a pv to declare what we need for storage use.


</p>
</details>

### Different mode to remove pvc

<details>
<summary>show</summary>
<p>

Can be remove with the option : Retain (the pv si not deleted but can not be used by other pvc), Delete (the pv si deleted), Recycle (the pv si not deleted, the data is recycled and can be used by other pvc).

</p>
</details>

### Yaml definition

<details>
<summary>show</summary>
<p>

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

</p>
</details>

### Use the claims in a pod

<details>
<summary>show</summary>
<p>

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

</p>
</details>


# Storage class

### Where is doc of storage class

<details>
<summary>show</summary>
<p>

[Storage Classes | Kubernetes](https://kubernetes.io/docs/concepts/storage/storage-classes/)

Concept > Storage > Storage classes

</p>
</details>

### Definition

<details>
<summary>show</summary>
<p>

A storage class permit you to provision the volume automatically with your third party (aws, azure...)

</p>
</details>

### Where is define the storage class

<details>
<summary>show</summary>
<p>

The storage class is defined on the pvc.

</p>
</details>
