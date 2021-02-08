#!/bin/bash

# sh init_docker.sh
# sudo usermod -aG docker user42; newgrp docker
# sleep 60
# docker container stop $(docker container ls -aq)
# docker container rm $(docker container ls -aq)
# docker rmi -f $(docker image ls -a -q)

# minikube config set vm-driver virtualbox

# docker-machine create --driver virtualbox default
# docker-machine start
# minikube start --vm-driver=virtualbox

start_service()
{
    docker build -t $1_im srcs/$1
    kubectl apply -f srcs/$1/$1.yaml
}

start_project()
{
    sudo usermod -aG docker user42; newgrp docker
    minikube start --vm-driver=docker
    if [ $? -ne 0 ]
    then
        echo '\033[1;33mminikube: \033[1;39mstarted [\033[1;31mKO\033[1;39m]\033[0m\nexit'
        exit 1
    fi
    echo '\033[1;33mminikube: \033[1;39mstarted [\033[1;32mOK\033[1;39m]\033[0m'
    minikube addons enable dashboard
    minikube addons enable metrics-server
    minikube addons enable metallb 
    if [ $? -ne 0 ]
    then
        kubectl apply -f srcs/metallb/metallb.yaml
    fi
    kubectl apply -f srcs/metallb/metallb-configmap.yaml
    echo '\033[34mLoad Balancer \033[0m[\033[32mOK\033[0m]'
    eval $(minikube docker-env)
    sudo service nginx stop
    echo user42
    start_service nginx
    # eval $(minikube docker-env -u)
}

clean_project()
{
    eval $(minikube docker-env -u)
    minikube delete
    docker rmi -f $(docker image ls -a -q)
}

if [ $1 -eq "restart"]
then
    echo "\033[1;39m$2 restarting ... \033[0m"
    if [$2 -eq "minikube"]
    then
        clean_project
        start_project
    
fi

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
