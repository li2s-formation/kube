---
# try also 'default' to start simple
theme: seriph
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: https://cover.sli.dev
# some information about your slides (markdown enabled)
title: Welcome to Slidev
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
# apply UnoCSS classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: true
# duration of the presentation
duration: 35min
---

# Kubernetes

Mise en Oeuvre

<div @click="$slidev.nav.next" class="mt-12 py-1" hover:bg="white op-10">
  Press Space for next page <carbon:arrow-right />
</div>


<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->


---
src: ./01-introduction.md
---

---
src: ./02-installation.md
---

---
src: ./03-configuration.md
---

---
src: ./04-pods.md
---

---
src: ./05-scheduler.md
---

---
src: ./06-service.md
---

---
src: ./07-deployment.md
---

---
src: ./08-namespace.md
---
src: ./09-volume.md
---

---
src: ./10-configmap.md
---

---
src: ./11-secret.md
---

---
src: ./12-job.md
---


---
src: ./13-helm.md
---
