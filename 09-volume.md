---
transition: slide-left
---

<br>
<br>
<center>
<img src="/kube-volumes.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->




---
transition: fade-out
---

# Volumes

- Extérieur au container
- Cycle de vie indépendant
- Persistance des données
- Partage de volume entre containers d’un même Pod
- Plusieurs types disponibles
  - emptyDir
  - configMap
  - iscsi
  - nfs
  - cephfs


---
transition: fade-out
---

# EmptyDir

- Lié au cycle de vie d’un Pod
- Vide à la création

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
spec:
  containers:
  - name: mysql
    image: mysql:7.5
    volumeMounts:
    - name: data
      mountPath: /var/lib/mysql
  volumes:
  - name: data
    emptydir:
```



---
transition: fade-out
---

# hostPath

- Monter un répertoire ou un fichier du hôte 

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
spec:
  containers:
  - name: mysql
    image: mysql:7.5
    volumeMounts:
    - name: data
      mountPath: /var/lib/mysql
  volumes:
  - name: data
    hostPath: 
      path: /data/db
```


---
transition: fade-out
---

# NFS

- Monter un partage NFS

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
spec:
  containers:
  - name: mysql
    image: mysql:7.5
    volumeMounts:
    - name: data
      mountPath: /var/lib/mysql
  volumes:
  - name: data
    nfs:
      server: 192.168.1.1 
      path: /data/db
```



---
transition: fade-out
---

# Fibre Channel

- Volume de type SAN

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
spec:
  containers:
  - name: mysql
    image: mysql:7.5
    volumeMounts:
    - name: data
      mountPath: /var/lib/mysql
  volumes:
  - name: data
    fc:
      targetWWNs:
      - XXXXXXXXXX
      lun: 0
      fstype: ext4
```


---
transition: fade-out
---

# iSCSI

- Volume de type iSCSI

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
spec:
  containers:
  - name: mysql
    image: mysql:7.5
    volumeMounts:
    - name: data
      mountPath: /var/lib/mysql
  volumes:
  - name: data
    iscsi:
      iqn: iqn.2001-08.com.netapp.xxxx
      lun: 0
      fstype: ext4
```



---
transition: fade-out
---

# Persistent Volume

- Persistent Volume
  - Stockage provisionné
  - Statique
  - Dynamique

- Persistent Volume Claim
  - Demande de Stockage
  - Spécifie des Contraintes
      - taille, type …
  - Consomme un PV existant ou provisionnement PV par StorageClass
  - Référencé dans un Pod



---
transition: fade-out
---

# Exemple statique 1/3

```bash
$ cat pv.yml 
```
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: manual
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /data/pv
```
```bash
$ kubectl apply -f pv.yml
```
```
persistentvolume/pv created
```
```bash
$ kubectl get pv
```
```
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     5Gi        RWO            Retain           Available           manual                  8s
```



---
transition: fade-out
---

# Exemple statique 2/3

```bash
$ cat pvc.yml 
```
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```
```bash
$ kubectl apply -f pvc.yml
```
```
persistentvolumeclaim/claim created
```
```bash
$ kubectl get pvc
```
```
NAME    STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
claim   Bound    pv       5Gi        RWO            manual         6s
```


---
transition: fade-out
---

# Exemple statique 3/3

```bash
$ cat pod.yml 
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
spec:
  containers:
  - name: mysql
    image: mysql:7.5
    volumeMounts:
    - name: data
      mountPath: /var/lib/mysql
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: claim

```
