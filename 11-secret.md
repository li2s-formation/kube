---
transition: slide-left
---

<br>
<br>
<center>
<img src="/kube-secrets.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->




---
transition: fade-out
---

# Secrets

- Protection des données
    - mots de passe
    - clés privées
- Sortir les informations sensibles des images ou des fichiers de spécification
- Plus de contrôle de leur utilisation
- Objet créé par l’utilsateur ou le système
- Utilisé dans un Pod
- Stocké dans etcd



---
transition: fade-out
---

# Types

- Generic
    - fichier
    - répertoire
    - valeur litérale
- Docker-registry
    - Authentification à Registre Docker
- TLS
    - Gestion de clés



---
transition: fade-out
---

# Création à partir de fichier ou littéral

```bash
$ cat pass.txt 
```
```
password=myP@ssw.rd
```

```bash
$ kubectl create secret generic secret1 --from-env-file=pass.txt
```
```
secret/secret1 created
```
```bash
$ kubectl create secret generic secret2 --from-literal password=myP@ssw.rd
```
```
secret/secret2 created
```
```bash
$ kubectl get secrets
```
```
NAME                  TYPE                                  DATA   AGE
secret1               Opaque                                2      3m21s
secret2               Opaque                                2      8s
```


---
transition: fade-out
---

# Secret

```bash
$ kubectl get secret secret1 -o yaml
```
```
apiVersion: v1
data:
  password: bXlQQHNzdy5yZA==
kind: Secret
metadata:
  creationTimestamp: "2026-04-21T06:34:35Z"
  name: secret1
  namespace: default
  resourceVersion: "209118"
  uid: 3fbdc6b8-2661-4c5e-beff-d3a3d77e2a81
```



---
transition: fade-out
---

# Utilisation comme Variable d’environnement

```bash
$ cat redis.yml
```
```yaml
apiVersion: v1 
kind: Pod 
metadata: 
  name: secret-env-pod
spec:  
 containers:
 - name: mycontainer 
   image: redis
   env:
      - name: SECRET_PASSWORD
        valueFrom: 
          secretKeyRef:
            name: secret1
            key: password
```


---
transition: fade-out
---

# Utilisation comme Volume

```bash
$ cat certs.yml
```
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
    - name: certs
      mountPath: "/etc/certs" 
      subPath: "certs"
      readOnly: true
  volumes: 
  - name: certs 
    secret: 
      secretName: secret3
```


