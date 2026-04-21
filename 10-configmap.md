---
transition: slide-left
---

<br>
<br>
<center>
<img src="/configMap.png" width="400" height="500">
</center>



<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->




---
transition: fade-out
---

# ConfigMap

- Permet de détacher l’application de sa configuration
- Portabilité
- Créée à partir
    - d’un fichier
    - d’un répertoire
    - de valeurs littérales
- Constituée de
    - une ou plusieurs clé=valeur



---
transition: fade-out
---

# Création

- A partir d’un fichier

```bash
$ cat nginx.conf
```
```
user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  512;
}
```



---
transition: fade-out
---

# Création

- A partir d’un fichier de configuration

```bash
$ kubectl create configmap nginx-conf --from-file=nginx.conf
```
```
configmap/nginx-conf created
```

```bash
$ kubectl get configmap nginx-conf -o yaml
```
```yaml
apiVersion: v1
data:
  nginx.conf: |
    user  nginx;
    worker_processes  auto;

    error_log  /var/log/nginx/error.log warn;
    pid        /var/run/nginx.pid;


    events {
      worker_connections  512;
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2019-10-26T09:48:39Z"
  name: nginx-conf
  namespace: default
```




---
transition: fade-out
---

# Création

- A partir d’un fichier de variables d’environnement

```bash
$ cat conf.env 
```
```
env=prod
log_level=debug
```

```bash
$ kubectl create cm config-env --from-env-file=./conf.env
```
```
configmap/config-env created
```

```bash
$ kubectl get cm config-env -o yaml
```
```yaml
apiVersion: v1
data:
  env: prod
  log_level: debug
kind: ConfigMap
metadata:
  creationTimestamp: "2019-09-23T20:43:35Z"
  name: config-env
  namespace: production
```



---
transition: fade-out
---

# Création

- A partir d’un fichier de valeurs littérales

```bash
$ kubectl create cm config-lit --from-literal env=prod --from-literal log_level=debug 
```
```
configmap/config-lit created
```

```bash
$ kubectl get cm config-lit -o yaml
```
```yaml
apiVersion: v1
data:
  env: prod
  log_level: debug
kind: ConfigMap
metadata:
  creationTimestamp: "2019-09-23T20:43:35Z"
  name: config-lit
  namespace: production
```



---
transition: fade-out
---

# Utilisation dans un Pod

- A partir d’un volume

```bash
$ cat cm-volume.yml 
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
spec:
  containers:
  - name: proxy
    image: nginx:1.17
    ports:
    - containerPort: 8000
    volumeMounts:                  # montage du volume dans le conteneur   
    - name: config
      mountPath: "/etc/nginx/nginx.conf"
      subPath: "nginx.conf"  
  volumes:
  - name: config                   # Définition d’un volume basé sur la ConfigMap nginx-config
    configMap:
      name: nginx-conf
```


---
transition: fade-out
---

# Lancement du Pod

```bash
$ kubectl create -f cm-volume.yml 
```
```
pod/web created
```

```bash
$ kubectl exec -it web bash
```
```
root@web:/# more /etc/nginx/nginx.conf 

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  512;
}

```



---
transition: fade-out
---

# Utilisation dans un Pod

- A partir de variable d’environnement

```bash
$ cat cm-env.yml 
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
    env:
    - name: LOG_LEVEL
      valueFrom:
        configMapKeyRef:
          name: config-env
          key: log_level
    - name: SITE
      valueFrom:
        configMapKeyRef:
          name: config-lit
          key: env

```


---
transition: fade-out
---

# Lancement du Pod

```bash
$ kubectl create -f cm-env.yml 
```
```
pod/web created
```
```bash
$ kubectl exec -it web bash
```
```
root@web:/# env
root@web:/# env
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_SERVICE_PORT=443
LOG_LEVEL=debug
HOSTNAME=web
PWD=/
PKG_RELEASE=1~buster
HOME=/root
KUBERNETES_PORT_443_TCP=tcp://10.233.0.1:443
SITE=prod
NJS_VERSION=0.3.9
TERM=xterm
SHLVL=1
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_ADDR=10.233.0.1
```






