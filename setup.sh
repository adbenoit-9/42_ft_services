#!bin/bash

minikube delete
echo '\033[1;33mminikube: \033[1;39mdeleted\033[0m'
minikube start --vm-driver=docker
echo '\033[1;33mminikube: \033[1;39mstarted [\033[1;32mOK\033[1;39m]\033[0m'

minikube addons enable metrics-server

kubectl apply -f src/metallb/metallb.yaml
kubectl apply -f src/metallb/metallb-configmap.yaml
echo '\033[34mLoad Balancer \033[0m[\033[32mOK\033[0m]'

kubectl apply -f src/dashboard.yaml
echo '\033[34mDashboard \033[0m[\033[32mOK\033[0m]'
kubectl proxy