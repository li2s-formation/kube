---
transition: fade-out
---

# Table des matières

- Introduction
- Installation
- Configuration
- Les Pods
- Le Scheduler
- Les Services
- Les deploiements
- Les Namespace
<br>
<br>


---
transition: slide-left
---

<br>
<br>
<center>
<img src="/intro.png" width="400" height="500">
</center>


---
transition: fade-out
---

# Historique

- Kubernetes ou k8s
- Borg de Google
- Cloud Native Computing Foundation (CNCF)
- Version 1.0 07/2015
- Version 1.35 12/2025
<br>
<br>

---
transition: fade-out
---

# Qu’est ce que Kubernetes

- Orchestrateur
- Gestion d’applications conteneurisées
  - Déploiment
  - Self-healing
  - Montée en charge
  - Mise à jour
- Gestion des configurations
- Gestion des mots de passes (Secrets)
- RBAC
<br>
<br>

---
transition: fade-out
---

# Concepts de base / Cluster

<br>
 
## Cluster Kubernetes

- Ensemble de Nodes
- Linux ou Windows(1.14)
<br>
<br>
<br>
<br>
<br>
<center>
<img src="/cluster1.png">
</center>

---
transition: fade-out
---

# Concepts de base / Pods

<br>
 
## Pods

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">
  <li>Ensemble de conteneurs</li>
  <li>Partage Réseau</li>
  <li>Partage Stockage</li>
</ul>

</div>
<div v-click="4">

```yaml [pod.yml]      
kind: Pod
spec:
  containers:
  - name: web
```
</div>
</div>



<div>
<img v-click="[1]" style="position:absolute;width:60px;top:230px;left:370px" src="/lettre-A.png">
</div>

<div>
<img v-click="[2]" style="position:absolute;width:60px;top:230px;left:650px" src="/lettre-B.png">
</div>

<div>
<img v-click="[3]" style="position:absolute;width:60px;top:230px;left:650px" src="/lettre-C.png">
</div>


<br>
<br>
<center>
<img src="/cluster2.png">
</center>



<arrow v-click="[1]" x1="370" y1="280" x2="280" y2="350" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<arrow v-click="[2]" x1="650" y1="280" x2="560" y2="350" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<arrow v-click="[3]" x1="710" y1="280" x2="840" y2="350" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<arrow v-click="[3]" x1="710" y1="280" x2="840" y2="445" color="rgb(51, 139, 153)" width="3" arrowSize="7" />


---
transition: fade-out
---

# Concepts de base / Deployment

<br>
 
## Deployment

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">
<li>Définit la gestion d’un Pod</li>
<li>Replicas</li>
<li>Mise à Jour</li>
</ul>
</div>
<div>


```yaml [deploy.yml]      
kind: Deployment
spec:
  replicas: 2
```

</div>
</div>

<br>
<br>
<center>
<img src="/cluster3.png">
</center>

<arrow x1="590" y1="260" x2="550" y2="330" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<arrow x1="590" y1="260" x2="700" y2="330" color="rgb(51, 139, 153)" width="3" arrowSize="7" />


---
transition: fade-out
---

# Concepts de base / Service

<br>
 
## Service

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">
<li>Permet d’exposer les ports d’un Pod</li>
<li>A l’intérieur du Cluster</li>
<li>A l’extérieur du Cluster</li>
</ul>
</div>
<div>


```yaml [service.yml]      
kind: Service
spec:
  ports:
  - port: 8080
    targetPort: 80
```

</div>
</div>

<br>
<br>
<center>
<img src="/cluster4.png">
</center>

<arrow x1="620" y1="290" x2="550" y2="365" color="rgb(51, 139, 153)" width="3" arrowSize="7" />
<arrow x1="620" y1="290" x2="700" y2="365" color="rgb(51, 139, 153)" width="3" arrowSize="7" />

---
transition: fade-out
---

# Concepts de base / Clients

<br>
 
## Clients

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">
<li>CLI : <font face="Courier New">kubectl</font></li>
<li>BUI : <font face="Courier New">dashboard</font></li>
<li>Fichier : <font face="Courier New">config</font></li>
<li>Gestion des Accès <font face="Courier New">Users/Access</font></li>
</ul>
</div>
<div>

```bash       
$ kubectl

$ ls ~/.kube
config
```
</div>
</div>

<br>
<br>
<center>
<img src="/cluster4.png">
</center>





---
transition: fade-out
---

# Concepts de base / Nodes

<br>

<div class="grid grid-cols-2">
<div>
<ul style="list-style-type:square;">

## Master
<li>Gestion du cluster</li>
<li>Orchestre l’exécution des Pods sur les Nodes</li>
<li>Expose l’API server</li>
</ul>
</div>
<div>
<ul style="list-style-type:square;">

## Worker
<li>Exécute les Pods du cluster</li>
<li>Fournit les ressources aux Pods</li>
<li>Communique avec le Master</li>

</ul>
</div>
</div>

<br>
<br>

```bash       
$ kubectl get nodes
```
```
NAME STATUS ROLES AGE VERSION
master Ready master 2d20h v1.15.3
worker1 Ready <none> 2d20h v1.15.3
worker2 Ready <none> 2d15h v1.15.3
```




---
transition: fade-out
---

# Concepts de base / Process

 
<center>
<img src="/cluster5.png">
</center>

