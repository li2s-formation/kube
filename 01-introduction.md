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

