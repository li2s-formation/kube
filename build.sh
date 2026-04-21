#!/bin/sh

git add . && git commit -m "first commit" && git push -u origin main

slidev export --output public/k8s-v2.2.pdf
