#!bin/bash

minikube start --vm-driver=docker
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml
