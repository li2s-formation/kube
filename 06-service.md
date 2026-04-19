---
transition: slide-left
---

<br>
<br>
<center>
<img src="/service.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->




---
transition: fade-out
---

# Service

- Gère in ensemble de Pods
- Regroupés à partir de Labels
- Load-Balancing
- Possède une adresse IP privée résolue par un DNS interne 
<br>
<br>
<img src="/kube-svc1.png" width="400" height="500">





---
transition: fade-out
---

# Types de Service

- ClusterIP
    - Expose à l’intérieur du Cluster
    - Accès via le nom du Service
- NodePort
    - Expose à l’extérieur du cluster
    - Accès via des Ports sur les hosts du Cluster
- LoadBalancer
    - Ingress Controlrer
    - Spécifique aux Cloud Provider
- ExternalName
    - Alias vers un Service externe au Cluster
    



---
transition: fade-out
---

# ClusterIP

- Expose à l’intérieur du Cluster
- Accès via le nom du Service
- Algorithme Random
- Session Affinity
    - <span style="font-family:'Courier New'">None</span>:  par défaut, pas d’affinité entre le client et le serveur (pod)
    - <span style="font-family:'Courier New'">ClientIP</span>:  affinité entre le client et le serveur





---
transition: fade-out
---

# ClusterIP

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

- Spécification du Service 

```bash
$ cat web-service.yml 
```
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 80
```


</ul>
</div>

<div>
<ul style="list-style-type:square;">


<v-clicks at="1">
<arrow x1="380" y1="230" x2="220" y2="230" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
<br>
<br>
<br>
Type de l'objet
</v-click>
</v-clicks>


<v-clicks at="2">
<arrow x1="380" y1="260" x2="220" y2="260" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Nom de l'objet service
</v-click>
</v-clicks>


<v-clicks at="3">
<arrow x1="380" y1="300" x2="220" y2="300" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Selecteur de groupe de Pods
</v-click>
</v-clicks>


<v-clicks at="4">
<arrow x1="380" y1="320" x2="220" y2="320" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
Clé: Valeur du selecteur
</v-click>
</v-clicks>


<v-clicks at="5">
<arrow x1="380" y1="340" x2="220" y2="340" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
type du service
</v-click>
</v-clicks>


<v-clicks at="6">
<arrow x1="380" y1="380" x2="220" y2="380" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
port exposé dans le cluster
</v-click>
</v-clicks>

<v-clicks at="7">
<arrow x1="380" y1="400" x2="220" y2="400" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
port cible d’un Pod du groupe 
</v-click>
</v-clicks>

</ul>
</div>
</div>






---
transition: fade-out
---

# ClusterIP

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

- Spécification du Pod à regrouper 

```bash
$ cat web.yml 
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: www
  labels:
    app: web
spec:
  containers:
  - name: www
    image: nginx:1.17
```


</ul>
</div>

<div>
<ul style="list-style-type:square;">


<v-clicks at="1">
<arrow x1="380" y1="290" x2="220" y2="290" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
<br>
<br>
<br>
<br>
<br>
Label de regroupement
</v-click>
</v-clicks>


</ul>
</div>
</div>







---
transition: fade-out
---

# NodePort

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

- Spécification du Service 

```bash
$ cat web-service.yml 
```
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30000
```


</ul>
</div>

<div>
<ul style="list-style-type:square;">



<v-clicks at="1">
<arrow x1="380" y1="340" x2="220" y2="340" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
type du service
</v-click>
</v-clicks>


<v-clicks at="2">
<arrow x1="380" y1="380" x2="220" y2="380" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
port exposé dans le cluster
</v-click>
</v-clicks>

<v-clicks at="3">
<arrow x1="380" y1="400" x2="220" y2="400" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
port cible d’un Pod du groupe 
</v-click>
</v-clicks>



<v-clicks at="4">
<arrow x1="380" y1="420" x2="220" y2="420" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<v-click>
<br>
port exposé par les noeuds à l'extérieur du cluster
</v-click>
</v-clicks>



</ul>
</div>
</div>

