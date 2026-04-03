---
transition: slide-left
---

<br>
<br>
<center>
<img src="/pods.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->



---
transition: fade-out
---

# Catégories de ressources

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

## Gestion des Applications
- Pod
- ReplicaSet
- Deployment
## Load balancing
- Service
## Configuration des Applications
- ConfigMap
- Secret

</ul>
</div>

<div>
<ul style="list-style-type:square;">

## Stockage
- Persistent Volume
- Persistent Volume Claim
## Configuration du Cluster
- Metadata
- Namespace
- Roles

</ul>
</div>
</div>


---
transition: fade-out
---

# Clés de définition

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

## apiVersion
- v1
- apps/v1
## kind
- Pod
- Deployment
## metadata
- name
- labels

</ul>
</div>

<div>
<ul style="list-style-type:square;">

## spec
- containers
- replicas

## exemple
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: www
  image: nginx:1.12.2
```

</ul>
</div>
</div>





---
transition: fade-out
---

# Pod

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

## Unité de déploiement applicative
## Ensemble de conteneurs
- même contexte d’isolation
- même stack réseau
- mêmes volumes partagés
- même adresse IP dédiée
- des spécification d’exécution
## Ephémères
## Best Practice : 1 Pod = 1 Container


</ul>
</div>

<div>
<ul style="list-style-type:square;">

<img src="/pod11.png">

</ul>
</div>
</div>



---
transition: fade-out
---

# Pod

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

## Une Application 
- découpée en 1 ou plusieurs Pods
- chaque Pod fournit un service

<br>

## Scalling horizontal

</ul>
</div>

<div>
<ul style="list-style-type:square;">

<img src="/pod11.png">

</ul>
</div>
</div>




---
transition: fade-out
---

# Exemple de Spécification

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

## Spécification au format YML ou JSON

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
<v-clicks at="7">
```yaml
  - name: debug
    image: alpine:3.12
```
</v-clicks>


</ul>
</div>

<div>
<ul style="list-style-type:square;">


<v-clicks at="1">
<arrow x1="380" y1="250" x2="220" y2="250" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<br>
<br>
<br>
<br>
<v-click>
Version de l'API
</v-click>
</v-clicks>

<v-clicks at="2">
<arrow x1="380" y1="270" x2="220" y2="270" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Type de l'objet
</v-click>
</v-clicks>


<v-clicks at="3">
<arrow x1="380" y1="310" x2="220" y2="310" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br><br>
Nom de l'objet
</v-click>
</v-clicks>


<v-clicks at="4">
<arrow x1="380" y1="340" x2="220" y2="340" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Spécifications des conteneurs
</v-click>
</v-clicks>


<v-clicks at="5">
<arrow x1="380" y1="360" x2="220" y2="360" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Nom du premier conteneur
</v-click>
</v-clicks>


<v-clicks at="6">
<arrow x1="380" y1="380" x2="220" y2="380" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Image du premier conteneur
</v-click>
</v-clicks>


<v-clicks at="7">
<arrow x1="380" y1="420" x2="220" y2="420" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Deuxième conteneur
</v-click>
</v-clicks>

</ul>
</div>
</div>







---
transition: fade-out
---

# Création d’un Pod

<br>

<div>
<ul style="list-style-type:square;">

## Créer un Pod

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl create –f SPEC.yml
<br>
kubectl apply –f SPEC.yml
</BLOCKQUOTE>
</p>

```bash 
$ kubectl apply -f  web.yml
```
```
pod/web created 
```

## Lister les Pods

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl get pods
</BLOCKQUOTE>
</p>

```bash 
$ kubectl get pod
```
```
NAME  READY   STATUS    RESTARTS    AGE
web   1/1     Running   0           41s
```

</ul>
</div>




---
transition: fade-out
---

# Pod / Etats

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

## Etas d'un Pod

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
Pending
</BLOCKQUOTE>
</p>
Le Pod est en attente (manque une affinité)

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
Running
</BLOCKQUOTE>
</p>
Le Pod est en exécution
<br>
<br>

```bash 
$ kubectl get po
```
```
NAME  READY STATUS            RESTARTS  AGE
web   0/1   ContainerCreating 0         2s
```

</ul>
</div>
<div>
<ul style="list-style-type:square;">

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
CrashLoopBackOff
</BLOCKQUOTE>
</p>
Trop de restart
<br>


<p style="font-family:'Courier New'">
<BLOCKQUOTE>
CrashPullBackOff
</BLOCKQUOTE>
</p>
Erreur de pull
<br>


<p style="font-family:'Courier New'">
<BLOCKQUOTE>
Succeeded
</BLOCKQUOTE>
</p>
Pod terminé avec succès, pas de restart
<br>


<p style="font-family:'Courier New'">
<BLOCKQUOTE>
Failed
</BLOCKQUOTE>
</p>
Pod terminé avec erreur, pas de restart
<br>


</ul>
</div>
</div>






---
transition: fade-out
---

# Suppression d’un Pod

<br>

<div>
<ul style="list-style-type:square;">

## Créer un Pod

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl delete pod NAME
</BLOCKQUOTE>
</p>

```bash 
$ kubectl delete web
```
```
pod "web" deleted
```

## Lister les Pods

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl get pods
</BLOCKQUOTE>
</p>

```bash 
$ kubectl get pod
```
```
No resources found.
```

</ul>
</div>






---
transition: fade-out
---

# Description d’un Pod

<div>
<ul style="list-style-type:square;">


<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl describe pod NAME
</BLOCKQUOTE>
</p>

```bash 
$ kubectl describe po web
```
```
Name:             web
Namespace:        default
Priority:         0
Service Account:  default
Node:             host102/192.168.1.102
Start Time:       Sun, 29 Mar 2026 18:39:30 +0200
Labels:           <none>
Annotations:      cni.projectcalico.org/containerID: 479d6a7e1fc88bdb5a6c0a5fc8280ea90d4c3edc3fa92c73929e779d0a835f27
                  cni.projectcalico.org/podIP: 10.233.117.194/32
                  cni.projectcalico.org/podIPs: 10.233.117.194/32
