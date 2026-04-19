---
transition: slide-left
---

<br>
<br>
<center>
<img src="/deployment.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->





---
transition: fade-out
---

# ReplicaSet

<br>

<div class="grid grid-cols-2">

<div>
<ul style="list-style-type:square;">

- Spécification du Service 
    - ReplicaSet
    - gère des Pods de même spécification
    - s’assure de l’état et du nombre souhaité de replicas
- Load Balancing 
- Scaling
</ul>
</div>


<div>
<ul style="list-style-type:square;">


<div>
<img v-click="[1]" style="position:absolute;width:277px;top:100px;left:460px" src="/rs1.png">
</div>

<div>
<img v-click="[2]" style="position:absolute;width:277px;top:100px;left:460px" src="/rs2.png">
</div>

<div>
<img v-click="[3]" style="position:absolute;width:400px;top:100px;left:460px" src="/rs3.png">
</div>

</ul>
</div>

</div>





---
transition: fade-out
---

# ReplicaSet

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

- Spécification du ReplicaSet 

```bash
$ cat myapp-rs.yml 
```
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      name: myapp
      labels:
        app: myapp
    spec:
      containers:
        - name: myapp
          image: nginx:1.21-alpine
```


</ul>
</div>

<div>
<ul style="list-style-type:square;">



<v-clicks at="1">
<arrow x1="380" y1="320" x2="220" y2="320" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
sélection par le Label des Pods gérés par le ReplicaSet
</v-click>
</v-clicks>


<v-clicks at="2">
<arrow x1="380" y1="410" x2="220" y2="410" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
<br>
<br>
<br>
label du pod
</v-click>
</v-clicks>



</ul>
</div>
</div>





---
transition: fade-out
---

# ReplicaSet

```bash
$ kubectl apply -f myapp-rs.yml 
```
```
replicaset.apps/myapp created
```

```bash
$ kubectl get all -o wide --show-labels
```
```
NAME              READY   STATUS    RESTARTS   AGE     IP               NODE     NOMINATED NODE   READINESS GATES   LABELS
pod/myapp-f44k9   1/1     Running   0          2m43s   10.233.70.133    host13   <none>           <none>            app=myapp
pod/myapp-lx4xt   1/1     Running   0          2m43s   10.233.89.65     host11   <none>           <none>            app=myapp
pod/myapp-prbxh   1/1     Running   0          2m43s   10.233.125.196   host12   <none>           <none>            app=myapp

NAME                    DESIRED   CURRENT   READY   AGE     CONTAINERS   IMAGES              SELECTOR    LABELS
replicaset.apps/myapp   3         3         3       2m43s   myapp        nginx:1.21-alpine   app=myapp   <none>
```






---
transition: fade-out
---

# ReplicaSet

- Selector obligatoire
  - FIELDS: <br>
<span style="font-family:'Courier New'">
    matchExpressions \[\]Object <br>
    matchLabels map\[string\]string <br>
</span>


```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      env: prod
      ver: "1.2"
    matchExpressions:
    - { key: tier, operator: In, values: [frontend] }
    - { key: ver, operator: In, values: ["1.2","1.3"] }
```



---
transition: fade-out
---

# Scale

- Modification du fichier de description et mise à jour 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl replace –f rs-definition.yml
</BLOCKQUOTE>
</p>

- Commande <span style="font-family:'Courier New'">scale</span> et fichier yaml

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl scale --replicas=new-value  –f rs-definition.yml
</BLOCKQUOTE>
</p>

- Commande <span style="font-family:'Courier New'">scale</span> et arguments 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl scale --replicas=new-value  replicaset myapp-rs
</BLOCKQUOTE>
</p>

- Commande <span style="font-family:'Courier New'">patch</span> 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl replace –f rs-definition.yml
</BLOCKQUOTE>
</p>




---
transition: fade-out
---

# Deployment

- Deployment
  - haut niveau d’abstraction
  - gère des ReplicaSet

- ReplicaSet
  - gère des Pods de même spécification
  - s’assure de l’état souhaité des Pods

- Pod instance applicative
  - géré par un ReplicaSet
  - schédulé sur un node du Cluster


<div>
<img v-click="[1]" style="position:absolute;width:277px;top:100px;left:460px" src="/deploy1.png">
</div>

<div>
<img v-click="[2]" style="position:absolute;width:277px;top:100px;left:460px" src="/deploy2.png">
</div>

<div>
<img v-click="[3]" style="position:absolute;width:400px;top:100px;left:460px" src="/deploy3.png">
</div>




---
transition: fade-out
---

# Deployment

- Défini un état souhaité
  - suivant la version d’un Pod
  - du nombre de réplicas désiré

- Associe un ReplicatSet 
  - assure de l’état désiré

- Gère les mise à jour des applications
  - rolling update
  - rollback
  - scaling

<div>
<img v-click="[1]" style="position:absolute;width:400px;top:100px;left:460px" src="/deploy3.png">
</div>

<div>
<img v-click="[2]" style="position:absolute;width:400px;top:100px;left:460px" src="/deploy4.png">
</div>




---
transition: fade-out
---

# Deployment

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">


```bash
$ cat web-deployment.yml 
```
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx:1.17
```


</ul>
</div>

<div>
<ul style="list-style-type:square;">


<v-clicks at="1">
<arrow x1="380" y1="285" x2="220" y2="285" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br><br><br><br><br><br><br>
3 pods désirés<br> 
</v-click>
</v-clicks>


