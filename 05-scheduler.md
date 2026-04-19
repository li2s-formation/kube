---
transition: slide-left
---

<br>
<br>
<center>
<img src="/scheduler.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->



---
transition: fade-out
---

# Labels

## Paires Clé=Valeur
## Attachées aux Objets Kubernetes
- Pods
- Services
- Déploiement
- Nœuds
## Organiser les applications sur le Cluster
## Créés lors du déploiement ou ultérieurement
## Modifiés à tout moment
- ”release” : ”stable” , ”release” : ”test”
- ”environment” : ”dev” , ”environment” : ”production”


---
transition: fade-out
---

# Ajouts de Labels


## Créer un Label

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl label < type > < object >   label_name=value 
</BLOCKQUOTE>
</p>

## Créer un Label sans valeur

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl label < type > < object >   label_name= 
</BLOCKQUOTE>
</p>



## Supprimer un Label

<p style="font-family:'Courier New'">
<BLOCKQUOTE>
kubectl label < type > < object >   label_name- 
</BLOCKQUOTE>
</p>



---
transition: fade-out
---

# Ajouts de Labels (exemples)


## Créer un Label

```bash
$ kubectl label node host13 app.dom.com/disktype=ssd
```
```
node/workhost11 labeled
```


## Visualiser les Labels

```bash
$ kubectl get nodes --show-labels
```
```
NAME     STATUS   ROLES           AGE     VERSION   LABELS
host11   Ready    control-plane   4m35s   v1.34.3   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=host11,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node.kubernetes.io/exclude-from-external-load-balancers=
host12   Ready    <none>          4m1s    v1.34.3   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=host12,kubernetes.io/os=linux
host13   Ready    <none>          4m1s    v1.34.3   app.dom.com/disktype=ssd,beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=host13,kubernetes.io/os=linux
```



---
transition: fade-out
---

# Selecteurs

## Sélection d’objets à partir de Labels
<br>

## Identifie un ensemble spécifique d’objets
<br>

## Deux types
- Equality-based
    - = égalité stricte
    - != différence
- Set-based
    - IN la valeur est dans un ensemble de valeurs définies
    - NOTIN la valeur ne doit pas figurer dans un ensemble de valeurs définies
    - EXISTS détermine seulement si le Label existe ou pas





---
transition: fade-out
---

# nodeName

## Permet de réaliser un scheduling manuel

```bash
$ cat web.yml
```
```
apiVersion: v1
kind: Pod
metadata:
  name: web
spec:
  containers:
  - name: www
    image: nginx:1.17
  nodeName: host13
```




---
transition: fade-out
---

# nodeSelector

## Permet de lancer un Pod sur un nœud ayant un Label spécifique

```bash
$ cat web.yml
```
```
apiVersion: v1
kind: Pod
metadata:
  name: web
spec:
  containers:
  - name: www
    image: nginx:1.17
  nodeSelector:
    disktype: ssd
```



---
transition: fade-out
---

# nodeAffinity

## Permet de lancer un Pod sur un nœud ayant une affinité

```yaml
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/hostname
            operator: In
            values:
            - worker1
            - worker2
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd

```




---
transition: fade-out
---

# podAffinity

- Schéduler un pod par affinité positive avec les autres pods
- Règles hard ou soft
- Clé topologyKey : spécifie le domaine d’exécution (hostname,region,zone)

```yaml
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: security
            operator: In
            values:
            - S1
        topologyKey: kubernetes.io/zone
```




---
transition: fade-out
---

# podAntiAffinity

- Schéduler un pod par affinité négative avec les autres pods
- Règles hard ou soft
- Clé topologyKey : spécifie le domaine d’exécution (hostname,region,zone)

```yaml
spec:
  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: security
              operator: In
              values:
              - S2
          topologyKey: kubernetes.io/hostname
```



---
transition: fade-out
---

# Taints

- Taint est l’inverse de l’affinité
    - Déclaré sur un noeud
    - Permet à un nœud de repousser un pod

<p style="font-family:'Courier New'">
kubectl taint nodes < node_name >  key=value:action
</p>

