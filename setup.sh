#!/bin/bash

# sh init_docker.sh
# sudo usermod -aG docker user42; newgrp dock
# sleep 60
# docker container stop $(docker container ls -aq)
# docker container rm $(docker container ls -aq)
# docker rmi -f $(docker image ls -a -q)

# minikube config set vm-driver virtualbox
minikube delete
# docker-machine create --driver virtualbox default
# docker-machine start
# minikube start --vm-driver=virtualbox

minikube start --vm-driver=docker
echo '\033[1;33mminikube: \033[1;39mstarted [\033[1;32mOK\033[1;39m]\033[0m'

minikube addons enable dashboard
minikube addons enable metrics-server

kubectl apply -f srcs/metallb/metallb.yaml
kubectl apply -f srcs/metallb/metallb-configmap.yaml
echo '\033[34mLoad Balancer \033[0m[\033[32mOK\033[0m]'


eval $(minikube docker-env)
echo user42 | sudo service nginx stop
docker build -t nginx_im srcs/nginx
kubectl apply -f srcs/nginx/nginx.yaml
eval $(minikube docker-env -u)

# cd mysql/
# sh run.sh
# kubectl apply -f mysql.yaml
# cd ../

# cd phpmyadmin/
# sh run.sh
# kubectl apply -f phpmyadmin.yaml
# cd ../

# cd wordpress/
# sh run.sh
# kubectl apply -f wordpress.yaml
# cd ../

# cd ftps/
# sh run.sh
# kubectl apply -f ftps.yaml
# cd ../

# cd grafana/
# sh run.sh
# kubectl apply -f grafana.yaml
# cd ../../

# kubectl apply -f src/dashboard.yaml
# echo '\033[34mDashboard \033[0m[\033[32mOK\033[0m]'
# kubectl proxy
