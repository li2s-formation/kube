---
transition: slide-left
---

<br>
<br>
<center>
<img src="/namespace.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->



---
transition: fade-out
---

# Namespace

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

- Isoler les ressources
    - Pods 
    - Services
    - Deployments
- Segmenter un Cluster
    - Departements
    - Projets
    - Clients

</ul>
</div>


<div>
<ul style="list-style-type:square;">

```bash
$ kubectl get namespaces
```
```
NAME              STATUS   AGE
default           Active   46h
kube-public       Active   46h
kube-system       Active   46h
```

</ul>
</div>

</div>



---
transition: fade-out
---

# Création

- En ligne de commande

```bash
$ kubectl create namespace production
```
```
namespace/production created
```


- A partir d’un fichier de spécification

```bash
$ cat production.yml 
```
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

```bash
$ kubectl apply -f production.yml
```
```
namespace/production created
```



---
transition: fade-out
---

# Désignation du Namespace  1/3

- Le namespace est assigné dans les metadatas du fichier de spécifications

```bash
$ cat web.yml 
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
  namespace: production
spec:
  containers:
  - name: www
    image: nginx:1.17
```

- Création du Pod

```bash
$ kubectl apply -f web.yml
```
```
pod/web created
```


---
transition: fade-out
---

# Désignation du Namespace  2/3

- Le namespace est assigné lors de la création en ligne de commande

```bash
$ cat web.yml 
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
spec:
  containers:
  - name: www
    image: nginx:1.17
```

- Création du Pod

```bash
$ kubectl apply -f web.yml --namespace=production
```
```
pod/web created
```


---
transition: fade-out
---

# Désignation du Namespace  3/3

- Le namespace est assigné dans le context

```bash
$ kubectl config set-context prod --cluster=cluster1 --user=kubernetes-admin --namespace=production
```
```
Context "prod" created.
```

```bash
$ kubectl config view
```
```
apiVersion: v1
clusters:
- cluster:
    server: https://host11:6443
  name: cluster1
contexts:
- context:
    cluster: cluster1
    user: kubernetes-admin
  name: kubernetes-admin@cluster1
- context:
    cluster: cluster1
    namespace: production
    user: kubernetes-admin
  name: prod
```


---
transition: fade-out
---

# Ressource Quota

- Permet de limiter la consommation de certaines ressources

    - <span style="font-family:'Courier New'">limits.cpu:</span> CPU maximum consommée par l’ensemble des pods du namespace 
    - <span style="font-family:'Courier New'">limits.memory:</span> RAM maximum consommée par l’ensemble des pods
    - <span style="font-family:'Courier New'">requests.cpu:</span> CPU minimum requise par l’ensemble des pods du namespace 
    - <span style="font-family:'Courier New'">requests.memory:</span> RAM minimum requise par l’ensemble des pods du namespace 




---
transition: fade-out
---

# Ressource Quota

- Créer une ressource Quota

```bash
$ cat rq-dev.yml
```
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: dev-quota
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
```


---
transition: fade-out
---

# Ressource Quota

- Appliquer les quotas à un namespace

```bash
$ kubectl apply –f rq-dev.yml --namespace development
```
```
resourcequota/dev-quota created
```

- Lire les consommations des quotas

```bash
$ kubectl get resourcequota --namespace development
```
```
NAME        AGE   REQUEST                                     LIMIT
dev-quota   57s   requests.cpu: 0/1, requests.memory: 0/1Gi   limits.cpu: 0/2, limits.memory: 0/2Gi
```