- Action
<p style="font-family:'Courier New'">
    - NoSchedule<br>
    - PreferNoSchedule<br>
    - NoExecute<br>
</p>


```bash
$ kubectl taint nodes host11 app=db:NoSchedule
```
```
node/host11 tainted
```



---
transition: fade-out
---

# Tolerations

- Les tolérances sont appliquées aux pods 
- Permettent aux pods de tolérer un Taint et d’êtres schédulés sur ces nœuds


```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
  labels:
    app: myapp
spec:
  tolerations:
  - key: "app"
    operator: "Equal"
    value: "db" 
    effect: "NoSchedule"
```




---
transition: fade-out
---

# Complétion

- Completion
  - Commandes, sous-commandes et options
  - ressources


```bash
$ sudo yum install -y bash-completion
```
```
  Installé :
  bash-completion.noarch 1:2.1-6.el7
```
```bash
cat ~/.bashrc
```
```
  source <(kubectl completion bash)
```
```bash
kubectl delete pods <tab>
```
```
  web debug
```



---
transition: fade-out
---

# Ressources

- La commande <span style="font-family:'Courier New'">kubectl api-resources</span> permet de lister les ressources accessibles par l’API


```bash
$ kubectl api-resources
```
```
NAME                                SHORTNAMES   APIVERSION                          NAMESPACED   KIND
bindings                                         v1                                  true         Binding
componentstatuses                   cs           v1                                  false        ComponentStatus
configmaps                          cm           v1                                  true         ConfigMap
endpoints                           ep           v1                                  true         Endpoints
namespaces                          ns           v1                                  false        Namespace
nodes                               no           v1                                  false        Node
persistentvolumeclaims              pvc          v1                                  true         PersistentVolumeClaim
persistentvolumes                   pv           v1                                  false        PersistentVolume
pods                                po           v1                                  true         Pod
resourcequotas                      quota        v1                                  true         ResourceQuota
secrets                                          v1                                  true         Secret
serviceaccounts                     sa           v1                                  true         ServiceAccount
services                            svc          v1                                  true         Service
controllerrevisions                              apps/v1                             true         ControllerRevision
daemonsets                          ds           apps/v1                             true         DaemonSet
deployments                         deploy       apps/v1                             true         Deployment
replicasets                         rs           apps/v1                             true         ReplicaSet
```



---
transition: fade-out
---

# Ressources Documentation

- La commande <span style="font-family:'Courier New'">kubectl explain </span>  permet d’avoir la documentation des ressources

```bash
$ kubectl explain pod.spec.affinity
```
```
KIND:       Pod
VERSION:    v1

FIELD: affinity <Affinity>

DESCRIPTION:
    If specified, the pod's scheduling constraints
    Affinity is a group of affinity scheduling rules.
    
FIELDS:
  nodeAffinity	<NodeAffinity>
    Describes node affinity scheduling rules for the pod.

  podAffinity	<PodAffinity>
    Describes pod affinity scheduling rules (e.g. co-locate this pod in the same
    node, zone, etc. as some other pod(s)).

  podAntiAffinity	<PodAntiAffinity>
    Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in
    the same node, zone, etc. as some other pod(s)).
```











---
transition: fade-out
---

# Mode Dry Run

- La commande <span style="font-family:'Courier New'">kubectl --dry-run</span>  permet de simuler une commande sans modifications

```bash
$ kubectl run --image=nginx web1 --restart=Never --dry-run=client -o yaml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: web1
  name: web1
spec:
  containers:
  - image: nginx
    name: web1
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
```













---
transition: fade-out
---

# Format JSON

- Template JSONPATH <span style="font-family:'Courier New'">https://kubernetes.io/docs/reference/kubectl/jsonpath</span>

```bash
$ kubectl get pods -o json
$ kubectl get pods -o yaml

$ kubectl get pods –o jsonpath='{.items[0]}’
$ kubectl get pods -o=jsonpath='{.items[0].metadata.name}’

$ kubectl get po/web1 -o jsonpath=’{.spec}’
```
<br>
```bash
$ kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}'
```
```
web1	2026-04-17T10:58:55Z
web2	2026-04-17T10:58:56Z
web3	2026-04-17T10:58:58Z
```