<v-clicks at="2">
<arrow x1="380" y1="310" x2="220" y2="310" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
Selection par le Label des Pods gérés par le ReplicaSet
</v-click>
</v-clicks>


<v-clicks at="3">
<arrow x1="380" y1="350" x2="220" y2="350" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
spécification des Pods
</v-click>
</v-clicks>


<v-clicks at="4">
<arrow x1="380" y1="390" x2="220" y2="390" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
<br>
labels des Pods
</v-click>
</v-clicks>


</ul>
</div>
</div>




---
transition: fade-out
---

# Deployment

```bash
$ kubectl apply -f web-deployment.yml
```
```
deployment.apps/web-deployment created
```

```bash
$ kubectl get deployments
```
```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
web-deployment   3/3     3            3           15s
```

```bash
$ kubectl get replicasets
```
```
NAME                        DESIRED   CURRENT   READY   AGE
web-deployment-67c68c959f   3         3         3       21s
```

```bash
$ kubectl get pods
```
```
NAME                              READY   STATUS    RESTARTS   AGE
web-deployment-67c68c959f-bgm6p   1/1     Running   0          29s
web-deployment-67c68c959f-rgfdn   1/1     Running   0          29s
web-deployment-67c68c959f-w9m6r   1/1     Running   0          29s
```





---
transition: fade-out
---

# Scale

- Modification du fichier de description et mise à jour 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl replace –f deploy-definition.yml
</BLOCKQUOTE>
</p>

- Commande <span style="font-family:'Courier New'">scale</span> et fichier yaml

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl scale --replicas=new-value  –f deploy-definition.yml
</BLOCKQUOTE>
</p>

- Commande <span style="font-family:'Courier New'">scale</span> et arguments 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl scale --replicas=new-value  deploy myapp-deploy
</BLOCKQUOTE>
</p>

- Commande <span style="font-family:'Courier New'">edit</span> 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl edit deploy myapp-deploy
</BLOCKQUOTE>
</p>





---
transition: fade-out
---

# Rolling Update

- Modification du fichier de description et mise à jour 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl replace –f deploy-definition.yml
</BLOCKQUOTE>
</p>

- Modification par la commande <span style="font-family:'Courier New'">set</span>

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl set image deployment deploy_name container_name=new_image
</BLOCKQUOTE>
</p>

- Modification par la commande <span style="font-family:'Courier New'">edit</span>

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl edit deployment deploy_name
</BLOCKQUOTE>
</p>

- Suivre l’évolution de la mise à jour avec la commande <span style="font-family:'Courier New'">status</span>

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl rollout status -w deployment deploy_name
</BLOCKQUOTE>
</p>




---
transition: fade-out
---

# Historique

- Historique des mises à jour  

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl rollout history deployment deploy_name
</BLOCKQUOTE>
</p>

- Détails d’une version de l’historique

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl rollout history deployment deploy_name --revision=number
</BLOCKQUOTE>
</p>





---
transition: fade-out
---

# Rollback

- Modification du fichier de description et mise à jour 

<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl apply –f deploy-manifest.yml
</BLOCKQUOTE>
</p>

- La commande <span style="font-family:'Courier New'">undo</span>
 
<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl rollout undo deployment deploy_name
</BLOCKQUOTE>
</p>

- Rollback vers une version spécifique
 
<p style="font-family:'Courier New'" center>
<BLOCKQUOTE>
kubectl rollout undo deployment deploy_name --to-revision=number
</BLOCKQUOTE>
</p>




---
transition: fade-out
---

# DaemonSet

- Un DaemonSet garantit que tous les nœuds exécutent une copie du pod.
- Lorsque des nœuds sont ajoutés au cluster, des pods leur sont ajoutés.
<br>

<img  style="position:absolute;width:600px;top:200px;left:170px" src="/ds1.png">



---
transition: fade-out
---

# DaemonSet/Use Case

- Exécuter un démon de stockage en cluster, tel que glusterd, ceph, sur chaque nœud.
- Exécuter un démon de collecte de journaux sur chaque nœud, tel que fluentd ou filebeat.
- Exécuter un démon de surveillance sur chaque nœud, tel que Prometheus Node Exporter, Flowmill, Sysdig Agent, collectd, 
<br>

<img  style="position:absolute;width:600px;top:200px;left:170px" src="/ds1.png">



---
transition: fade-out
---

# DaemonSet/Spécification

```bash
$ cat web-ds.yml 
```
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web
        image: nginx:1.17-alpine
```


---
transition: fade-out
---

# DaemonSet/Spécification

```bash
$ kubectl apply -f web-daemonset.yml
```
```
daemonset.apps/web created
```
```bash
$ kubectl get daemonsets
```
```
NAME   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
web    3         3         3       3            3           <none>          2m15s
```


```bash
$ kubectl get pods
```
```
NAME        READY   STATUS    RESTARTS   AGE
web-4mvs6   1/1     Running   0          3m15s
web-4nj8x   1/1     Running   0          3m15s
web-l6w6p   1/1     Running   0          3m15s
```


---
transition: fade-out
---

# Rolling Update et Rollback

- Identique au deployment 

- Stratégie de mise à jour
  - spec:
      <span style="font-family:'Courier New'">updateStrategy</span>:
      - type: RollingUpdate           (valeur par défaut)

      <span style="font-family:'Courier New'">RollingUpdate</span> : les pods sont mis à jour en même temps que le DaemonSet<br>
      <span style="font-family:'Courier New'">OnDelete</span> : les pods sont mis à jour suite à la commande delete<br>