Status:           Running
IP:               10.233.117.194
IPs:
  IP:  10.233.117.194
Containers:
  www:
    Container ID:   containerd://017e7c5d33af240ed2ed8f1050f1e349552dd8a6ffa9907f15eec7141df43e9f
    Image:          nginx:1.17
```

</ul>
</div>



---
transition: fade-out
---

# Description d’un Pod

<div>
<ul style="list-style-type:square;">

## Description (suite)

<br>

```
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  16s   default-scheduler  Successfully assigned default/web to host102
  Normal  Pulling    16s   kubelet            Pulling image "nginx:1.17"
  Normal  Pulled     12s   kubelet            Successfully pulled image "nginx:1.17" in 4.451s (4.451s including waiting). Image size: 51030575 bytes.
  Normal  Created    12s   kubelet            Created container: www
  Normal  Started    12s   kubelet            Started container www

```

</ul>
</div>




---
transition: fade-out
---

# Logs

<div>
<ul style="list-style-type:square;">

## Logs d’un Pod

<br>


<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl logs [-f] pod/NAME [-c CONTAINER]
</BLOCKQUOTE>
</p>

```bash 
$ kubectl logs -f po/web -c www
```
```
127.0.0.1 - - [29/Mar/2026:16:46:58 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.76.1" "-"
127.0.0.1 - - [29/Mar/2026:16:47:24 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.76.1" "-"
127.0.0.1 - - [29/Mar/2026:16:47:25 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.76.1" "-"
127.0.0.1 - - [29/Mar/2026:16:47:28 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.76.1" "-"

```

</ul>
</div>








---
transition: fade-out
---

# Exécution d’une commande

<div>
<ul style="list-style-type:square;">


<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl exec [-it] pod/NAME [-c CONTAINER] -- COMMAND
</BLOCKQUOTE>
</p>

```bash 
$ kubkubectl exec -it web -- bash
```
```
root@web:/#
```

<br>
Lorsque le Pod contient plusieurs conteneurs

```bash 
$ kubkubectl exec -it web -- bash
```
```
Defaulted container "www" out of: www, debug
root@web:/#
```
```bash 
$ kubkubectl exec -it web -c debug -- bash
```
```
root@web:/#
```

</ul>
</div>







---
transition: fade-out
---

# Port Forwarding

<div>
<ul style="list-style-type:square;">


Publie le port d’un Pod sur le poste de contrôle 
<br>
Plutôt utilisée en mode debug/test ou en developpement

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl port-forward POD Host_PORT:CONTAINER_PORT
</BLOCKQUOTE>
</p>


```bash 
$ kubkubectl eport-forward web 8000:80
```

```
Forwarding from 127.0.0.1:8000 -> 80
Forwarding from [::1]:8000 -> 80
Handling connection for 8000
```

<br>

```bash 
$ curl 127.0.0.1:8000
```
```
<!DOCTYPE html>
<html>
<title>Welcome to nginx!</title>
```

</ul>
</div>





---
transition: fade-out
---

# Impérative vs Déclarative


<br>

<div>
<ul style="list-style-type:square;">


## Approche impérative
- Expliciter les étapes à exécuter pour créer l’objet final


<br>

## Approche déclarative
- Déclarer que est le résultat final désiré, sans indiquer le processus pour y parvenir

</ul>
</div>





---
transition: fade-out
---

# Impérative

## Créer un objet en ligne de commande

```bash 
$ kubectl run --image=nginx:1.21-alpine web
```
<br>

## Créer un objet avec un fichier de spécification

```bash 
$ kubectl create –f nginx.yml
```
<br>

## Modifier un objet avec un fichier de spécification

```bash 
$ kubectl replace –f nginx.yml
```




---
transition: fade-out
---

# Déclarative

## Créer un objet avec un fichier de spécification

```bash 
$ kubectl apply –f nginx.yml
```
<br>

## Modifier un objet avec un fichier de spécification

```bash 
$ kubectl apply –f nginx.yml
```
<br>


## Documentation
https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/


<br>








---
transition: fade-out
---

# Déclarative/apply

<div class="grid grid-cols-3">
<div>
<ul style="list-style-type:square;">


Fichier Local


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

</ul>
</div>

<div>
<ul style="list-style-type:square;">

dernière configuration
appliquée
<br>

```json
{
    "kind": "Pod",
    "apiVersion": "v1",
    "metadata": {
        "name": "web",
        "labels": {
            "run": "web"
        }
    },
    "spec": {
        "containers": [
            {
                "name": "web",
                "image": "nginx:1.17",
                "resources": {}
            }
        ],
        "restartPolicy": "Always",
    },
    "status": {}
}
```
</ul>
</div>

<div>
<ul style="list-style-type:square;">

Live Kubernetes
<br>


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

</ul>
</div>


</div>




