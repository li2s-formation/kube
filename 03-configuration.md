---
transition: slide-left
---

<br>
<br>
<center>
<img src="/configuration.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->


---
transition: fade-out
---

# Context

<br>

<div>
<ul style="list-style-type:square;">


## Context d’utilisation
- Définit le cluster k8s cible
- Définit l’utilisateur
## Plusieurs contexts peuvent être disponibles
- Un seul context actif indiqué par CURRENT *


```bash
$ kubectl config get-contexts
```
```
CURRENT   NAME                             CLUSTER         AUTHINFO           NAMESPACE
*         kubernetes-admin@cluster.local   cluster.local   kubernetes-admin   

```

</ul>
</div>

---
transition: fade-out
---

# Configuration

<br>

<div>
<ul style="list-style-type:square;">

## Context utilisé par kubectl dans l’ordre de priorité

<br> 

1. Option de la commande<br>
    <p style="font-family:'Courier New'">
    --kubeconfig
    </p> spécifie un fichier de config

2. Variable d’environnement<br>
$KUBECONFIG

3. Fichier kubeconfig par défaut<br>
$HOME/.kube/config
</ul>
</div>


---
transition: fade-out
---

# Context de configuration

<br>

<div>
<ul style="list-style-type:square;">

```bash
$ kubectl config view
```
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://host11:6443
  name: cluster.local
contexts:
- context:
    cluster: cluster.local
    user: kubernetes-admin
  name: kubernetes-admin@cluster.local
current-context: kubernetes-admin@cluster.local
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
```

</ul>
</div>



---
transition: fade-out
---

# Commandes de Context

<br>

<div>
<ul style="list-style-type:square;">

## Lister les contexts
```bash
$ kubectl config get-contexts
```
```
CURRENT   NAME                             CLUSTER         AUTHINFO           NAMESPACE
*         kubernetes-admin@cluster.local   cluster.local   kubernetes-admin
          minikube                         minikube        minikube 
```

## Changer de context
```bash
$ kubectl config use-context minikube
```
```
Switched to context "minikube"
```

## Supprimer un context
```bash
$ kubectl config delete-context minikube
```
```
deleted context minikube from /Users/samir/.kube/config
```

</ul>
</div>

